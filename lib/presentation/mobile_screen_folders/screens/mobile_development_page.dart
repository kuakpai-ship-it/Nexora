import 'package:flutter/material.dart';
import 'package:nexora/presentation/widgets/contacts_widget.dart';

class MobileDevelopmentPage extends StatelessWidget {
  const MobileDevelopmentPage({super.key});

  static const purple = Color(0xFF4412A7);
  static const lightGrey = Color(0xFFF7F7F7);

  void _showContacts(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return const ContactsWidget();
      },
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
          bottom: BorderSide(color: Color(0xFFE8E8E8)),
        ),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
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
          ElevatedButton(
            onPressed: () => _showContacts(context),
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

                  // ================= HERO =================

                  _HeroSection(
                    onContact: () {
                      _showContacts(context);
                    },
                  ),

                  // ================= SERVICES =================

                  _ServicesSection(),

                  // ================= TECHNOLOGIES =================

                  _TechnologiesSection(),

                  // ================= PROCESS =================

                  _ProcessSection(),

                  // ================= PROJECTS =================

                  _ProjectsSection(
                    onContact: () {
                      _showContacts(context);
                    },
                  ),

                  // ================= CONTACT =================

                  _ContactSection(
                    onContact: () {
                      _showContacts(context);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ======================================================
// HERO
// ======================================================

class _HeroSection extends StatelessWidget {
  final VoidCallback onContact;

  const _HeroSection({
    required this.onContact,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(
        minHeight: 650,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 60,
        vertical: 70,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {

          if (constraints.maxWidth < 800) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const Text(
                  'MOBILE\nDEVELOPMENT',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.w500,
                    height: 1.05,
                  ),
                ),

                const SizedBox(height: 25),

                const Text(
                  'Создаём современные мобильные '
                  'приложения для бизнеса, стартапов '
                  'и цифровых продуктов.',
                  style: TextStyle(
                    fontSize: 17,
                    height: 1.6,
                    color: Colors.black54,
                  ),
                ),

                const SizedBox(height: 35),

                ElevatedButton(
                  onPressed: onContact,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4412A7),
                    foregroundColor: Colors.white,
                    minimumSize: const Size(190, 55),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: const Text(
                    'Обсудить проект',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),

                const SizedBox(height: 50),

                const _PhoneIllustration(),
              ],
            );
          }

          return Row(
            children: [

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    const Text(
                      'MOBILE\nDEVELOPMENT',
                      style: TextStyle(
                        fontSize: 65,
                        fontWeight: FontWeight.w500,
                        height: 1.05,
                      ),
                    ),

                    const SizedBox(height: 30),

                    const SizedBox(
                      width: 600,
                      child: Text(
                        'Создаём современные мобильные '
                        'приложения для бизнеса, стартапов '
                        'и цифровых продуктов.',
                        style: TextStyle(
                          fontSize: 18,
                          height: 1.6,
                          color: Colors.black54,
                        ),
                      ),
                    ),

                    const SizedBox(height: 40),

                    ElevatedButton(
                      onPressed: onContact,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4412A7),
                        foregroundColor: Colors.white,
                        minimumSize: const Size(200, 55),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: const Text(
                        'Обсудить проект',
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 50),

              const Expanded(
                child: _PhoneIllustration(),
              ),
            ],
          );
        },
      ),
    );
  }
}

// ======================================================
// PHONE ILLUSTRATION
// ======================================================

class _PhoneIllustration extends StatelessWidget {
  const _PhoneIllustration();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 260,
        height: 500,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(38),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 35,
              offset: const Offset(0, 20),
            ),
          ],
        ),
        padding: const EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF7F7F7),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Column(
            children: [

              const SizedBox(height: 12),

              Container(
                width: 75,
                height: 22,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(15),
                ),
              ),

              const SizedBox(height: 50),

              const Text(
                'NEXORA',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4412A7),
                ),
              ),

              const SizedBox(height: 15),

              const Text(
                'Mobile App',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black54,
                ),
              ),

              const Spacer(),

              Container(
                margin: const EdgeInsets.all(25),
                height: 55,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFF4412A7),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Text(
                    'START',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}

// ======================================================
// SERVICES
// ======================================================

class _ServicesSection extends StatelessWidget {
  final List<String> services = const [
    'iOS разработка',
    'Android разработка',
    'Flutter разработка',
    'Кроссплатформенные приложения',
    'UI/UX дизайн',
    'Backend и API',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: const Color(0xFFF7F7F7),
      padding: const EdgeInsets.symmetric(
        horizontal: 60,
        vertical: 80,
      ),
      child: Container(
        padding: const EdgeInsets.all(50),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: const Color(0xFF4412A7),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text(
              '01',
              style: TextStyle(
                color: Color(0xFF4412A7),
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 45),

            const Text(
              'Мобильная разработка',
              style: TextStyle(
                fontSize: 52,
                fontWeight: FontWeight.w500,
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Создаём удобные приложения, которые '
              'работают на разных устройствах и платформах.',
              style: TextStyle(
                fontSize: 17,
                color: Colors.black54,
                height: 1.6,
              ),
            ),

            const SizedBox(height: 60),

            LayoutBuilder(
              builder: (context, constraints) {

                int columns = 2;

                if (constraints.maxWidth < 700) {
                  columns = 1;
                }

                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: services.length,
                  gridDelegate:
                      SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: columns,
                    crossAxisSpacing: 25,
                    mainAxisSpacing: 15,
                    childAspectRatio: 5,
                  ),
                  itemBuilder: (context, index) {

                    return _HoverServiceItem(
                      number: '0${index + 1}',
                      title: services[index],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// ======================================================
// SERVICE ITEM
// ======================================================

class _HoverServiceItem extends StatefulWidget {
  final String number;
  final String title;

  const _HoverServiceItem({
    required this.number,
    required this.title,
  });

  @override
  State<_HoverServiceItem> createState() =>
      _HoverServiceItemState();
}

class _HoverServiceItemState extends State<_HoverServiceItem> {

  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
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
        duration: const Duration(milliseconds: 200),

        transform: Matrix4.translationValues(
          isHover ? 8 : 0,
          0,
          0,
        ),

        padding: const EdgeInsets.symmetric(
          vertical: 15,
        ),

        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isHover
                  ? const Color(0xFF4412A7)
                  : const Color(0xFFE0E0E0),
              width: isHover ? 2 : 1,
            ),
          ),
        ),

        child: Row(
          children: [

            SizedBox(
              width: 45,
              child: Text(
                widget.number,
                style: const TextStyle(
                  fontSize: 13,
                  color: Color(0xFF4412A7),
                ),
              ),
            ),

            Expanded(
              child: Text(
                widget.title,
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: isHover
                      ? FontWeight.w500
                      : FontWeight.w400,
                ),
              ),
            ),

            AnimatedOpacity(
              duration: const Duration(milliseconds: 200),
              opacity: isHover ? 1 : 0,
              child: const Icon(
                Icons.arrow_forward,
                color: Color(0xFF4412A7),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ======================================================
// TECHNOLOGIES
// ======================================================

class _TechnologiesSection extends StatelessWidget {

  final List<String> technologies = const [
    'Flutter',
    'Dart',
    'Swift',
    'Kotlin',
    'Firebase',
    'REST API',
    'PostgreSQL',
    'GitHub',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 60,
        vertical: 80,
      ),
      child: Container(
        padding: const EdgeInsets.all(50),
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xFF4412A7),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text(
              '02',
              style: TextStyle(
                color: Color(0xFF4412A7),
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 45),

            const Text(
              'Технологии',
              style: TextStyle(
                fontSize: 52,
                fontWeight: FontWeight.w500,
              ),
            ),

            const SizedBox(height: 50),

            LayoutBuilder(
              builder: (context, constraints) {

                int columns = 4;

                if (constraints.maxWidth < 900) {
                  columns = 2;
                }

                if (constraints.maxWidth < 600) {
                  columns = 1;
                }

                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),

                  itemCount: technologies.length,

                  gridDelegate:
                      SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: columns,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    childAspectRatio: 3,
                  ),

                  itemBuilder: (context, index) {

                    return Container(
                      padding: const EdgeInsets.all(18),

                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xFFE0E0E0),
                        ),
                      ),

                      child: Row(
                        children: [

                          const Icon(
                            Icons.code,
                            color: Color(0xFF4412A7),
                          ),

                          const SizedBox(width: 15),

                          Text(
                            technologies[index],
                            style: const TextStyle(
                              fontSize: 17,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// ======================================================
// PROCESS
// ======================================================

class _ProcessSection extends StatelessWidget {

  final List<String> steps = const [
    'Анализ идеи',
    'Прототип',
    'UI/UX дизайн',
    'Разработка',
    'Тестирование',
    'Публикация',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: const Color(0xFFF7F7F7),
      padding: const EdgeInsets.symmetric(
        horizontal: 60,
        vertical: 80,
      ),
      child: Container(
        padding: const EdgeInsets.all(50),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text(
              '03',
              style: TextStyle(
                color: Color(0xFF4412A7),
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 45),

            const Text(
              'Этапы разработки',
              style: TextStyle(
                fontSize: 52,
                fontWeight: FontWeight.w500,
              ),
            ),

            const SizedBox(height: 50),

            ...List.generate(
              steps.length,
              (index) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                  ),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Color(0xFFE0E0E0),
                      ),
                    ),
                  ),
                  child: Row(
                    children: [

                      SizedBox(
                        width: 60,
                        child: Text(
                          '0${index + 1}',
                          style: const TextStyle(
                            color: Color(0xFF4412A7),
                            fontSize: 14,
                          ),
                        ),
                      ),

                      Expanded(
                        child: Text(
                          steps[index],
                          style: const TextStyle(
                            fontSize: 22,
                          ),
                        ),
                      ),

                      const Icon(
                        Icons.arrow_forward,
                        size: 20,
                        color: Color(0xFF4412A7),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// ======================================================
// PROJECTS
// ======================================================

class _ProjectsSection extends StatelessWidget {
  final VoidCallback onContact;

  const _ProjectsSection({
    required this.onContact,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 60,
        vertical: 90,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          const Text(
            '04',
            style: TextStyle(
              color: Color(0xFF4412A7),
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 35),

          const Text(
            'Наши проекты',
            style: TextStyle(
              fontSize: 52,
              fontWeight: FontWeight.w500,
            ),
          ),

          const SizedBox(height: 50),

          LayoutBuilder(
            builder: (context, constraints) {

              int columns = 2;

              if (constraints.maxWidth < 700) {
                columns = 1;
              }

              return GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: columns,
                crossAxisSpacing: 25,
                mainAxisSpacing: 25,
                childAspectRatio: 1.3,

                children: const [

                  _ProjectCard(
                    icon: Icons.shopping_bag_outlined,
                    title: 'Shop App',
                    text: 'Мобильное приложение для онлайн-магазина.',
                  ),

                  _ProjectCard(
                    icon: Icons.fitness_center,
                    title: 'Fit App',
                    text: 'Приложение для тренировок и контроля прогресса.',
                  ),

                  _ProjectCard(
                    icon: Icons.account_balance_wallet_outlined,
                    title: 'Finance App',
                    text: 'Удобное приложение для управления финансами.',
                  ),

                  _ProjectCard(
                    icon: Icons.local_taxi_outlined,
                    title: 'Taxi App',
                    text: 'Сервис заказа поездок с мобильного устройства.',
                  ),
                ],
              );
            },
          ),

          const SizedBox(height: 50),

          ElevatedButton(
            onPressed: onContact,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4412A7),
              foregroundColor: Colors.white,
              minimumSize: const Size(200, 55),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            child: const Text(
              'Создать приложение',
            ),
          ),
        ],
      ),
    );
  }
}

class _ProjectCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String text;

  const _ProjectCard({
    required this.icon,
    required this.title,
    required this.text,
  });

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {

  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
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
        duration: const Duration(milliseconds: 250),

        padding: const EdgeInsets.all(30),

        decoration: BoxDecoration(
          color: isHover
              ? const Color(0xFF4412A7)
              : Colors.white,

          border: Border.all(
            color: isHover
                ? const Color(0xFF4412A7)
                : const Color(0xFFE0E0E0),
          ),
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Icon(
              widget.icon,
              size: 45,
              color: isHover
                  ? Colors.white
                  : const Color(0xFF4412A7),
            ),

            const Spacer(),

            Text(
              widget.title,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w500,
                color: isHover
                    ? Colors.white
                    : Colors.black,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              widget.text,
              style: TextStyle(
                fontSize: 15,
                height: 1.5,
                color: isHover
                    ? Colors.white70
                    : Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ======================================================
// CONTACT
// ======================================================

class _ContactSection extends StatelessWidget {
  final VoidCallback onContact;

  const _ContactSection({
    required this.onContact,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: const Color(0xFF4412A7),
      padding: const EdgeInsets.symmetric(
        horizontal: 60,
        vertical: 90,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          const Text(
            '05',
            style: TextStyle(
              color: Colors.white70,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 35),

          const Text(
            'Есть идея\nдля приложения?',
            style: TextStyle(
              fontSize: 55,
              fontWeight: FontWeight.w500,
              color: Colors.white,
              height: 1.1,
            ),
          ),

          const SizedBox(height: 35),

          const Text(
            'Расскажите нам о проекте, а мы поможем '
            'превратить идею в готовое приложение.',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 17,
              height: 1.6,
            ),
          ),

          const SizedBox(height: 40),

          ElevatedButton(
            onPressed: onContact,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: const Color(0xFF4412A7),
              minimumSize: const Size(210, 55),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            child: const Text(
              'Связаться с нами',
            ),
          ),
        ],
      ),
    );
  }
}