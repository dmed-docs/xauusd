import 'package:flutter/material.dart';

// Rang sxemasi
class AppColors {
  static const Color background = Color(0xFF0A1628);
  static const Color accent = Color(0xFFF0B429);
  static const Color success = Color(0xFF22C55E);
  static const Color error = Color(0xFFEF4444);
  static const Color text = Color(0xFFF1F5F9);
  static const Color cardBackground = Color(0xFF1A2332);
  static const Color longColor = Color(0xFF22C55E);
  static const Color shortColor = Color(0xFFEF4444);
}

// Sessiya vaqtlari (UZT - UTC+5)
class SessionTimes {
  static const int londonStartHour = 13; // 13:00 UZT
  static const int londonEndHour = 18; // 18:00 UZT
  static const int nyStartHour = 18; // 18:00 UZT
  static const int nyEndHour = 23; // 23:00 UZT
}

// Strategiya nomlari
class StrategyNames {
  static const String londonBreakout = 'London Breakout';
  static const String rsiDivergence = 'RSI Divergensiya';
  static const String emaBounce = 'EMA Bounce';
}

// Notification ID lar
class NotificationIds {
  static const int londonWarning = 1;
  static const int londonOpen = 2;
  static const int newSignal = 3;
  static const int tp1Reached = 4;
  static const int slReached = 5;
  static const int nyOpen = 6;
}

// XAUUSD lot hisoblash konstantalari
class LotConstants {
  static const double pipValue = 10.0; // 1 lot = $10/pip
}
