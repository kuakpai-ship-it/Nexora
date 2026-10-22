import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactsWidget extends StatefulWidget {
  const ContactsWidget({super.key});

  @override
  State<ContactsWidget> createState() => _ContactsWidgetState();
}

class _ContactsWidgetState extends State<ContactsWidget> {
  final Color purple = const Color(0xFF4412A7);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(
        horizontal: 25,
        vertical: 30,
      ),
      child: Container(
        width: 520,
        padding: const EdgeInsets.all(35),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: const Color(0xFFE8E8E8),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.12),
              blurRadius: 35,
              offset: const Offset(0, 15),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),

            const SizedBox(height: 30),

            _buildContactCard(
              icon: Icons.telegram,
              title: 'Telegram',
              subtitle: 'Открыть группу в Telegram',
              onTap: () => launchUrl(Uri.parse('https://t.me/NexoraOrderGroup')),
            ),

            const SizedBox(height: 12),

            _buildContactCard(
              icon: Icons.chat_bubble_outline,
              title: 'WhatsApp',
              subtitle: 'Вступить в группу WhatsApp',
              onTap: () => launchUrl(Uri.parse('https://chat.whatsapp.com/CX0VNSLpBwuDzWIfK8E32o')),
            ),

            const SizedBox(height: 12),

            _buildContactCard(
              icon: Icons.phone_outlined,
              title: 'Телефон',
              subtitle: '+77001234567',
              onTap: () => launchUrl(Uri.parse('tel:+77001234567')),
            ),

            const SizedBox(height: 25),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: const Color(0xFFF7F7F7),
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Text(
                'Мы ответим на ваше сообщение и обсудим ваш проект',
                style: TextStyle(
                  fontSize: 14,
                  height: 1.5,
                  color: Colors.black54,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // =========================================================
  // HEADER
  // =========================================================

  Widget _buildHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            color: const Color(0xFFF1EBFF),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Icon(
            Icons.mail_outline,
            color: purple,
            size: 27,
          ),
        ),

        const SizedBox(width: 17),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Свяжитесь с нами',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w600,
                  letterSpacing: -0.5,
                ),
              ),

              const SizedBox(height: 7),

              const Text(
                'Выберите удобный способ связи',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),

        InkWell(
          borderRadius: BorderRadius.circular(30),
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: const Color(0xFFF7F7F7),
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Icon(
              Icons.close,
              size: 19,
              color: Colors.black54,
            ),
          ),
        ),
      ],
    );
  }

  // =========================================================
  // CONTACT CARD
  // =========================================================

  Widget _buildContactCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return _HoverContactCard(
      icon: icon,
      title: title,
      subtitle: subtitle,
      purple: purple,
      onTap: onTap,
    );
  }
}

// =============================================================
// ORDER REQUEST WIDGET
// =============================================================

class OrderRequestWidget extends StatefulWidget {
  const OrderRequestWidget({super.key});

  @override
  State<OrderRequestWidget> createState() => _OrderRequestWidgetState();
}

class _OrderRequestWidgetState extends State<OrderRequestWidget> {
  static const Color purple = Color(0xFF4412A7);

  static const List<String> _services = [
    'Web и Mobile разработка',
    'Разработка игр',
    'Машинное обучение',
  ];

  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _companyNameController = TextEditingController();
  final _messageController = TextEditingController();

  String? _selectedService;
  bool _isCompany = false;
  bool _submitted = false;
  bool _submitting = false;

  @override
  void dispose() {
    _phoneController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _companyNameController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    setState(() => _submitting = true);

    final firstName = _firstNameController.text.trim();
    final lastName = _lastNameController.text.trim();
    final data = <String, dynamic>{
      'services': _selectedService!,
      'clientType': _isCompany ? 'company' : 'individual',
      'clientName': '$firstName $lastName',
      'firstName': firstName,
      'lastName': lastName,
      'companyName': _isCompany ? _companyNameController.text.trim() : '',
      'phone': _phoneController.text.trim(),
      'message': _messageController.text.trim(),
      'status': 'new',
      'createdAt': DateTime.now().toIso8601String(),
    };

    try {
      await FirebaseDatabase.instanceFor(
        app: FirebaseDatabase.instance.app,
        databaseURL: 'https://nexora-3261b-88f1d-default-rtdb.europe-west1.firebasedatabase.app',
      ).ref('orders').push().set(data);
      if (!mounted) return;
      setState(() {
        _submitting = false;
        _submitted = true;
      });
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;
      setState(() => _submitting = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? 'Ошибка отправки заявки')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(
        horizontal: 25,
        vertical: 30,
      ),
      child: Container(
        width: 520,
        padding: const EdgeInsets.all(35),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFFE8E8E8)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.12),
              blurRadius: 35,
              offset: const Offset(0, 15),
            ),
          ],
        ),
        child: _submitted ? _buildSuccess() : _buildForm(),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            color: const Color(0xFFF1EBFF),
            borderRadius: BorderRadius.circular(6),
          ),
          child: const Icon(
            Icons.mail_outline,
            color: purple,
            size: 27,
          ),
        ),
        const SizedBox(width: 17),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Оставить заявку',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  letterSpacing: -0.5,
                ),
              ),
              SizedBox(height: 7),
              Text(
                'Выберите услугу и укажите контактные данные',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
        InkWell(
          borderRadius: BorderRadius.circular(30),
          onTap: () => Navigator.pop(context),
          child: Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: const Color(0xFFF7F7F7),
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Icon(
              Icons.close,
              size: 19,
              color: Colors.black54,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 28),
          _buildServiceDropdown(),
          const SizedBox(height: 14),
          _buildField(
            controller: _phoneController,
            label: 'Номер телефона',
            hint: '+7 (___) ___-__-__',
            icon: Icons.phone_outlined,
            keyboardType: TextInputType.phone,
            validator: (v) =>
                (v == null || v.trim().isEmpty) ? 'Введите номер телефона' : null,
          ),
          const SizedBox(height: 14),
          _buildField(
            controller: _firstNameController,
            label: 'Имя *',
            hint: 'Иван',
            icon: Icons.person_outline,
            validator: (v) =>
                (v == null || v.trim().isEmpty) ? 'Введите имя' : null,
          ),
          const SizedBox(height: 14),
          _buildField(
            controller: _lastNameController,
            label: 'Фамилия *',
            hint: 'Иванов',
            icon: Icons.person_outline,
            validator: (v) =>
                (v == null || v.trim().isEmpty) ? 'Введите фамилию' : null,
          ),
          const SizedBox(height: 10),
          _buildCompanyCheckbox(),
          if (_isCompany) ...[
            const SizedBox(height: 14),
            _buildField(
              controller: _companyNameController,
              label: 'Название компании',
              hint: 'ООО «Ромашка»',
              icon: Icons.business_outlined,
              validator: (v) => (v == null || v.trim().isEmpty)
                  ? 'Введите название компании'
                  : null,
            ),
          ],
          const SizedBox(height: 14),
          _buildField(
            controller: _messageController,
            label: 'Комментарий',
            hint: 'Расскажите о вашем проекте...',
            icon: Icons.notes_outlined,
            maxLines: 4,
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: _submitting ? null : _submit,
              style: ElevatedButton.styleFrom(
                backgroundColor: purple,
                foregroundColor: Colors.white,
                disabledBackgroundColor: purple.withOpacity(0.6),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: _submitting
                  ? const SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        color: Colors.white,
                      ),
                    )
                  : const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Отправить заявку',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(Icons.arrow_forward, size: 18),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceDropdown() {
    return DropdownButtonFormField<String>(
      initialValue: _selectedService,
      decoration: InputDecoration(
        labelText: 'Нужная услуга',
        prefixIcon: const Icon(Icons.work_outline, color: purple, size: 21),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(color: Color(0xFFE5E5E5)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(color: Color(0xFFE5E5E5)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(color: purple, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(color: Colors.redAccent),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 14,
        ),
      ),
      hint: const Text('Выберите услугу'),
      items: _services
          .map((s) => DropdownMenuItem(value: s, child: Text(s)))
          .toList(),
      onChanged: (value) => setState(() => _selectedService = value),
      validator: (value) =>
          (value == null || value.isEmpty) ? 'Выберите услугу' : null,
    );
  }

  Widget _buildCompanyCheckbox() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: Row(
        children: [
          SizedBox(
            width: 24,
            height: 24,
            child: Checkbox(
              value: _isCompany,
              onChanged: (value) {
                setState(() {
                  _isCompany = value ?? false;
                  if (!_isCompany) {
                    _companyNameController.clear();
                  }
                });
              },
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              setState(() {
                _isCompany = !_isCompany;
                if (!_isCompany) {
                  _companyNameController.clear();
                }
              });
            },
            child: const Text(
              'Представляю компанию',
              style: TextStyle(fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    int maxLines = 1,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, color: purple, size: 21),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(color: Color(0xFFE5E5E5)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(color: Color(0xFFE5E5E5)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(color: purple, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(color: Colors.redAccent),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 14,
        ),
      ),
    );
  }

  Widget _buildSuccess() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 10),
        Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            color: const Color(0xFFF1EBFF),
            borderRadius: BorderRadius.circular(36),
          ),
          child: const Icon(
            Icons.check_circle_outline,
            color: purple,
            size: 40,
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'Заявка отправлена!',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'Мы получили вашу заявку и свяжемся\nс вами в ближайшее время.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 15,
            height: 1.6,
            color: Colors.black54,
          ),
        ),
        const SizedBox(height: 30),
        SizedBox(
          width: double.infinity,
          height: 52,
          child: ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: purple,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            child: const Text(
              'Закрыть',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// =============================================================
// HOVER CARD
// =============================================================

class _HoverContactCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color purple;
  final VoidCallback onTap;

  const _HoverContactCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.purple,
    required this.onTap,
  });

  @override
  State<_HoverContactCard> createState() => _HoverContactCardState();
}

class _HoverContactCardState extends State<_HoverContactCard> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,

      onEnter: (_) {
        setState(() {
          isHover = true;
        });
      },

      onExit: (_) {
        setState(() {
          isHover = false;
        });
      },

      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          width: double.infinity,
          padding: const EdgeInsets.all(17),
          decoration: BoxDecoration(
            color: isHover
                ? const Color(0xFFF8F5FF)
                : Colors.white,
            border: Border.all(
              color: isHover
                  ? widget.purple
                  : const Color(0xFFE5E5E5),
            ),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: isHover
                      ? widget.purple
                      : const Color(0xFFF1EBFF),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Icon(
                  widget.icon,
                  color: isHover
                      ? Colors.white
                      : widget.purple,
                  size: 23,
                ),
              ),

              const SizedBox(width: 15),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      widget.subtitle,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),

              AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                transform: Matrix4.translationValues(
                  isHover ? 4 : 0,
                  0,
                  0,
                ),
                child: Icon(
                  Icons.arrow_forward,
                  size: 19,
                  color: isHover
                      ? widget.purple
                      : Colors.black26,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}