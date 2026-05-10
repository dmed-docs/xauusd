# GoldSignal - XAUUSD Trading Strategiya Ilovasi

XAUUSD (Oltin) trading uchun London Breakout va boshqa strategiyalarni qo'llab-quvvatlovchi mobil ilova.

## 🌟 Xususiyatlar

### 📊 Strategiyalar
- **London Breakout** - Eng kuchli strategiya (13:00-16:00 UZT)
- **RSI Divergensiya** - Teskari signal strategiyasi
- **EMA Bounce** - Trend-following strategiyasi

### 🔔 Eslatmalar
- London sessiyasi eslatmalari (12:45 va 13:00 UZT)
- NY sessiyasi eslatmalari (18:00 UZT)
- Yangi signal qo'shilganda avtomatik xabarnoma

### 🧮 Lot Kalkulyator
- Risk foiziga asoslangan lot hisoblash
- Take-Profit va Stop-Loss hisoblash
- Risk/Reward nisbati ko'rsatish

### ⚙️ Sozlamalar
- Eslatmalarni yoqish/o'chirish
- Default balans va risk foizini saqlash
- Qoʻngʻir tema (dark mode)

## 🚀 O'rnatish

### Talablar
- Flutter SDK (3.11.5 yoki yuqori)
- Android Studio / VS Code
- Android SDK (Android uchun)
- Xcode (iOS uchun)

### Dependencylarni o'rnatish
```bash
flutter pub get
```

### Ishga tushirish
```bash
# Android
flutter run

# iOS
flutter run -d ios

# Release build
flutter build apk --release  # Android
flutter build ios --release  # iOS
```

## 📱 Ekranlar

### 1. Home Screen
- Joriy vaqt va sessiya statusi
- Oxirgi signal kartasi
- Signal qo'shish tugmasi

### 2. Strategiyalar Screen
- Uchta strategiya (tablar bilan)
- Har bir strategiya uchun qoidalar
- Ogohlantirishlar va maslahatlar

### 3. Kalkulyator Screen
- Hisob balansi input
- Risk foizi slider
- Stop-Loss input
- Real vaqtda hisoblash

### 4. Sozlamalar Screen
- Notification sozlamalari
- Default qiymatlar
- Dastur haqida ma'lumot

## 🎨 Dizayn

### Rang sxemasi
- **Fon**: #0A1628 (qoʻyu koʻk)
- **Accent**: #F0B429 (oltin sariq)
- **Muvaffaqiyat**: #22C55E (yashil)
- **Xato**: #EF4444 (qizil)
- **Matn**: #F1F5F9 (oq/kulrang)

## 📦 Paketlar

```yaml
dependencies:
  provider: ^6.1.1                          # State management
  flutter_local_notifications: ^17.0.0      # Push notifications
  shared_preferences: ^2.2.2                # Mahalliy saqlash
  fl_chart: ^0.68.0                         # Grafiklar
  timezone: ^0.9.3                          # Vaqt zonalari
  intl: ^0.19.0                             # Sana formatlash
```

## 🔧 Texnik Tafsilotlar

### Notification Tizimi
- Har kuni 12:45 UZT - London eslatmasi
- Har kuni 13:00 UZT - London ochildi
- Har kuni 18:00 UZT - NY ochildi (ixtiyoriy)
- Yangi signal qo'shilganda darhol xabarnoma

### Ma'lumot Saqlash
- SharedPreferences orqali mahalliy saqlash
- Internet talab qilinmaydi
- Barcha signallar va sozlamalar saqlanadi

### Sessiya Vaqtlari (UZT - UTC+5)
- **London**: 13:00 - 18:00
- **New York**: 18:00 - 23:00
- **Osiyo/Yopiq**: 23:00 - 13:00

### Lot Hisoblash Formulasi
```
Risk summasi = Balans × Risk% / 100
Lot hajmi = Risk summasi / (SL pip × 10)
```

XAUUSD uchun:
- 1 lot = $10/pip
- 0.1 lot = $1/pip
- 0.01 lot = $0.10/pip

## 📝 Foydalanish

1. **Ilovani oching** - Joriy sessiya statusini ko'ring
2. **Signal qo'shing** - "Signal qo'shish" tugmasini bosing
3. **Strategiyani tanlang** - London Breakout, RSI yoki EMA
4. **Ma'lumotlarni kiriting** - Kirish, SL, TP narxlarini kiriting
5. **Eslatmalarni sozlang** - Sozlamalar bo'limida
6. **Lot hisoblang** - Kalkulyator bo'limida

## ⚠️ Muhim Ogohlantirishlar

### London Breakout
- ❌ Osiyo sessiyasida ishlatmang
- ❌ Diapazon 60 pipdan katta bo'lsa ishlatmang
- ❌ Katta yangilik oldidan ishlatmang

### Risk Management
- ✅ Har bir trade da 1-2% risk qiling
- ✅ TP1 ga yetgach SL ni Breakevenga ko'chiring
- ✅ Strategiya qoidalariga amal qiling

## 🐛 Muammolarni Hal Qilish

### Notificationlar ishlamayapti
1. Ilova sozlamalarida notification permission bering
2. Battery optimization ni o'chiring
3. Ilovani qayta ishga tushiring

### Vaqt noto'g'ri ko'rsatilmoqda
- Telefon vaqt zonasi "Asia/Tashkent" ga o'rnatilganligini tekshiring

## 📄 Litsenziya

© 2026 GoldSignal. Barcha huquqlar himoyalangan.

## 👨‍💻 Muallif

XAUUSD Trading Strategiya Ilovasi - Flutter bilan yaratilgan

---

**Diqqat**: Bu ilova faqat ta'lim maqsadida yaratilgan. Real trading da foydalanishdan oldin demo hisobda sinab ko'ring. Trading xavfli va pul yo'qotishga olib kelishi mumkin.
# xauusd
