import 'package:flutter/material.dart';
import '../services/session_service.dart';
import '../utils/constants.dart';

class SessionBadge extends StatelessWidget {
  final SessionStatus status;

  const SessionBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    Color badgeColor;
    IconData icon;
    
    switch (status) {
      case SessionStatus.london:
        badgeColor = AppColors.success;
        icon = Icons.circle;
        break;
      case SessionStatus.newYork:
        badgeColor = AppColors.accent;
        icon = Icons.circle;
        break;
      case SessionStatus.closed:
        badgeColor = AppColors.error;
        icon = Icons.circle;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: badgeColor.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: badgeColor, width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: badgeColor, size: 12),
          const SizedBox(width: 8),
          Text(
            SessionService.getSessionName(status),
            style: TextStyle(
              color: badgeColor,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            '(${SessionService.getSessionStatusText(status)})',
            style: TextStyle(
              color: badgeColor.withValues(alpha: 0.8),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
