import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;
import '../providers/signal_provider.dart';
import '../services/session_service.dart';
import '../widgets/signal_card.dart';
import '../widgets/session_badge.dart';
import '../utils/constants.dart';
import '../models/signal_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final signalProvider = Provider.of<SignalProvider>(context);
    final currentSession = SessionService.getCurrentSession();
    final now = tz.TZDateTime.now(tz.getLocation('Asia/Tashkent'));

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.cardBackground,
        elevation: 0,
        title: const Text(
          'GoldSignal',
          style: TextStyle(
            color: AppColors.accent,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await signalProvider.loadSignals();
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Vaqt va sessiya
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.cardBackground,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Joriy vaqt (UZT)',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          DateFormat('HH:mm:ss').format(now),
                          style: const TextStyle(
                            color: AppColors.text,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SessionBadge(status: currentSession),
                    const SizedBox(height: 8),
                    Text(
                      SessionService.getNextSessionTime(),
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              
              // Oxirgi signal
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Oxirgi Signal',
                    style: TextStyle(
                      color: AppColors.text,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (signalProvider.signals.isNotEmpty)
                    TextButton.icon(
                      onPressed: () {
                        _showSignalHistory(context, signalProvider);
                      },
                      icon: const Icon(Icons.history, color: AppColors.accent),
                      label: const Text(
                        'Tarix',
                        style: TextStyle(color: AppColors.accent),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 12),
              SignalCard(signal: signalProvider.latestSignal),
              const SizedBox(height: 24),
              
              // Tezkor havolalar
              const Text(
                'Tezkor Havolalar',
                style: TextStyle(
                  color: AppColors.text,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _buildQuickActionCard(
                      icon: Icons.add_chart,
                      label: 'Signal qo\'shish',
                      onTap: () => _showAddSignalDialog(context),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildQuickActionCard(
                      icon: Icons.calculate,
                      label: 'Kalkulyator',
                      onTap: () {
                        DefaultTabController.of(context).animateTo(2);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddSignalDialog(context),
        backgroundColor: AppColors.accent,
        icon: const Icon(Icons.add, color: AppColors.background),
        label: const Text(
          'Signal qo\'shish',
          style: TextStyle(
            color: AppColors.background,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildQuickActionCard({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(icon, color: AppColors.accent, size: 32),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.text,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddSignalDialog(BuildContext context) {
    final signalProvider = Provider.of<SignalProvider>(context, listen: false);
    
    String selectedStrategy = StrategyNames.londonBreakout;
    String selectedDirection = 'LONG';
    final entryController = TextEditingController();
    final slController = TextEditingController();
    final tpController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          backgroundColor: AppColors.cardBackground,
          title: const Text(
            'Yangi Signal',
            style: TextStyle(color: AppColors.text),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Strategiya', style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  initialValue: selectedStrategy,
                  dropdownColor: AppColors.cardBackground,
                  style: const TextStyle(color: AppColors.text),
                  items: [
                    StrategyNames.londonBreakout,
                    StrategyNames.rsiDivergence,
                    StrategyNames.emaBounce,
                  ].map((strategy) {
                    return DropdownMenuItem(
                      value: strategy,
                      child: Text(strategy),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedStrategy = value!;
                    });
                  },
                ),
                const SizedBox(height: 16),
                const Text('Yo\'nalish', style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: _buildDirectionButton(
                        'LONG',
                        selectedDirection == 'LONG',
                        AppColors.longColor,
                        () => setState(() => selectedDirection = 'LONG'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildDirectionButton(
                        'SHORT',
                        selectedDirection == 'SHORT',
                        AppColors.shortColor,
                        () => setState(() => selectedDirection = 'SHORT'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildTextField('Kirish narxi', entryController),
                const SizedBox(height: 12),
                _buildTextField('Stop-Loss', slController),
                const SizedBox(height: 12),
                _buildTextField('Take-Profit 1', tpController),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Bekor qilish', style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              onPressed: () {
                final entry = double.tryParse(entryController.text);
                final sl = double.tryParse(slController.text);
                final tp1 = double.tryParse(tpController.text);

                if (entry != null && sl != null && tp1 != null) {
                  final tp2 = tp1 + 10; // TP2 = TP1 + 10 pip
                  
                  final signal = SignalModel(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    strategy: selectedStrategy,
                    direction: selectedDirection,
                    entryPrice: entry,
                    stopLoss: sl,
                    takeProfit1: tp1,
                    takeProfit2: tp2,
                    createdAt: DateTime.now(),
                  );

                  signalProvider.addSignal(signal);
                  Navigator.pop(context);
                  
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Signal qo\'shildi!'),
                      backgroundColor: AppColors.success,
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accent,
              ),
              child: const Text(
                'Signal qo\'sh',
                style: TextStyle(color: AppColors.background),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDirectionButton(
    String label,
    bool isSelected,
    Color color,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? color.withValues(alpha: 0.2) : Colors.transparent,
          border: Border.all(color: color, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      style: const TextStyle(color: AppColors.text),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.grey),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.accent),
        ),
      ),
    );
  }

  void _showSignalHistory(BuildContext context, SignalProvider provider) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.background,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (context, scrollController) => Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Signal Tarixi',
                    style: TextStyle(
                      color: AppColors.text,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close, color: AppColors.text),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: provider.signals.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: SignalCard(signal: provider.signals[index]),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
