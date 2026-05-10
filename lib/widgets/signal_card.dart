import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/signal_model.dart';
import '../utils/constants.dart';

class SignalCard extends StatelessWidget {
  final SignalModel? signal;

  const SignalCard({super.key, this.signal});

  @override
  Widget build(BuildContext context) {
    if (signal == null) {
      return Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Center(
          child: Column(
            children: [
              Icon(Icons.signal_cellular_alt, size: 48, color: AppColors.accent),
              SizedBox(height: 16),
              Text(
                'Signal kutilmoqda...',
                style: TextStyle(
                  color: AppColors.text,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Yangi signal qo\'shish uchun pastdagi tugmani bosing',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      );
    }

    final directionColor = signal!.direction == 'LONG' 
        ? AppColors.longColor 
        : AppColors.shortColor;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: directionColor.withValues(alpha: 0.3), width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  signal!.strategy,
                  style: const TextStyle(
                    color: AppColors.text,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: directionColor.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  signal!.direction,
                  style: TextStyle(
                    color: directionColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildInfoRow('Kirish', signal!.entryPrice.toStringAsFixed(2)),
          const SizedBox(height: 8),
          _buildInfoRow('Stop-Loss', signal!.stopLoss.toStringAsFixed(2), 
              color: AppColors.error),
          const SizedBox(height: 8),
          _buildInfoRow('TP1', signal!.takeProfit1.toStringAsFixed(2), 
              color: AppColors.success),
          const SizedBox(height: 8),
          _buildInfoRow('TP2', signal!.takeProfit2.toStringAsFixed(2), 
              color: AppColors.success),
          const SizedBox(height: 12),
          const Divider(color: Colors.grey),
          const SizedBox(height: 8),
          Text(
            DateFormat('dd.MM.yyyy HH:mm').format(signal!.createdAt),
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {Color? color}) {
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
            color: color ?? AppColors.text,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
