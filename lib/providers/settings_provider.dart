import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/notification_service.dart';

class SettingsProvider with ChangeNotifier {
  bool _londonNotificationEnabled = true;
  bool _nyNotificationEnabled = true;
  double _defaultRiskPercent = 1.0;
  double _defaultBalance = 1000.0;
  bool _isDarkMode = true;

  bool get londonNotificationEnabled => _londonNotificationEnabled;
  bool get nyNotificationEnabled => _nyNotificationEnabled;
  double get defaultRiskPercent => _defaultRiskPercent;
  double get defaultBalance => _defaultBalance;
  bool get isDarkMode => _isDarkMode;

  // Sozlamalarni yuklash
  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    
    _londonNotificationEnabled = prefs.getBool('londonNotification') ?? true;
    _nyNotificationEnabled = prefs.getBool('nyNotification') ?? true;
    _defaultRiskPercent = prefs.getDouble('defaultRiskPercent') ?? 1.0;
    _defaultBalance = prefs.getDouble('defaultBalance') ?? 1000.0;
    _isDarkMode = prefs.getBool('isDarkMode') ?? true;
    
    // Notification sozlamalarini yangilash
    await _updateNotifications();
    
    notifyListeners();
  }

  // London notification sozlash
  Future<void> setLondonNotification(bool enabled) async {
    _londonNotificationEnabled = enabled;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('londonNotification', enabled);
    await _updateNotifications();
    notifyListeners();
  }

  // NY notification sozlash
  Future<void> setNYNotification(bool enabled) async {
    _nyNotificationEnabled = enabled;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('nyNotification', enabled);
    await _updateNotifications();
    notifyListeners();
  }

  // Default risk foizini sozlash
  Future<void> setDefaultRiskPercent(double percent) async {
    _defaultRiskPercent = percent;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('defaultRiskPercent', percent);
    notifyListeners();
  }

  // Default balansni sozlash
  Future<void> setDefaultBalance(double balance) async {
    _defaultBalance = balance;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('defaultBalance', balance);
    notifyListeners();
  }

  // Dark mode sozlash
  Future<void> setDarkMode(bool enabled) async {
    _isDarkMode = enabled;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', enabled);
    notifyListeners();
  }

  // Notificationlarni yangilash
  Future<void> _updateNotifications() async {
    await NotificationService.cancelAll();
    
    if (_londonNotificationEnabled) {
      await NotificationService.scheduleLondonNotifications();
    }
    
    if (_nyNotificationEnabled) {
      await NotificationService.scheduleNYNotification();
    }
  }
}
