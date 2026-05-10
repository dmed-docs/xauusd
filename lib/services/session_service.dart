import 'package:timezone/timezone.dart' as tz;
import '../utils/constants.dart';

enum SessionStatus {
  london,
  newYork,
  closed,
}

class SessionService {
  // Joriy sessiya statusini aniqlash
  static SessionStatus getCurrentSession() {
    final now = tz.TZDateTime.now(tz.getLocation('Asia/Tashkent'));
    final hour = now.hour;

    if (hour >= SessionTimes.londonStartHour && hour < SessionTimes.londonEndHour) {
      return SessionStatus.london;
    } else if (hour >= SessionTimes.nyStartHour && hour < SessionTimes.nyEndHour) {
      return SessionStatus.newYork;
    } else {
      return SessionStatus.closed;
    }
  }

  // Sessiya nomi
  static String getSessionName(SessionStatus status) {
    switch (status) {
      case SessionStatus.london:
        return 'London Sessiyasi';
      case SessionStatus.newYork:
        return 'NY Sessiyasi';
      case SessionStatus.closed:
        return 'Bozor Yopiq';
    }
  }

  // Sessiya status matni
  static String getSessionStatusText(SessionStatus status) {
    switch (status) {
      case SessionStatus.london:
        return 'Faol';
      case SessionStatus.newYork:
        return 'Faol';
      case SessionStatus.closed:
        return 'Yopiq';
    }
  }

  // Keyingi sessiya vaqti
  static String getNextSessionTime() {
    final now = tz.TZDateTime.now(tz.getLocation('Asia/Tashkent'));
    final hour = now.hour;

    if (hour < SessionTimes.londonStartHour) {
      final remaining = SessionTimes.londonStartHour - hour;
      return 'London $remaining soatda ochiladi';
    } else if (hour < SessionTimes.nyStartHour) {
      final remaining = SessionTimes.nyStartHour - hour;
      return 'NY $remaining soatda ochiladi';
    } else {
      final remaining = 24 - hour + SessionTimes.londonStartHour;
      return 'London $remaining soatda ochiladi';
    }
  }
}
