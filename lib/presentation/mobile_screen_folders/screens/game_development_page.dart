import 'package:flutter/material.dart';
import 'package:nexora/presentation/widgets/contacts_widget.dart';
import 'package:nexora/presentation/widgets/keyboard_scrollable.dart';
import 'package:nexora/presentation/widgets/segment_info.dart';
import 'package:nexora/presentation/widgets/service_page_header.dart';
import 'package:nexora/presentation/widgets/responsive_layout.dart';
import 'package:nexora/presentation/widgets/scroll_reveal.dart';

class GameDevelopmentPage extends StatelessWidget {
  const GameDevelopmentPage({super.key});

  static const purple = Color(0xFF4412A7);

  void _showContacts(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.white,
      builder: (context) {
        return const ContactsWidget();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,

      body: Column(
        children: [
          const ServicePageHeader(),
          Expanded(
            child: KeyboardScrollable(
              builder: (context, controller) => SingleChildScrollView(
                controller: controller,
                child: Column(
                  children: [
              // ================= HERO =================

              ScrollReveal(
                child: _GameHero(
                  onContact: () => showDialog(
                    context: context,
                    barrierColor: Colors.black54,
                    builder: (_) => const OrderRequestWidget(),
                  ),
                ),
              ),

              // ================= TYPES =================
              ScrollReveal(child: _GameTypes()),

              // ================= TECHNOLOGIES =================
              ScrollReveal(child: _GameTechnologies()),

              // ================= PROJECTS =================
              ScrollReveal(child: _GameProjects()),

              // ================= TEAM =================
              ScrollReveal(child: _GameTeam()),

              // ================= CONTACT =================
              ScrollReveal(
                child: _GameContact(
                  onContact: () {
                    _showContacts(context);
                  },
                ),
              ),
                  ],
                ),
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

  const _GameHero({required this.onContact});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: 650),
      padding: responsiveSectionInsets(context, vertical: 70),
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 800) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'GAME\nDEVELOPMENT',
                  style: TextStyle(
                    fontSize: responsiveHeadingSize(context, desktop: 48),
                    fontWeight: FontWeight.w500,
                    height: 1.05,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 25),

                const Text(
                  'Создаём игры, интерактивные миры '
                  'и игровые механики для мобильных '
                  'устройств и компьютеров.',
                  style: TextStyle(
                    fontSize: 19,
                    height: 1.6,
                    color: const Color(0xFFE8E8E8),
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
                  child: const Text('Создать игру'),
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
                        color: Colors.white,
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
                          color: const Color(0xFFE8E8E8),
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
                        style: TextStyle(fontSize: 19),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 50),

              const Expanded(child: _GameIllustration()),
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
          color: Colors.transparent,
          border: Border.all(color: const Color(0xFF4412A7)),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 35,
              left: 35,
              child: _Square(size: 80, icon: Icons.videogame_asset),
            ),

            Positioned(
              bottom: 35,
              right: 35,
              child: _Square(size: 80, icon: Icons.gamepad),
            ),

            Container(
              width: 210,
              height: 210,
              decoration: BoxDecoration(
                color: const Color(0xFF4412A7),
                borderRadius: BorderRadius.circular(35),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.15),
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

  const _Square({required this.size, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFF4412A7)),
      ),
      child: Icon(icon, color: const Color(0xFF4412A7), size: 35),
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

  static const List<String> _typeImages = [
    'assets/images/2dlogo.png',
    'assets/images/3dlogo.png',
    'assets/images/mobilegamelogo.png',
    'assets/images/arcadelogo.png',
    'assets/images/brainlogo.png',
    'assets/images/strategylogo.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.transparent,
      padding: responsiveSectionInsets(context, vertical: 80),
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(color: const Color(0xFF4412A7)),
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/images/Gamebiglogo.png',
                fit: BoxFit.cover,
                filterQuality: FilterQuality.high,
              ),
            ),
            Positioned.fill(
              child: ColoredBox(color: const Color(0xFF0D0520).withValues(alpha: 0.50)),
            ),
            Padding(
          padding: EdgeInsets.all(responsiveCardPadding(context)),
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Создаём игры',
              style: TextStyle(
                fontSize: responsiveHeadingSize(context),
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'От идеи и концепции до готового игрового продукта.',
              style: TextStyle(fontSize: 19, color: const Color(0xFFE8E8E8)),
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
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: columns,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    childAspectRatio: 2.5,
                  ),
                  itemBuilder: (context, index) {
                    return _GameTypeCard(
                      index: index,
                      number: '0${index + 1}',
                      title: types[index],
                      imagePath: _typeImages[index],
                      onTap: () => showSegmentInfo(context, types[index]),
                    );
                  },
                );
              },
            ),
          ],
        ),
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
  final VoidCallback onTap;
  final int index;
  final String imagePath;

  const _GameTypeCard({
    required this.number,
    required this.title,
    required this.onTap,
    required this.index,
    required this.imagePath,
  });

  @override
  State<_GameTypeCard> createState() => _GameTypeCardState();
}

class _GameTypeCardState extends State<_GameTypeCard> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => isHover = true),
      onExit: (_) => setState(() => isHover = false),

      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: isHover ? const Color(0xFF4412A7) : Colors.transparent,
            border: Border.all(
              color: isHover ? const Color(0xFF7C3AED) : const Color(0xFF2D1B69),
            ),
            borderRadius: BorderRadius.circular(6),
          ),

          child: Stack(
            fit: StackFit.expand,
            children: [
              // Фоновое изображение — полная яркость
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.asset(
                  widget.imagePath,
                  fit: BoxFit.cover,
                ),
              ),

              // Только стрелка в углу
              Positioned(
                right: 14,
                bottom: 12,
                child: Icon(
                  Icons.arrow_forward,
                  color: isHover ? Colors.white : const Color(0xFFE8E8E8),
                ),
              ),
            ],
          ),
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
    {'name': 'Unity',      'image': 'assets/images/unitylogo.png'},
    {'name': 'Flutter',    'image': 'assets/images/image.png'},
    {'name': 'Java',       'image': 'assets/images/javascript.png'},
    {'name': 'Swift',      'image': 'assets/images/swiftlogo.png'},
    {'name': 'Kotlin',     'image': 'assets/images/kotlinlogo.png'},
    {'name': 'Firebase',   'image': 'assets/images/firebaselogo.png'},
    {'name': 'Python',     'image': 'assets/images/pythonphoto.png'},
    {'name': 'JavaScript', 'image': 'assets/images/javascript.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: responsiveSectionInsets(context, vertical: 80),
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFF4412A7)),
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/images/languege3.png',
                fit: BoxFit.cover,
                filterQuality: FilterQuality.high,
              ),
            ),
            Positioned.fill(
              child: ColoredBox(color: const Color(0xFF0D0520).withValues(alpha: 0.50)),
            ),
            Padding(
          padding: EdgeInsets.all(responsiveCardPadding(context)),
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Технологии',
              style: TextStyle(
                fontSize: responsiveHeadingSize(context),
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 50),

            LayoutBuilder(
              builder: (context, constraints) {
                final columns = constraints.maxWidth < 360
                    ? 1
                    : constraints.maxWidth < 700
                    ? 2
                    : constraints.maxWidth < 1000
                    ? 3
                    : 4;
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: technologies.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: columns,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    childAspectRatio: 2.5,
                  ),
                  itemBuilder: (context, index) {
                    final name = technologies[index]['name'] as String;
                    final image = technologies[index]['image'] as String;
                    final isSwift = name == 'Swift';
                    return InkWell(
                      onTap: () => showSegmentInfo(context, name),
                      child: Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFF2D1B69)),
                          color: isSwift ? Colors.black : null,
                        ),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.asset(
                              image,
                              fit: isSwift ? BoxFit.contain : BoxFit.cover,
                            ),
                            const Positioned(
                              right: 14,
                              bottom: 12,
                              child: Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
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
      'image': 'assets/images/braingamelogo.png',
    },
    {
      'title': 'Color World',
      'text': 'Творческая игра с цветами.',
      'image': 'assets/images/colorgamelogo.png',
    },
    {
      'title': 'Sound Guess',
      'text': 'Музыкальная викторина.',
      'image': 'assets/images/musiclgamelogo.png',
    },
    {
      'title': 'Space Quest',
      'text': 'Приключение в космическом мире.',
      'image': 'assets/images/spacegamelogo.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.transparent,
      padding: responsiveSectionInsets(context, vertical: 80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Игровые проекты',
            style: TextStyle(
              fontSize: responsiveHeadingSize(context),
              fontWeight: FontWeight.w500,
              color: Colors.white,
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

                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: columns,
                  crossAxisSpacing: 25,
                  mainAxisSpacing: 25,
                  childAspectRatio: 1.5,
                ),

                itemBuilder: (context, index) {
                  return _GameProjectCard(
                    title: projects[index]['title'],
                    text: projects[index]['text'],
                    image: projects[index]['image'],
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
  final String image;

  const _GameProjectCard({
    required this.title,
    required this.text,
    required this.image,
  });

  @override
  State<_GameProjectCard> createState() => _GameProjectCardState();
}

class _GameProjectCardState extends State<_GameProjectCard> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHover = true),
      onExit: (_) => setState(() => isHover = false),

      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        decoration: BoxDecoration(
          border: Border.all(
            color: isHover ? const Color(0xFF7C3AED) : const Color(0xFF2D1B69),
          ),
          borderRadius: BorderRadius.circular(8),
        ),

        child: Stack(
          fit: StackFit.expand,
          children: [
            // Изображение на весь фон
            ClipRRect(
              borderRadius: BorderRadius.circular(7),
              child: Image.asset(
                widget.image,
                fit: BoxFit.cover,
              ),
            ),

            // Затемнение снизу для читаемости текста
            ClipRRect(
              borderRadius: BorderRadius.circular(7),
              child: const DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0x00000000),
                      Color(0xCC000000),
                    ],
                  ),
                ),
              ),
            ),

            // Текст снизу
            Positioned(
              left: 20,
              right: 20,
              bottom: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    widget.text,
                    style: const TextStyle(
                      fontSize: 14,
                      color: const Color(0xFFE8E8E8),
                      height: 1.4,
                    ),
                  ),
                ],
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
      padding: responsiveSectionInsets(context, vertical: 80),
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFF4412A7)),
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/images/Gamemakerlogo.png',
                fit: BoxFit.cover,
                filterQuality: FilterQuality.high,
              ),
            ),
            Positioned.fill(
              child: ColoredBox(color: const Color(0xFF0D0520).withValues(alpha: 0.50)),
            ),
            Padding(
          padding: EdgeInsets.all(responsiveCardPadding(context)),
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Команда проекта',
              style: TextStyle(
                fontSize: responsiveHeadingSize(context),
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 50),

            ...List.generate(team.length, (index) {
              return Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: Color(0x33FFFFFF))),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 60,
                      child: Text(
                        '0${index + 1}',
                        style: const TextStyle(color: Color(0xFF4412A7)),
                      ),
                    ),

                    Expanded(
                      child: Text(
                        team[index],
                        style: const TextStyle(fontSize: 21, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
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

class _GameContact extends StatelessWidget {
  final VoidCallback onContact;

  const _GameContact({required this.onContact});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      padding: responsiveSectionInsets(context, vertical: 90),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Готовы создать\nсвою игру?',
            style: TextStyle(
              fontSize: responsiveHeadingSize(context, desktop: 55),
              fontWeight: FontWeight.w500,
              height: 1.1,
              color: Colors.white,
            ),
          ),

          const SizedBox(height: 35),

          const Text(
            'Расскажите нам свою идею, '
            'а мы поможем превратить её в игру.',
            style: TextStyle(fontSize: 19, height: 1.6, color: const Color(0xFFE8E8E8)),
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
            child: const Text('Связаться с нами'),
          ),
        ],
      ),
    );
  }
}


