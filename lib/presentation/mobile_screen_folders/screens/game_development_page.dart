import 'package:flutter/material.dart';
import 'package:nexora/presentation/widgets/contacts_widget.dart';

class GameDevelopmentPage extends StatelessWidget {
  const GameDevelopmentPage({super.key});

  static const purple = Color(0xFF4412A7);

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

                  _GameHero(
                    onContact: () {
                      _showContacts(context);
                    },
                  ),

                  // ================= TYPES =================

                  _GameTypes(),

                  // ================= TECHNOLOGIES =================

                  _GameTechnologies(),

                  // ================= PROJECTS =================

                  _GameProjects(),

                  // ================= TEAM =================

                  _GameTeam(),

                  // ================= CONTACT =================

                  _GameContact(
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

class _GameHero extends StatelessWidget {
  final VoidCallback onContact;

  const _GameHero({
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
                  'GAME\nDEVELOPMENT',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.w500,
                    height: 1.05,
                  ),
                ),

                const SizedBox(height: 25),

                const Text(
                  'Создаём игры, интерактивные миры '
                  'и игровые механики для мобильных '
                  'устройств и компьютеров.',
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
                    'Создать игру',
                  ),
                ),

                const SizedBox(height: 50),

                const _GameIllustration(),
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
                      'GAME\nDEVELOPMENT',
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
                        'Создаём игры, интерактивные миры '
                        'и игровые механики для мобильных '
                        'устройств и компьютеров.',
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
                        minimumSize: const Size(180, 55),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: const Text(
                        'Создать игру',
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
                child: _GameIllustration(),
              ),
            ],
          );
        },
      ),
    );
  }
}

// ======================================================
// GAME ILLUSTRATION
// ======================================================

class _GameIllustration extends StatelessWidget {
  const _GameIllustration();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 500,
        height: 400,
        decoration: BoxDecoration(
          color: const Color(0xFFF7F7F7),
          border: Border.all(
            color: const Color(0xFF4412A7),
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [

            Positioned(
              top: 35,
              left: 35,
              child: _Square(
                size: 80,
                icon: Icons.videogame_asset,
              ),
            ),

            Positioned(
              bottom: 35,
              right: 35,
              child: _Square(
                size: 80,
                icon: Icons.gamepad,
              ),
            ),

            Container(
              width: 210,
              height: 210,
              decoration: BoxDecoration(
                color: const Color(0xFF4412A7),
                borderRadius: BorderRadius.circular(35),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 30,
                    offset: const Offset(0, 15),
                  ),
                ],
              ),
              child: const Icon(
                Icons.sports_esports,
                color: Colors.white,
                size: 100,
              ),
            ),

            const Positioned(
              bottom: 25,
              left: 25,
              child: Text(
                'CREATE',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  color: Color(0xFF4412A7),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Square extends StatelessWidget {
  final double size;
  final IconData icon;

  const _Square({
    required this.size,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: const Color(0xFF4412A7),
        ),
      ),
      child: Icon(
        icon,
        color: const Color(0xFF4412A7),
        size: 35,
      ),
    );
  }
}

// ======================================================
// GAME TYPES
// ======================================================

class _GameTypes extends StatelessWidget {

  final List<String> types = const [
    '2D игры',
    '3D игры',
    'Мобильные игры',
    'Аркады',
    'Головоломки',
    'Стратегии',
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
              'Создаём игры',
              style: TextStyle(
                fontSize: 52,
                fontWeight: FontWeight.w500,
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'От идеи и концепции до готового игрового продукта.',
              style: TextStyle(
                fontSize: 17,
                color: Colors.black54,
              ),
            ),

            const SizedBox(height: 55),

            LayoutBuilder(
              builder: (context, constraints) {

                int columns = 3;

                if (constraints.maxWidth < 800) {
                  columns = 2;
                }

                if (constraints.maxWidth < 550) {
                  columns = 1;
                }

                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: types.length,
                  gridDelegate:
                      SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: columns,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    childAspectRatio: 2.5,
                  ),
                  itemBuilder: (context, index) {

                    return _GameTypeCard(
                      number: '0${index + 1}',
                      title: types[index],
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
// GAME TYPE CARD
// ======================================================

class _GameTypeCard extends StatefulWidget {
  final String number;
  final String title;

  const _GameTypeCard({
    required this.number,
    required this.title,
  });

  @override
  State<_GameTypeCard> createState() => _GameTypeCardState();
}

class _GameTypeCardState extends State<_GameTypeCard> {

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
        padding: const EdgeInsets.all(20),

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

        child: Row(
          children: [

            Text(
              widget.number,
              style: TextStyle(
                color: isHover
                    ? Colors.white70
                    : const Color(0xFF4412A7),
              ),
            ),

            const SizedBox(width: 20),

            Expanded(
              child: Text(
                widget.title,
                style: TextStyle(
                  fontSize: 18,
                  color: isHover
                      ? Colors.white
                      : Colors.black,
                ),
              ),
            ),

            Icon(
              Icons.arrow_forward,
              color: isHover
                  ? Colors.white
                  : const Color(0xFF4412A7),
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

class _GameTechnologies extends StatelessWidget {

  final List<Map<String, dynamic>> technologies = const [
    {
      'name': 'Unity',
      'icon': Icons.games,
    },
    {
      'name': 'Flutter',
      'icon': Icons.flutter_dash,
    },
    {
      'name': 'Java',
      'icon': Icons.code,
    },
    {
      'name': 'Swift',
      'icon': Icons.phone_iphone,
    },
    {
      'name': 'Kotlin',
      'icon': Icons.android,
    },
    {
      'name': 'Firebase',
      'icon': Icons.cloud,
    },
    {
      'name': 'Python',
      'icon': Icons.data_object,
    },
    {
      'name': 'JavaScript',
      'icon': Icons.javascript,
    },
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

            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: technologies.length,
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                childAspectRatio: 2.5,
              ),
              itemBuilder: (context, index) {

                return Container(
                  padding: const EdgeInsets.all(18),

                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: const Color(0xFFE0E0E0),
                    ),
                  ),

                  child: Row(
                    children: [

                      Icon(
                        technologies[index]['icon'],
                        color: const Color(0xFF4412A7),
                      ),

                      const SizedBox(width: 15),

                      Expanded(
                        child: Text(
                          technologies[index]['name'],
                          style: const TextStyle(
                            fontSize: 17,
                          ),
                        ),
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

class _GameProjects extends StatelessWidget {

  final List<Map<String, dynamic>> projects = const [
    {
      'title': 'Brain Game',
      'text': 'Игра на логику и эрудицию.',
      'icon': Icons.psychology,
    },
    {
      'title': 'Color World',
      'text': 'Творческая игра с цветами.',
      'icon': Icons.palette,
    },
    {
      'title': 'Sound Guess',
      'text': 'Музыкальная викторина.',
      'icon': Icons.music_note,
    },
    {
      'title': 'Space Quest',
      'text': 'Приключение в космическом мире.',
      'icon': Icons.rocket_launch,
    },
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

          const SizedBox(height: 35),

          const Text(
            'Игровые проекты',
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

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),

                itemCount: projects.length,

                gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: columns,
                  crossAxisSpacing: 25,
                  mainAxisSpacing: 25,
                  childAspectRatio: 1.5,
                ),

                itemBuilder: (context, index) {

                  return _GameProjectCard(
                    title: projects[index]['title'],
                    text: projects[index]['text'],
                    icon: projects[index]['icon'],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

// ======================================================
// PROJECT CARD
// ======================================================

class _GameProjectCard extends StatefulWidget {
  final String title;
  final String text;
  final IconData icon;

  const _GameProjectCard({
    required this.title,
    required this.text,
    required this.icon,
  });

  @override
  State<_GameProjectCard> createState() =>
      _GameProjectCardState();
}

class _GameProjectCardState extends State<_GameProjectCard> {

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
// TEAM
// ======================================================

class _GameTeam extends StatelessWidget {

  final List<String> team = const [
    'Геймдизайнер',
    'Разработчик',
    '3D / 2D дизайнер',
    'QA инженер',
    'Project Manager',
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
              '04',
              style: TextStyle(
                color: Color(0xFF4412A7),
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 40),

            const Text(
              'Команда проекта',
              style: TextStyle(
                fontSize: 52,
                fontWeight: FontWeight.w500,
              ),
            ),

            const SizedBox(height: 50),

            ...List.generate(
              team.length,
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
                          ),
                        ),
                      ),

                      Expanded(
                        child: Text(
                          team[index],
                          style: const TextStyle(
                            fontSize: 21,
                          ),
                        ),
                      ),

                      const Icon(
                        Icons.arrow_forward,
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
// CONTACT
// ======================================================

class _GameContact extends StatelessWidget {
  final VoidCallback onContact;

  const _GameContact({
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
            ),
          ),

          const SizedBox(height: 35),

          const Text(
            'Готовы создать\nсвою игру?',
            style: TextStyle(
              fontSize: 55,
              fontWeight: FontWeight.w500,
              height: 1.1,
              color: Colors.white,
            ),
          ),

          const SizedBox(height: 35),

          const Text(
            'Расскажите нам свою идею, '
            'а мы поможем превратить её в игру.',
            style: TextStyle(
              fontSize: 17,
              height: 1.6,
              color: Colors.white70,
            ),
          ),

          const SizedBox(height: 40),

          ElevatedButton(
            onPressed: onContact,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: const Color(0xFF4412A7),
              minimumSize: const Size(200, 55),
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