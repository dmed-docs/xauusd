import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/signal_model.dart';
import '../services/notification_service.dart';

class SignalProvider with ChangeNotifier {
  List<SignalModel> _signals = [];
  SignalModel? _latestSignal;

  List<SignalModel> get signals => _signals;
  SignalModel? get latestSignal => _latestSignal;

  // SharedPreferences dan signallarni yuklash
  Future<void> loadSignals() async {
    final prefs = await SharedPreferences.getInstance();
    final signalsJson = prefs.getStringList('signals') ?? [];
    
    _signals = signalsJson
        .map((json) => SignalModel.fromJson(jsonDecode(json)))
        .toList();
    
    if (_signals.isNotEmpty) {
      _latestSignal = _signals.first;
    }
    
    notifyListeners();
  }

  // Yangi signal qo'shish
  Future<void> addSignal(SignalModel signal) async {
    _signals.insert(0, signal);
    _latestSignal = signal;
    
    await _saveSignals();
    
    // Notification yuborish
    await NotificationService.showSignalNotification(
      strategy: signal.strategy,
      direction: signal.direction,
      entryPrice: signal.entryPrice,
      stopLoss: signal.stopLoss,
      takeProfit: signal.takeProfit1,
    );
    
    notifyListeners();
  }

  // Signalni o'chirish
  Future<void> removeSignal(String id) async {
    _signals.removeWhere((signal) => signal.id == id);
    
    if (_signals.isEmpty) {
      _latestSignal = null;
    } else {
      _latestSignal = _signals.first;
    }
    
    await _saveSignals();
    notifyListeners();
  }

  // Signalni yangilash
  Future<void> updateSignal(SignalModel signal) async {
    final index = _signals.indexWhere((s) => s.id == signal.id);
    if (index != -1) {
      _signals[index] = signal;
      if (_latestSignal?.id == signal.id) {
        _latestSignal = signal;
      }
      await _saveSignals();
      notifyListeners();
    }
  }

  // Signallarni saqlash
  Future<void> _saveSignals() async {
    final prefs = await SharedPreferences.getInstance();
    final signalsJson = _signals
        .map((signal) => jsonEncode(signal.toJson()))
        .toList();
    await prefs.setStringList('signals', signalsJson);
  }

  // Barcha signallarni tozalash
  Future<void> clearSignals() async {
    _signals.clear();
    _latestSignal = null;
    await _saveSignals();
    notifyListeners();
  }
}
