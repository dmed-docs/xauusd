import 'package:flutter/material.dart';
import '../utils/constants.dart';

class LotCalculatorWidget extends StatefulWidget {
  final double initialBalance;
  final double initialRiskPercent;

  const LotCalculatorWidget({
    super.key,
    required this.initialBalance,
    required this.initialRiskPercent,
  });

  @override
  State<LotCalculatorWidget> createState() => _LotCalculatorWidgetState();
}

class _LotCalculatorWidgetState extends State<LotCalculatorWidget> {
  late TextEditingController _balanceController;
  late TextEditingController _stopLossController;
  double _riskPercent = 1.0;

  @override
  void initState() {
    super.initState();
    _balanceController = TextEditingController(
      text: widget.initialBalance.toStringAsFixed(0),
    );
    _stopLossController = TextEditingController(text: '10');
    _riskPercent = widget.initialRiskPercent;
  }

  @override
  void dispose() {
    _balanceController.dispose();
    _stopLossController.dispose();
    super.dispose();
  }

  double get balance => double.tryParse(_balanceController.text) ?? 0;
  double get stopLossPips => double.tryParse(_stopLossController.text) ?? 10;
  
  double get riskAmount => balance * _riskPercent / 100;
  double get lotSize => stopLossPips > 0 
      ? riskAmount / (stopLossPips * LotConstants.pipValue) 
      : 0;
  double get tp1Profit => lotSize * 20 * LotConstants.pipValue;
  double get tp2Profit => lotSize * 30 * LotConstants.pipValue;
  double get riskRewardRatio => stopLossPips > 0 ? 20 / stopLossPips : 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Lot Kalkulyator',
              style: TextStyle(
                color: AppColors.text,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            
            // Balans input
            _buildInputField(
              label: 'Hisob balansi (\$)',
              controller: _balanceController,
              icon: Icons.account_balance_wallet,
            ),
            const SizedBox(height: 20),
            
            // Risk foizi slider
            const Text(
              'Risk foizi',
              style: TextStyle(
                color: AppColors.text,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.cardBackground,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Risk:',
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                      Text(
                        '${_riskPercent.toStringAsFixed(1)}%',
                        style: const TextStyle(
                          color: AppColors.accent,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Slider(
                    value: _riskPercent,
                    min: 0.5,
                    max: 3.0,
                    divisions: 5,
                    activeColor: AppColors.accent,
                    inactiveColor: Colors.grey,
                    onChanged: (value) {
                      setState(() {
                        _riskPercent = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            
            // Stop-Loss input
            _buildInputField(
              label: 'Stop-Loss (pip)',
              controller: _stopLossController,
              icon: Icons.stop_circle,
            ),
            const SizedBox(height: 24),
            
            // Natijalar
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.cardBackground,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.accent.withValues(alpha: 0.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Natijalar',
                    style: TextStyle(
                      color: AppColors.accent,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildResultRow(
                    'Risk summasi',
                    '\$${riskAmount.toStringAsFixed(2)}',
                    AppColors.error,
                  ),
                  const Divider(color: Colors.grey, height: 24),
                  _buildResultRow(
                    'Lot hajmi',
                    lotSize.toStringAsFixed(2),
                    AppColors.accent,
                    isBold: true,
                  ),
                  const Divider(color: Colors.grey, height: 24),
                  _buildResultRow(
                    'TP1 foyda (20 pip)',
                    '\$${tp1Profit.toStringAsFixed(2)}',
                    AppColors.success,
                  ),
                  const SizedBox(height: 8),
                  _buildResultRow(
                    'TP2 foyda (30 pip)',
                    '\$${tp2Profit.toStringAsFixed(2)}',
                    AppColors.success,
                  ),
                  const Divider(color: Colors.grey, height: 24),
                  _buildResultRow(
                    'Risk/Reward',
                    '1:${riskRewardRatio.toStringAsFixed(1)}',
                    AppColors.text,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            
            // Izoh
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.accent.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Row(
                children: [
                  Icon(Icons.info_outline, color: AppColors.accent, size: 20),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'XAUUSD: 1 lot = \$10/pip, 0.1 lot = \$1/pip',
                      style: TextStyle(
                        color: AppColors.text,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppColors.text,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: AppColors.cardBackground,
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextField(
            controller: controller,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            style: const TextStyle(color: AppColors.text, fontSize: 16),
            decoration: InputDecoration(
              prefixIcon: Icon(icon, color: AppColors.accent),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(16),
            ),
            onChanged: (_) => setState(() {}),
          ),
        ),
      ],
    );
  }

  Widget _buildResultRow(String label, String value, Color color, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 14,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: color,
            fontSize: isBold ? 20 : 16,
            fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
