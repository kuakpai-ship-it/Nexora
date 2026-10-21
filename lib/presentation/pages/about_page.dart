import 'package:flutter/material.dart';

import 'package:nexora/presentation/widgets/contacts_widget.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  static const Color purple = Color(0xFF4412A7);

  void _showContacts(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return const ContactsWidget();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildHero(context),
                  _buildAboutText(context),
                  _buildTeam(context),
                  _buildContactSection(context),
                  _buildFooter(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 60,
        vertical: 22,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFE8E8E8),
          ),
        ),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
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

          if (MediaQuery.of(context).size.width > 750) ...[
            _headerButton(
              title: 'Главная',
              onTap: () {
                Navigator.pop(context);
              },
            ),

            const SizedBox(width: 30),

            _headerButton(
              title: 'О нас',
              onTap: () {},
            ),

            const SizedBox(width: 30),

            _headerButton(
              title: 'Контакты',
              onTap: () {
                _showContacts(context);
              },
            ),

            const SizedBox(width: 30),
          ],

          ElevatedButton(
            onPressed: () {
              _showContacts(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: purple,
              foregroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(
                horizontal: 22,
                vertical: 15,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            child: const Text(
              'Связаться',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _headerButton({
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildHero(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal:
            MediaQuery.of(context).size.width > 900 ? 80 : 25,
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
              Expanded(
                flex: 3,
                child: _heroText(),
              ),

              Expanded(
                flex: 2,
                child: _buildTeamNumber(),
              ),
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
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 7,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFFF1EBFF),
            borderRadius: BorderRadius.circular(4),
          ),
          child: const Text(
            'О НАС',
            style: TextStyle(
              color: purple,
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
            fontSize: 52,
            height: 1.05,
            fontWeight: FontWeight.w600,
            letterSpacing: -1.5,
          ),
        ),

        const SizedBox(height: 25),

        const Text(
          'Nexora — команда разработчиков и специалистов, '
          'которая создаёт современные цифровые продукты '
          'для бизнеса и пользователей.',
          style: TextStyle(
            fontSize: 17,
            height: 1.7,
            color: Colors.black54,
          ),
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
        horizontal:
            MediaQuery.of(context).size.width > 900 ? 80 : 25,
        vertical: 70,
      ),
      decoration: const BoxDecoration(
        color: Color(0xFFF7F7F7),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 750) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _sectionTitle(),
                const SizedBox(height: 35),
                _description(),
              ],
            );
          }

          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _sectionTitle(),
              ),

              const SizedBox(width: 60),

              const Expanded(
                flex: 2,
                child: Text(
                  'Мы объединяем разработку, менеджмент и '
                  'администрирование в одной команде.\n\n'
                  'Наша задача — превращать идеи в понятные, '
                  'современные и удобные цифровые продукты.\n\n'
                  'Мы уделяем внимание дизайну, удобству '
                  'использования, качеству кода и стабильной работе.',
                  style: TextStyle(
                    fontSize: 17,
                    height: 1.8,
                    color: Colors.black54,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _sectionTitle() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '02',
          style: TextStyle(
            fontSize: 15,
            color: purple,
            fontWeight: FontWeight.w700,
          ),
        ),

        SizedBox(height: 15),

        Text(
          'О компании',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _description() {
    return const Text(
      'Мы объединяем разработку, менеджмент и '
      'администрирование в одной команде.\n\n'
      'Наша задача — превращать идеи в понятные, '
      'современные и удобные цифровые продукты.\n\n'
      'Мы уделяем внимание дизайну, удобству использования, '
      'качеству кода и стабильной работе готового продукта.',
      style: TextStyle(
        fontSize: 17,
        height: 1.8,
        color: Colors.black54,
      ),
    );
  }

  Widget _buildTeam(BuildContext context) {
    final List<Map<String, String>> team = [
      {
        'name': 'Абдукаримов Бейбарыс',
        'role': 'Разработчик',
        'letters': 'БА',
      },
      {
        'name': 'Куакпай Азат',
        'role': 'Разработчик',
        'letters': 'АК',
      },
      {
        'name': 'Айдар Алмас',
        'role': 'Менеджер',
        'letters': 'АА',
      },
      {
        'name': 'Руслан Такрепов',
        'role': 'Администратор',
        'letters': 'РТ',
      },
      {
        'name': 'Вячеслав Бондаренко',
        'role': 'Администратор',
        'letters': 'ВБ',
      },
    ];

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal:
            MediaQuery.of(context).size.width > 900 ? 80 : 25,
        vertical: 80,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '03',
            style: TextStyle(
              fontSize: 15,
              color: purple,
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: 15),

          const Text(
            'Наша команда',
            style: TextStyle(
              fontSize: 38,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 45),

          LayoutBuilder(
            builder: (context, constraints) {
              int columns = 3;

              if (constraints.maxWidth < 900) {
                columns = 2;
              }

              if (constraints.maxWidth < 560) {
                columns = 1;
              }

              return GridView.builder(
                shrinkWrap: true,
                physics:
                    const NeverScrollableScrollPhysics(),
                itemCount: team.length,
                gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: columns,
                  crossAxisSpacing: 18,
                  mainAxisSpacing: 18,
                  childAspectRatio:
                      columns == 1 ? 2.5 : 1.45,
                ),
                itemBuilder: (context, index) {
                  return _TeamCard(
                    name: team[index]['name']!,
                    role: team[index]['role']!,
                    letters: team[index]['letters']!,
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildContactSection(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(
        horizontal: 25,
      ),
      padding: const EdgeInsets.all(45),
      decoration: BoxDecoration(
        color: purple,
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
              Expanded(
                child: _contactText(),
              ),

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
          style: TextStyle(
            fontSize: 16,
            color: Colors.white70,
          ),
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
        backgroundColor: Colors.white,
        foregroundColor: purple,
        elevation: 0,
        padding: const EdgeInsets.symmetric(
          horizontal: 28,
          vertical: 18,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      child: const Text(
        'Связаться с нами',
        style: TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return const Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 60,
        vertical: 35,
      ),
      child: Row(
        children: [
          Text(
            'NEXORA',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
            ),
          ),

          Spacer(),

          Text(
            '© 2026 Nexora',
            style: TextStyle(
              fontSize: 13,
              color: Colors.black45,
            ),
          ),
        ],
      ),
    );
  }
}

class _TeamCard extends StatefulWidget {
  final String name;
  final String role;
  final String letters;

  const _TeamCard({
    required this.name,
    required this.role,
    required this.letters,
  });

  @override
  State<_TeamCard> createState() => _TeamCardState();
}

class _TeamCardState extends State<_TeamCard> {
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
      child: AnimatedContainer(
        duration: const Duration(
          milliseconds: 180,
        ),
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
          color: isHover
              ? const Color(0xFFF8F5FF)
              : Colors.white,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: isHover
                ? const Color(0xFF4412A7)
                : const Color(0xFFE5E5E5),
          ),
        ),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            AnimatedContainer(
              duration: const Duration(
                milliseconds: 180,
              ),
              width: 62,
              height: 62,
              decoration: BoxDecoration(
                color: isHover
                    ? const Color(0xFF4412A7)
                    : const Color(0xFFF1EBFF),
                borderRadius:
                    BorderRadius.circular(5),
              ),
              child: Center(
                child: Text(
                  widget.letters,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: isHover
                        ? Colors.white
                        : const Color(0xFF4412A7),
                  ),
                ),
              ),
            ),

            const Spacer(),

            Text(
              widget.name,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 7),

            const SizedBox(),

            Text(
              widget.role,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF4412A7),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}