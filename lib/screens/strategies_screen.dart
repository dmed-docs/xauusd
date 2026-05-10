import 'package:flutter/material.dart';
import '../widgets/strategy_rules_card.dart';
import '../utils/constants.dart';

class StrategiesScreen extends StatelessWidget {
  const StrategiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.cardBackground,
          elevation: 0,
          title: const Text(
            'Strategiyalar',
            style: TextStyle(
              color: AppColors.text,
              fontWeight: FontWeight.bold,
            ),
          ),
          bottom: const TabBar(
            indicatorColor: AppColors.accent,
            labelColor: AppColors.accent,
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(text: 'London Breakout'),
              Tab(text: 'RSI Divergensiya'),
              Tab(text: 'EMA Bounce'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildLondonBreakoutTab(),
            _buildRSIDivergenceTab(),
            _buildEMABounceTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildLondonBreakoutTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          StrategyRulesCard(
            title: 'London Breakout',
            isRecommended: true,
            rules: const [
              'Vaqt: 13:00–16:00 UZT (London sessiyasi)',
              'M5 yoki M15 timeframe',
              '05:00–08:00 GMT (10:00–13:00 UZT) orasidagi High va Low ni belgilang',
              'Narx High dan 3–5 pip yuqoriga chiqsa → LONG kirish',
              'Narx Low dan 3–5 pip pastga chiqsa → SHORT kirish',
              'Stop-Loss: 10 pip (diapazonning qarama-qarshi tomonidan)',
              'Take-Profit 1: 20 pip (yarim pozitsiyani yop)',
              'Take-Profit 2: 30 pip (qolganini yop)',
              'TP1 ga yetgach SL ni Breakeven (kirish nuqtasiga) ko\'chir',
              'Katta yangiliklar kunida (NFP, CPI, Fed) — bu strategiyani ishlatma',
            ],
            warnings: const [
              'Osiyo sessiyasida (23:00–13:00 UZT)',
              'Diapazon 60 pipdan katta bo\'lsa',
              'Katta yangilik 30 daqiqa ichida bo\'lsa',
            ],
          ),
          const SizedBox(height: 16),
          _buildInfoCard(
            title: 'Nima uchun bu strategiya kuchli?',
            content:
                'London sessiyasi ochilishi bilan bozorda likvidlik keskin oshadi. '
                'Osiyo sessiyasida yaratilgan diapazondan chiqish (breakout) ko\'pincha '
                'kuchli trend boshlanishini bildiradi. Bu strategiya yuqori ehtimollik '
                'va yaxshi risk/reward nisbatiga ega.',
            icon: Icons.lightbulb_outline,
          ),
        ],
      ),
    );
  }

  Widget _buildRSIDivergenceTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          StrategyRulesCard(
            title: 'RSI Divergensiya',
            rules: const [
              'Indikator: RSI (14)',
              'Timeframe: M5 yoki M15',
              'Narx yangi yuqori yasasa lekin RSI yasamas → SHORT signal',
              'Narx yangi past yasasa lekin RSI yasamas → LONG signal',
              'Stop-Loss: So\'nggi swing high/low + 10 pip',
              'Take-Profit: 20–30 pip',
              'Faqat London yoki NY sessiyasida ishlat',
            ],
          ),
          const SizedBox(height: 16),
          _buildInfoCard(
            title: 'Divergensiya nima?',
            content:
                'Divergensiya — narx va indikator o\'rtasidagi kelishmovchilik. '
                'Bu trend zaiflanishi va teskari harakat boshlanishi signali bo\'lishi mumkin. '
                'RSI divergensiyasi eng ishonchli teskari signal hisoblanadi.',
            icon: Icons.trending_down,
          ),
          const SizedBox(height: 16),
          _buildWarningCard(
            'Diqqat: Divergensiya signallari kamdan-kam uchraydi. '
            'Sabr bilan kutish va faqat aniq divergensiyalarda kirish muhim.',
          ),
        ],
      ),
    );
  }

  Widget _buildEMABounceTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          StrategyRulesCard(
            title: 'EMA Bounce',
            rules: const [
              'Indikatorlar: EMA 20 + EMA 50',
              'H1 da trend aniqlang (EMA 20 EMA 50 dan yuqori = Uptrend)',
              'M5 da narx EMA 20 ga tegib qaytsa → kirish',
              'Long: Uptrend + narx EMA 20 ga tegib yuqoriga qaytsa',
              'Short: Downtrend + narx EMA 20 ga tegib pastga qaytsa',
              'Stop-Loss: EMA 50 dan 10 pip narigi tomonga',
              'Take-Profit: 20–40 pip',
            ],
          ),
          const SizedBox(height: 16),
          _buildInfoCard(
            title: 'Trend-following strategiya',
            content:
                'Bu strategiya mavjud trendni kuzatib boradi. EMA 20 dinamik '
                'support/resistance vazifasini bajaradi. Narx EMA ga tegib qaytganda, '
                'bu trend davom etishining signali bo\'ladi.',
            icon: Icons.show_chart,
          ),
          const SizedBox(height: 16),
          _buildWarningCard(
            'Muhim: Avval H1 da trendni aniqlang! Trendsiz bozorda bu strategiya '
            'yomon ishlaydi. Faqat aniq uptrend yoki downtrend bo\'lganda ishlating.',
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard({
    required String title,
    required String content,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.accent.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.accent.withValues(alpha: 0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.accent, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.accent,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  content,
                  style: const TextStyle(
                    color: AppColors.text,
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWarningCard(String content) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.error.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.error.withValues(alpha: 0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.warning_amber, color: AppColors.error, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              content,
              style: const TextStyle(
                color: AppColors.text,
                fontSize: 14,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
