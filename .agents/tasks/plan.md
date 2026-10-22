# План: восстановление формы заявки OrderRequestWidget с записью в Firestore

Контекст проекта: `c:/Users/PREDATOR/Downloads/nexora2-main/nexora2-main` (Flutter Web, Dart 3.13.5, Flutter 3.47.7). Firebase уже инициализирован в `lib/main.dart` через `Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)`; web-конфиг присутствует в `lib/firebase_options.dart` (projectId `nexora-3261b-88f1d`). В `pubspec.yaml` есть `firebase_core: ^4.15.0`, `firebase_auth: ^6.7.0`, `url_launcher: ^6.3.3`, но НЕТ `cloud_firestore`. В коде `cloud_firestore`/`FirebaseFirestore` пока не используется нигде (только `firebase_auth` в `admin_login_page.dart`). Ручного Firebase SDK в `web/index.html` нет — FlutterFire-пакеты подключают всё сами, правок веб-конфига не требуется.

`firestore.rules` для коллекции `orders` требует строго 10 полей (`hasOnly` И `hasAll`): `services`, `clientType` (только `'company'`/`'individual'`), `clientName`, `firstName`, `lastName`, `companyName` (строка, для физлица — пустая строка, НЕ null), `phone`, `message`, `status` (только `'new'`), `createdAt` (`== request.time`, то есть `FieldValue.serverTimestamp()`). Документ обязан содержать ровно этот набор полей — никаких лишних и никаких недостающих.

`OrderRequestWidget` используется в 3 местах через `showDialog(..., barrierColor: Colors.black54, builder: (_) => const OrderRequestWidget())`: `lib/presentation/mobile_screen_folders/screens/game_development_page.dart`, `machine_learning.dart`, `mobile_development_page.dart`. Конструктор `const OrderRequestWidget({super.key})` менять нельзя — все вызовы идут через `const`, сигнатура должна остаться такой же.

`ContactsWidget` в том же файле уже содержит правильные реальные ссылки (Telegram `https://t.me/NexoraOrderGroup`, WhatsApp `https://chat.whatsapp.com/CX0VNSLpBwuDzWIfK8E32o`, телефон `+77001234567` через `url_launcher`) — его НЕ трогаем.

Git remote `origin` = `https://github.com/kuakpai-ship-it/Nexora.git`. Требование пользователя: старый GitHub remote оставить нетронутым — НЕ пушить и НЕ менять конфигурацию remote. Коммитить можно локально, пушить нельзя.

---

- [ ] 1. Добавить `cloud_firestore` в `pubspec.yaml`.
      В блок `dependencies:` добавить строку `cloud_firestore: ^6.10.0` (между `firebase_auth` и `google_sign_in` или рядом с другими firebase_*-зависимостями для порядка). Остальные зависимости не трогать. Версия `^6.10.0` совместима с уже установленными `firebase_core: ^4.15.0` и Dart SDK `^3.12.0`.
      Files: `c:/Users/PREDATOR/Downloads/nexora2-main/nexora2-main/pubspec.yaml`
      Verify: `flutter pub get` в каталоге проекта — команда завершается без ошибок и резолвит `cloud_firestore`. Затем `flutter pub deps --no-dev | findstr cloud_firestore` (или просмотр вывода `flutter pub get`) подтверждает, что `cloud_firestore 6.10.0` (или новее в рамках `^6.10.0`) присутствует в дереве зависимостей.

- [ ] 2. Переписать `OrderRequestWidget` в `contacts_widget.dart`: форма по скриншоту, валидация, запись в Firestore, экран успеха, SnackBar при ошибке.
      `ContactsWidget` и `_HoverContactCard` в этом же файле НЕ менять. Заменяется только класс `OrderRequestWidget` и его state `_OrderRequestWidgetState` (сейчас там симуляция через `Future.delayed` без Firestore).
      Files: `c:/Users/PREDATOR/Downloads/nexora2-main/nexora2-main/lib/presentation/widgets/contacts_widget.dart`

      Что должно быть реализовано (без кода в плане — описание для реализации):

      - Импорты: добавить `import 'package:cloud_firestore/cloud_firestore.dart';` (поверх существующих `package:flutter/material.dart` и `package:url_launcher/url_launcher.dart`).

      - Контроллеры и состояние в `_OrderRequestWidgetState`: `GlobalKey<FormState> _formKey`; `TextEditingController` для телефона, имени, фамилии, названия компании, комментария (по одному на поле); `String? _selectedService` для дропдауна; `bool _isCompany` для чекбокса; `bool _submitting` для индикатора загрузки; `bool _submitted` для переключения на экран успеха. Все `TextEditingController`.dispose() в `dispose()`. Цвет `purple = Color(0xFF4412A7)` оставить как есть.

      - Внешний контейнер оставить прежним: `Dialog` с прозрачным фоном, `insetPadding` (25/30), внутренний `Container` width 520, padding 35, белый фон, border `0xFFE8E8E8`, shadow — как у существующего `OrderRequestWidget`/`ContactsWidget`. Внутри: если `_submitted` — экран успеха, иначе форма.

      - Шапка формы (как на скриншоте): иконка письма `Icons.mail_outline` в сиреневом квадрате `0xFFF1EBFF` (НЕ `assignment_outlined`, как сейчас); заголовок «Оставить заявку» (fontSize 24-26, fontWeight w600); подзаголовок «Выберите услугу и укажите контактные данные» (fontSize 14, black54); кнопка-крестик закрытия справа (как в `ContactsWidget._buildHeader`).

      - Поля формы (порядок строго по скриншоту, сверху вниз):
        1. Dropdown «Нужная услуга» — `DropdownButtonFormField<String>` внутри `Form`, со списком значений `['Web и Mobile разработка', 'Разработка игр', 'Машинное обучение']`, значение `_selectedService`, подсказка/hint «Выберите услугу» когда ничего не выбрано. Стиль `InputDecoration` такой же, как у остальных полей (border `0xFFE5E5E5`, focusedBorder сиреневый, радиус 6). Валидатор: если `_selectedService == null` — вернуть «Выберите услугу».
        2. Поле «Номер телефона» — `TextFormField`, controller телефона, icon `Icons.phone_outlined`, keyboardType phone. Валидатор: пусто → «Введите номер телефона».
        3. Поле «Имя *» — `TextFormField`, controller имени, icon `Icons.person_outline`. Валидатор: пусто → «Введите имя».
        4. Поле «Фамилия *» — `TextFormField`, controller фамилии, icon `Icons.person_outline`. Валидатор: пусто → «Введите фамилию».
        5. Чекбокс «Представляю компанию» — `CheckboxListTile` или Row с `Checkbox` + Text, привязан к `_isCompany`. При включении показывать поле ниже, при выключении — скрывать и очищать controller названия компании.
        6. Поле «Название компании» — `TextFormField`, controller названия компании, виден только когда `_isCompany == true`. Валидатор (только когда чекбокс включён): пусто → «Введите название компании».
        7. Поле «Комментарий» — `TextFormField`, controller комментария, maxLines 4-5, icon `Icons.notes_outlined`. Необязательное (валидатор отсутствует или допускает пусто).
        Метки «Имя *» и «Фамилия *» — со звёздочкой (как на скриншоте); остальные метки без звёздочки, но валидация services/phone/firstName/lastName/companyName(условное) обязательна.

      - Кнопка «Отправить заявку» — `SizedBox` width infinity, height 52, `ElevatedButton`, фон `purple`, белый текст; внутри Row с текстом «Отправить заявку» и иконкой стрелки `Icons.arrow_forward` (или `Icons.send`). Когда `_submitting` — кнопка disabled и показывает белый `CircularProgressIndicator` (strokeWidth 2.5) вместо текста. onPressed вызывает `_submit`.

      - Метод `_submit` (асинхронный):
        1. `if (!_formKey.currentState!.validate()) return;` — если форма невалидна, не отправлять.
        2. `setState(() => _submitting = true)`.
        3. Сформировать map документа со СТРОГО 10 полями (ровно те, что в `firestore.rules`, никаких лишних ключей):
           - `services`: `_selectedService` (строка — выбранная услуга),
           - `clientType`: `_isCompany ? 'company' : 'individual'`,
           - `clientName`: `'<firstName.trim()> <lastName.trim()>'` (имя + пробел + фамилия, оба обрезаны),
           - `firstName`: `firstName.trim()`,
           - `lastName`: `lastName.trim()`,
           - `companyName`: `_isCompany ? companyName.trim() : ''` (для физлица — пустая строка, НЕ null),
           - `phone`: `phone.trim()`,
           - `message`: `message.trim()` (комментарий; если пусто — пустая строка, это допустимо правилами),
           - `status`: `'new'` (всегда),
           - `createdAt`: `FieldValue.serverTimestamp()`.
        4. `await FirebaseFirestore.instance.collection('orders').add(<map>)` в `try/on FirebaseException catch (e)`.
        5. При успехе: `if (!mounted) return;`, `setState(() { _submitting = false; _submitted = true; })` — показать экран успеха.
        6. При ошибке: `if (!mounted) return;`, `setState(() => _submitting = false)` и `ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())))` — показать текст ошибки (можно упростить до `e.message ?? 'Ошибка отправки'`, но виден пользователю). Форму не сбрасывать, данные сохранить.

      - Экран успеха `_buildSuccess` (показывается когда `_submitted`): сохранить дизайн текущего экрана успеха — сиреневый круг с `Icons.check_circle_outline`, заголовок «Заявка отправлена!», подзаголовок «Мы получили вашу заявку и свяжемся с вами в ближайшее время.», кнопка «Закрыть» (фиолетовая) вызывает `Navigator.pop(context)`.

      - Сигнатуру `const OrderRequestWidget({super.key})` оставить без изменений, чтобы 3 вызова (`game_development_page.dart`, `machine_learning.dart`, `mobile_development_page.dart`) продолжали компилироваться через `const`.

      Verify:
      - `flutter analyze` в корне проекта — 0 errors/warnings, относящихся к `contacts_widget.dart` (новых проблем не должно появиться).
      - `flutter build web --release` — сборка завершается успешно и создаёт `build/web/` (это совпадает с `firebase.json` → `hosting.public = "build/web"`).
      - Ручная проверка соответствия `firestore.rules`: состав полей map в `_submit` ровно = `[services, clientType, clientName, firstName, lastName, companyName, phone, message, status, createdAt]`, `status` всегда `'new'`, `createdAt` = `FieldValue.serverTimestamp()`, `companyName` пустая строка (не null) для физлица. Проверить визуально по коду.

- [ ] 3. Финальная проверка и локальный коммит (без пуша).
      Убедиться, что `flutter analyze` чист, `flutter build web --release` собирается. `ContactsWidget` остался нетронутым (ссылки те же). Git remote НЕ менять, НЕ пушить: `git remote -v` должен показывать прежний `origin https://github.com/kuakpai-ship-it/Nexora.git` без изменений. Если нужен коммит — коммитить локально (`git add` конкретных файлов `pubspec.yaml` + `lib/presentation/widgets/contacts_widget.dart` + `pubspec.lock`, `git commit`), пуш (`git push`) НЕ выполнять и конфигурацию remote не трогать.
      Files: (без правок кода на этом шаге)
      Verify: `flutter analyze` — без ошибок; `flutter build web --release` — успех; `git remote -v` — remote прежний и не было `git push`.

---

Замечание/допущение: в спецификации звёздочкой (*) помечены только «Имя» и «Фамилия», но services (дропдаун) и «Номер телефона» сделаны обязательными для валидации, потому что без выбранной услуги и контакта заявка бесполезна, а `firestore.rules` всё равно требует эти поля строками. Метки оставлены как на скриншоте (звёздочки только у имени и фамилии) — это расхождение между UI-подписью и логикой валидации; принято осознанно. Если пользователь по картинкам попросит убрать обязательность телефона/services — скорректировать валидаторы, оставив поля опциональными (правый путь: services по умолчанию первый вариант, phone/message допускают пустую строку, что тоже проходит `firestore.rules`).
