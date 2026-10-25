# Практична робота №14 — Нативні можливості

**Oleksandr · 32-IST · варіант / номер у журналі 25.**

Номер 25 відповідає завданню 1. MethodChannel ua.edu.mobile/practical25, метод getGreeting. Kotlin повертає статичний рядок Hi, Mom!. image_picker запускає камеру; нове фото відображається в застосунку. Оброблено скасування, недоступну камеру та відновлення lost data.

## Відкрити та запустити

В Android Studio оберіть File → Open і цю папку, де лежить pubspec.yaml. Встановіть плагіни Flutter/Dart і виберіть Android-пристрій або запущений емулятор.

```powershell
flutter pub get
flutter run
```

Точка входу Android-застосунку: `lib/main.dart`. Мінімальний Android API: 24.

## Код

lib/native_service.dart — канал; lib/main.dart — камера; android/app/src/main/kotlin/ua/edu/mobile/practical_14/MainActivity.kt — справжній нативний обробник.

`lib/ui.dart` — невеликі локальні допоміжні віджети. Проєкт не залежить від інших практичних.

[Перевірені скріншоти різних станів Android](screenshots/README.md) — підписаний набір для цієї роботи.

## Перевірка

```powershell
dart analyze --fatal-infos
flutter test --exclude-tags visual
```

Окремий рендер екрана телефону 390×844: `flutter test test/visual_test.dart`. Він створює `screenshots/initial.png`; для №13 рендер використовує демонстраційний репозиторій, а справжнє збереження перевіряє integration_test.

Додатково, з термінала цієї папки:

```powershell
flutter test integration_test/native_test.dart -d <ID_ANDROID>
```

Камеру перевіряйте на Android-телефоні або емуляторі з налаштованою камерою. Після змін Kotlin потрібен повний перезапуск, hot reload недостатньо. Фото показується з тимчасового файлу image_picker; збереження у галерею не є частиною завдання.

## APK та матеріали

```powershell
flutter build apk --debug
# Або для завантаження навчального прикладу в Appetize:
flutter build apk --release
```

APK: `build/app/outputs/flutter-apk/app-debug.apk` або `app-release.apk`. Стандартний навчальний шаблон підписує release debug-ключем; для навчального перегляду, не для публікації в магазині.

[Початкове завдання](Завдання.txt) · [Оригінал методички](../materials/методичка.docx)

Вимоги методички до звітів, власних публічних репозиторіїв, Appetize, відео та QR-кодів наведено в Завдання.txt. Зовнішні публікації та звіти не створювалися в межах запиту на код.
