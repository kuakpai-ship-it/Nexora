import 'package:flutter/material.dart';

import 'package:nexora/presentation/widgets/contacts_widget.dart';
import 'package:nexora/presentation/widgets/keyboard_scrollable.dart';
import 'package:nexora/presentation/widgets/scroll_reveal.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  static const Color purple = Color(0xFF4412A7);

  void _showContacts(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.white,
      builder: (context) {
        return const ContactsWidget();
      },
    );
  }

  void _goHome(BuildContext context) {
    final navigator = Navigator.of(context);
    if (navigator.canPop()) {
      navigator.pop();
    } else {
      navigator.pushNamedAndRemoveUntil('/', (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: KeyboardScrollable(
              builder: (context, controller) => SingleChildScrollView(
                controller: controller,
                child: Column(
                  children: [
                    ScrollReveal(child: _buildHero(context)),
                    ScrollReveal(child: _buildAboutText(context)),
                    ScrollReveal(child: _buildTeam(context)),
                    ScrollReveal(child: _buildContactSection(context)),
                    ScrollReveal(child: _buildFooter(context)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final mobile = MediaQuery.sizeOf(context).width <= 750;
    final compact = MediaQuery.sizeOf(context).width < 600;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: compact ? 16 : 60,
        vertical: 16,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xFFE0E0E0))),
      ),
      child: Row(
        children: [
          IconButton(
            tooltip: 'На главную',
            onPressed: () => _goHome(context),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
            icon: const Icon(Icons.arrow_back, color: purple),
          ),
          GestureDetector(
            onTap: () => _goHome(context),
            child: const Text(
              'NEXORA',
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w800,
                color: purple,
                letterSpacing: 1,
              ),
            ),
          ),

          const Spacer(),

          if (!mobile) ...[
            PopupMenuButton<String>(
              tooltip: '',
              offset: const Offset(0, 48),
              onSelected: (route) => Navigator.pushNamed(context, route),
              itemBuilder: (context) => const [
                PopupMenuItem(value: '/web-mobile', child: Text('Web и Mobile разработка')),
                PopupMenuItem(value: '/games', child: Text('Разработка игр')),
                PopupMenuItem(value: '/machine-learning', child: Text('Машинное обучение')),
              ],
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                child: Text('Услуги', style: TextStyle(color: purple, fontSize: 14)),
              ),
            ),

            _headerButton(title: 'О нас', onTap: () {}),

            const SizedBox(width: 30),

            _headerButton(
              title: 'Админ',
              onTap: () => Navigator.pushNamed(context, '/admin'),
            ),

            const SizedBox(width: 20),

            ElevatedButton(
              onPressed: () => _showContacts(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: purple,
                foregroundColor: Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
              ),
              child: const Text('Связаться с нами', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
            ),

            const SizedBox(width: 10),
          ],

          if (mobile)
            PopupMenuButton<String>(
              tooltip: 'Меню',
              onSelected: (value) {
                if (value == 'contact') {
                  _showContacts(context);
                } else if (value == 'about') {
                  // уже на странице О нас
                } else {
                  Navigator.pushNamed(context, value);
                }
              },
              itemBuilder: (context) => const [
                PopupMenuItem(value: '/web-mobile', child: Text('Web и Mobile разработка')),
                PopupMenuItem(value: '/games', child: Text('Разработка игр')),
                PopupMenuItem(value: '/machine-learning', child: Text('Машинное обучение')),
                PopupMenuItem(value: 'about', child: Text('О нас')),
                PopupMenuItem(value: '/admin', child: Text('Админ')),
                PopupMenuItem(value: 'contact', child: Text('Свяжитесь с нами')),
              ],
              icon: const Icon(Icons.more_vert, color: purple),
            ),
        ],
      ),
    );
  }

  Widget _headerButton({required String title, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Text(
        title,
        style: const TextStyle(fontSize: 14, color: Color(0xFF333333)),
      ),
    );
  }

  Widget _buildHero(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width > 900 ? 80 : 25,
        vertical: 80,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 800) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _heroText(),
                const SizedBox(height: 50),
                _buildTeamNumber(),
              ],
            );
          }

          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(flex: 3, child: _heroText()),

              Expanded(flex: 2, child: _buildTeamNumber()),
            ],
          );
        },
      ),
    );
  }

  Widget _heroText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
          decoration: BoxDecoration(
            color: purple,
            borderRadius: BorderRadius.circular(4),
          ),
          child: const Text(
            'О НАС',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
            ),
          ),
        ),

        const SizedBox(height: 25),

        const Text(
          'Команда, которая\nсоздаёт решения',
          style: TextStyle(
            fontSize: 38,
            height: 1.05,
            fontWeight: FontWeight.w600,
            letterSpacing: -1.5,
            color: Colors.white,
          ),
        ),

        const SizedBox(height: 25),

        const Text(
          'Nexora — команда разработчиков и специалистов, '
          'которая создаёт современные цифровые продукты '
          'для бизнеса и пользователей.',
          style: TextStyle(fontSize: 19, height: 1.7, color: const Color(0xFFE8E8E8)),
        ),
      ],
    );
  }

  Widget _buildTeamNumber() {
    return const Align(
      alignment: Alignment.center,
      child: Text(
        '01',
        style: TextStyle(
          fontSize: 190,
          height: 0.8,
          fontWeight: FontWeight.w800,
          color: Color(0x144412A7),
        ),
      ),
    );
  }

  Widget _buildAboutText(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width > 900 ? 80 : 25,
        vertical: 40,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.asset(
          'assets/images/grouplogo.png',
          width: double.infinity,
          fit: BoxFit.cover,
          filterQuality: FilterQuality.high,
        ),
      ),
    );
  }

  Widget _buildTeam(BuildContext context) {
    final List<Map<String, String>> team = [
      {
        'name': 'Абдукаримов Бейбарыс',
        'role': 'Разработчик UI',
        'desc': 'Создание пользовательского интерфейса, экранов и виджетов. Flutter.',
        'letters': 'БА',
        'face': 'assets/images/Biba.png',
        'icon': 'assets/images/Bibalogo2.png',
      },
      {
        'name': 'Куакпай Азат',
        'role': 'Разработчик Backend',
        'desc': 'Работа с логикой, данными и серверной частью.',
        'letters': 'КА',
        'face': 'assets/images/Azat.png',
        'icon': 'assets/images/Azatlogo2.png',
      },
      {
        'name': 'Айдар Алмас',
        'role': 'Менеджер',
        'desc': 'Координация команды, планирование и контроль задач.',
        'letters': 'АА',
        'face': 'assets/images/Almas2.png',
        'icon': 'assets/images/Almaslogo2.png',
      },
      {
        'name': 'Руслан Такрепов',
        'role': 'Администратор',
        'desc': 'Поддержка системы, управление доступом и инфраструктурой.',
        'letters': 'РТ',
        'face': 'assets/images/Ruslan2.png',
        'icon': 'assets/images/Ruslanlogo2.png',
      },
      {
        'name': 'Вячеслав Бондаренко',
        'role': 'Администратор',
        'desc': 'Поддержка системы, управление доступом и инфраструктурой.',
        'letters': 'ВБ',
        'face': 'assets/images/Vachislav.png',
        'icon': 'assets/images/Vacheslavlogo2.png',
      },
    ];

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width > 900 ? 80 : 25,
        vertical: 80,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Наша команда',
            style: TextStyle(fontSize: 38, fontWeight: FontWeight.w600, color: Colors.white),
          ),

          const SizedBox(height: 45),

          LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                children: team.map((member) {
                  return _TeamCard(
                    name: member['name']!,
                    role: member['role']!,
                    desc: member['desc']!,
                    letters: member['letters']!,
                    face: member['face']!,
                    icon: member['icon']!,
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildContactSection(BuildContext context) {
    final compact = MediaQuery.sizeOf(context).width < 600;
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 25),
      padding: EdgeInsets.all(compact ? 22 : 45),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 700) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _contactText(),
                const SizedBox(height: 30),
                _contactButton(context),
              ],
            );
          }

          return Row(
            children: [
              Expanded(child: _contactText()),

              const SizedBox(width: 40),

              _contactButton(context),
            ],
          );
        },
      ),
    );
  }

  Widget _contactText() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Есть идея?',
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),

        SizedBox(height: 12),

        Text(
          'Давайте обсудим ваш проект',
          style: TextStyle(fontSize: 16, color: const Color(0xFFE8E8E8)),
        ),
      ],
    );
  }

  Widget _contactButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        _showContacts(context);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: purple,
        foregroundColor: Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      ),
      child: const Text(
        'Связаться с нами',
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.sizeOf(context).width < 600 ? 16 : 60,
        vertical: 35,
      ),
      child: const Row(
        children: [
          Text(
            'NEXORA',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Colors.white),
          ),

          Spacer(),

          Text(
            '© 2026 Nexora',
            style: TextStyle(fontSize: 13, color: Colors.white38),
          ),
        ],
      ),
    );
  }
}

class _TeamCard extends StatefulWidget {
  final String name;
  final String role;
  final String desc;
  final String letters;
  final String face;
  final String icon;

  const _TeamCard({
    required this.name,
    required this.role,
    required this.desc,
    required this.letters,
    required this.face,
    required this.icon,
  });

  @override
  State<_TeamCard> createState() => _TeamCardState();
}

class _TeamCardState extends State<_TeamCard> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    final hasFace = widget.face.isNotEmpty;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => isHover = true),
      onExit: (_) => setState(() => isHover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        margin: const EdgeInsets.only(bottom: 12),
        height: 200,
        decoration: BoxDecoration(
          color: isHover ? const Color(0xFF1A0A3B) : const Color(0xFF130827),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isHover ? const Color(0xFF7C3AED) : const Color(0xFF2D1B69),
          ),
        ),
      child: Stack(
          fit: StackFit.expand,
          children: [
            // Фоновая картинка на всю карточку
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                widget.icon,
                fit: BoxFit.fitHeight,
                alignment: Alignment.centerRight,
                filterQuality: FilterQuality.high,
              ),
            ),

            // Тёмный градиент слева для читаемости текста
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      const Color(0xFF130827).withValues(alpha: 0.98),
                      const Color(0xFF130827).withValues(alpha: 0.85),
                      const Color(0xFF130827).withValues(alpha: 0.4),
                      Colors.transparent,
                    ],
                    stops: const [0.0, 0.35, 0.6, 0.85],
                  ),
                ),
              ),
            ),

            // Контент поверх
            Row(
              children: [
                // Фото или инициалы слева
                ClipRRect(
                  borderRadius: const BorderRadius.horizontal(left: Radius.circular(9)),
                  child: hasFace
                      ? Image.asset(
                          widget.face,
                          width: 160,
                          height: 200,
                          fit: BoxFit.cover,
                          alignment: Alignment.topCenter,
                          filterQuality: FilterQuality.high,
                        )
                      : Container(
                          width: 160,
                          height: 200,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [const Color(0xFF3B1F8C), const Color(0xFF1E0F5C)],
                            ),
                          ),
                          child: Center(
                            child: Text(
                              widget.letters,
                              style: const TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                ),

                const SizedBox(width: 20),

                // Имя, роль и описание
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.role,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF9B7FE8),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.desc,
                        style: const TextStyle(
                          fontSize: 13,
                          color: const Color(0xFFE8E8E8),
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 16),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


