# Верификация: восстановление OrderRequestWidget с записью в Firestore

Итерация: 1 (review.json отсутствовал — реализация с нуля по плану).

## Что изменено
- `pubspec.yaml`: добавлена зависимость `cloud_firestore: ^6.10.0` (после `firebase_auth`, до `google_sign_in`). Остальные зависимости не трогались.
- `lib/presentation/widgets/contacts_widget.dart`:
  - добавлен `import 'package:cloud_firestore/cloud_firestore.dart';`
  - полностью переписан класс `OrderRequestWidget` + `_OrderRequestWidgetState`
  - `ContactsWidget` и `_HoverContactCard` НЕ изменялись (ссылки Telegram/WhatsApp/Телефон через `url_launcher` те же)
  - сигнатура `const OrderRequestWidget({super.key})` сохранена (3 вызова через `const` продолжают компилироваться)

## Соответствие firestore.rules (коллекция `orders`)
В `_submit` документ формируется ровно с 10 полями, без лишних/недостающих ключей:
- `services` — выбранная услуга (строка)
- `clientType` — `'company'` / `'individual'`
- `clientName` — `'<firstName> <lastName>'`
- `firstName`, `lastName` — строки (trim)
- `companyName` — для физлица пустая строка `''` (НЕ null)
- `phone`, `message` — строки (trim)
- `status` — всегда `'new'`
- `createdAt` — `FieldValue.serverTimestamp()`

Поведение: валидация обязательных полей → `FirebaseFirestore.instance.collection('orders').add(data)` → при успехе экран успеха (`_submitted`), при ошибке `SnackBar` с текстом `FirebaseException` (форма не сбрасывается). Чекбокс «Представляю компанию» условно показывает поле «Название компании» и очищает его при снятии.

## Запущенные команды и результаты

### flutter pub get (каталог проекта)
```
Got dependencies!
cloud_firestore 6.10.0 ... resolved
```
Exit code 0. `cloud_firestore 6.10.0` присутствует в дереве зависимостей.

### flutter analyze lib/presentation/widgets/contacts_widget.dart
```
3 issues found — все уровня info (deprecated_member_use для withOpacity):
  - line 34  — ContactsWidget (существующий, НЕ затронут)
  - line 284 — кнопка отправки (воспроизводит стиль оригинальной кнопки, согласовано со стилем файла)
  - line 426 — _HoverContactCard (существующий, НЕ затронут)
```
0 errors, 0 warnings. Предложенная анализатором замена `value` → `initialValue` в `DropdownButtonFormField` применена (поведение сохранено, неконтролируемое поле формы). Ошибок, связанных с изменением, нет.

### flutter build web --release
```
√ Built build\web
```
Exit code 0. Сборка web прошла успешно, `cloud_firestore_web` резолвится, `build/web/` создан (совпадает с `firebase.json` → `hosting.public = "build/web"`).

### git remote -v (контроль неизменности remote)
```
origin  https://github.com/kuakpai-ship-it/Nexora.git (fetch)
origin  https://github.com/kuakpai-ship-it/Nexora.git (push)
```
Remote прежний. Коммит, пуш и изменение конфигурации git НЕ выполнялись.

## Заметка
Звёздочкой (*) в UI помечены только «Имя» и «Фамилия» (по скриншоту), но валидация также требует выбора услуги (дропдаун) и номер телефона — принято осознанно (без них заявка бесполезна, а `firestore.rules` требует эти поля строками). «Комментарий» необязателен (допускает пустую строку, проходит правила).
