import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import '../utils/constants.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  // Initialization
  static Future<void> initialize() async {
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _notifications.initialize(initSettings);

    // Android 13+ uchun permission so'rash
    await _notifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  // London sessiyasi eslatmalarini sozlash
  static Future<void> scheduleLondonNotifications() async {
    // 12:45 UZT - 15 daqiqa oldin ogohlantirish
    await _scheduleDaily(
      id: NotificationIds.londonWarning,
      hour: 12,
      minute: 45,
      title: '⏰ London sessiyasi 15 daqiqada!',
      body: 'Diapazonni belgilashga tayyorlaning.',
    );

    // 13:00 UZT - London ochildi
    await _scheduleDaily(
      id: NotificationIds.londonOpen,
      hour: 13,
      minute: 0,
      title: '🟢 London ochildi!',
      body: 'Breakout signalini kuting.',
    );
  }

  // NY sessiyasi eslatmasini sozlash
  static Future<void> scheduleNYNotification() async {
    await _scheduleDaily(
      id: NotificationIds.nyOpen,
      hour: 18,
      minute: 0,
      title: '🟡 NY sessiyasi ochildi!',
      body: 'Trading imkoniyatlarini kuzating.',
    );
  }

  // Kunlik notification schedule qilish
  static Future<void> _scheduleDaily({
    required int id,
    required int hour,
    required int minute,
    required String title,
    required String body,
  }) async {
    final now = tz.TZDateTime.now(tz.getLocation('Asia/Tashkent'));
    var scheduledDate = tz.TZDateTime(
      tz.getLocation('Asia/Tashkent'),
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );

    // Agar vaqt o'tib ketgan bo'lsa, ertaga schedule qil
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    await _notifications.zonedSchedule(
      id,
      title,
      body,
      scheduledDate,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'trading_channel',
          'Trading Eslatmalari',
          channelDescription: 'XAUUSD trading eslatmalari',
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  // Yangi signal notification
  static Future<void> showSignalNotification({
    required String strategy,
    required String direction,
    required double entryPrice,
    required double stopLoss,
    required double takeProfit,
  }) async {
    await _notifications.show(
      NotificationIds.newSignal,
      '📊 Yangi Signal — $strategy',
      '$direction | Kirish: ${entryPrice.toStringAsFixed(2)} | SL: ${stopLoss.toStringAsFixed(2)} | TP: ${takeProfit.toStringAsFixed(2)}',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'signal_channel',
          'Trading Signallari',
          channelDescription: 'Yangi trading signallari',
          importance: Importance.max,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
    );
  }

  // TP1 eslatmasi
  static Future<void> showTP1Notification() async {
    await _notifications.show(
      NotificationIds.tp1Reached,
      '✅ TP1 ga yetdingiz!',
      'SL ni Breakevenga ko\'chiring.',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'tp_channel',
          'Take Profit Eslatmalari',
          channelDescription: 'Take profit eslatmalari',
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
    );
  }

  // SL eslatmasi
  static Future<void> showSLNotification() async {
    await _notifications.show(
      NotificationIds.slReached,
      '❌ Stop-Loss ishladi',
      'Keyingi signalni kuting.',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'sl_channel',
          'Stop Loss Eslatmalari',
          channelDescription: 'Stop loss eslatmalari',
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
    );
  }

  // Barcha scheduled notificationlarni bekor qilish
  static Future<void> cancelAll() async {
    await _notifications.cancelAll();
  }

  // Bitta notificationni bekor qilish
  static Future<void> cancel(int id) async {
    await _notifications.cancel(id);
  }
}
