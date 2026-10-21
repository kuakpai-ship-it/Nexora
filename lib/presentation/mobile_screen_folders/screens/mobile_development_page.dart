import 'package:flutter/material.dart';
import 'package:nexora/presentation/widgets/segment_info.dart';
import 'package:nexora/presentation/widgets/contacts_widget.dart';
import 'package:nexora/presentation/widgets/keyboard_scrollable.dart';
import 'package:nexora/presentation/widgets/service_page_header.dart';
import 'package:nexora/presentation/widgets/responsive_layout.dart';
import 'package:nexora/presentation/widgets/scroll_reveal.dart';

class MobileDevelopmentPage extends StatelessWidget {
  const MobileDevelopmentPage({super.key});

  static const purple = Color(0xFF4412A7);
  static const lightGrey = Color(0xFFF7F7F7);

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

      body: KeyboardScrollable(
        builder: (context, controller) => SingleChildScrollView(
          controller: controller,
          child: Column(
            children: [
              const ServicePageHeader(),
              // ================= HERO =================

              ScrollReveal(
                child: _HeroSection(
                  onContact: () => showDialog(
                    context: context,
                    barrierColor: Colors.black54,
                    builder: (_) => const OrderRequestWidget(),
                  ),
                ),
              ),

              // ================= SERVICES =================
              ScrollReveal(child: _ServicesSection()),

              // ================= TECHNOLOGIES =================
              ScrollReveal(child: _TechnologiesSection()),

              // ================= PROCESS =================
              ScrollReveal(child: _ProcessSection()),

              // ================= PROJECTS =================
              ScrollReveal(
                child: _ProjectsSection(
                  onContact: () {
                    _showContacts(context);
                  },
                ),
              ),

              // ================= CONTACT =================
              ScrollReveal(
                child: _ContactSection(
                  onContact: () {
                    _showContacts(context);
                  },
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
// HERO
// ======================================================

class _HeroSection extends StatelessWidget {
  final VoidCallback onContact;

  const _HeroSection({required this.onContact});

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
                  'WEB + MOBILE\nDEVELOPMENT',
                  style: TextStyle(
                    fontSize: responsiveHeadingSize(context, desktop: 48),
                    fontWeight: FontWeight.w500,
                    height: 1.05,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 25),

                const Text(
                  'Создаём сайты, веб-сервисы и мобильные приложения '
                  'для бизнеса, стартапов и цифровых продуктов.',
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
                  child: const Text(
                    'Обсудить проект',
                    style: TextStyle(fontSize: 16),
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
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(height: 30),

                    const SizedBox(
                      width: 600,
                      child: Text(
                        'Создаём сайты, веб-сервисы и мобильные приложения '
                        'для бизнеса, стартапов и цифровых продуктов.',
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
                        minimumSize: const Size(200, 55),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: const Text(
                        'Обсудить проект',
                        style: TextStyle(fontSize: 19),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 50),

              const Expanded(child: _PhoneIllustration()),
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
              color: Colors.black.withValues(alpha: 0.15),
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
                style: TextStyle(fontSize: 18, color: Colors.black54),
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

  // Изображения для каждого сервиса (по порядку)
  static const List<String?> _serviceImages = [
    'assets/images/ioslogo.png',       // iOS разработка
    'assets/images/androidlogo.png',   // Android разработка
    'assets/images/flutterlogoai.png', // Flutter разработка
    'assets/images/kroslogo.png',      // Кроссплатформенные приложения
    'assets/images/uilogo.png',        // UI/UX дизайн
    'assets/images/beckendlogo.png',   // Backend и API
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
          border: Border.all(color: const Color(0xFF4412A7)),
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/images/mobilebig.png',
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
                  AspectRatio(
                    aspectRatio: 738 / 225,
                    child: Image.asset(
                      'assets/images/mobilelogo.png',
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Мобильная разработка',
                          style: TextStyle(
                            fontSize: responsiveHeadingSize(context),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    'Создаём удобные приложения, которые '
                    'работают на разных устройствах и платформах.',
                    style: TextStyle(
                      fontSize: 19,
                      color: const Color(0xFFE8E8E8),
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
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: columns,
                          crossAxisSpacing: 25,
                          mainAxisSpacing: 15,
                          childAspectRatio: 5,
                        ),
                        itemBuilder: (context, index) {
                          return _HoverServiceItem(
                            number: '0${index + 1}',
                            title: services[index],
                            imagePath: _serviceImages[index],
                            onTap: () => showSegmentInfo(context, services[index]),
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
// SERVICE ITEM
// ======================================================

class _HoverServiceItem extends StatefulWidget {
  final String number;
  final String title;
  final VoidCallback onTap;
  final String? imagePath;

  const _HoverServiceItem({
    required this.number,
    required this.title,
    required this.onTap,
    this.imagePath,
  });

  @override
  State<_HoverServiceItem> createState() => _HoverServiceItemState();
}

class _HoverServiceItemState extends State<_HoverServiceItem> {
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
            border: Border(
              bottom: BorderSide(
                color: isHover
                    ? const Color(0xFF7C3AED)
                    : const Color(0x33FFFFFF),
                width: isHover ? 2 : 1,
              ),
            ),
          ),

          child: Stack(
            fit: StackFit.expand,
            children: [
              // Фоновое изображение — полная яркость
              if (widget.imagePath != null)
                ClipRect(
                  child: Image.asset(
                    widget.imagePath!,
                    fit: BoxFit.cover,
                  ),
                ),

              // Только стрелка и разделитель снизу
              Positioned(
                right: 14,
                bottom: 0,
                top: 0,
                child: Center(
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 200),
                    opacity: isHover ? 1 : 0.7,
                    child: const Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              // Название услуги снизу слева
              Positioned(
                left: 16,
                bottom: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.55),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    widget.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
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

  static const _technologyImages = <String, String>{
    'Flutter': 'assets/images/image.png',
    'Dart': 'assets/images/dart.png',
    'Swift': 'assets/images/swiftlogo.png',
    'Kotlin': 'assets/images/kotlinlogo.png',
    'Firebase': 'assets/images/firebaselogo.png',
    'REST API': 'assets/images/restiplogo.png',
    'PostgreSQL': 'assets/images/postgresqllogo.png',
    'GitHub': 'assets/images/githublogo.png',
  };

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
                'assets/images/languege2.png',
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

                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: columns,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    childAspectRatio: 3,
                  ),

                  itemBuilder: (context, index) {
                    final technology = technologies[index];
                    final imageAsset = _technologyImages[technology];

                    if (imageAsset != null) {
                      return InkWell(
                        onTap: () => showSegmentInfo(context, technology),
                        child: Semantics(
                          button: true,
                          label: technology,
                          child: Container(
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color(0xFFE0E0E0),
                              ),
                            ),
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                Image.asset(
                                  imageAsset,
                                  fit: BoxFit.cover,
                                  alignment: Alignment.center,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const ColoredBox(
                                        color: Color(0xFFEDEAF3),
                                        child: Center(
                                          child: Icon(
                                            Icons.image_outlined,
                                            color: Color(0xFF4412A7),
                                          ),
                                        ),
                                      ),
                                ),
                                const DecoratedBox(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Color(0x00000000),
                                        Color(0x4D000000),
                                      ],
                                    ),
                                  ),
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
                        ),
                      );
                    }

                    return InkWell(
                      onTap: () => showSegmentInfo(context, technology),
                      child: Container(
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFFE0E0E0)),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.code, color: Color(0xFF4412A7)),
                            const SizedBox(width: 15),
                            Text(
                              technology,
                              style: const TextStyle(fontSize: 19, color: Colors.white),
                            ),
                            const Spacer(),
                            const Icon(
                              Icons.arrow_forward,
                              color: Color(0xFF4412A7),
                              size: 20,
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
      color: Colors.transparent,
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
                'assets/images/Etapslogo.png',
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
                    'Этапы разработки',
                    style: TextStyle(
                      fontSize: responsiveHeadingSize(context),
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 50),

                  ...List.generate(steps.length, (index) {
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
                              style: const TextStyle(
                                color: Color(0xFF4412A7),
                                fontSize: 14,
                              ),
                            ),
                          ),

                          Expanded(
                            child: Text(
                              steps[index],
                              style: const TextStyle(fontSize: 22, color: Colors.white),
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
// PROJECTS
// ======================================================

class _ProjectsSection extends StatelessWidget {
  final VoidCallback onContact;

  const _ProjectsSection({required this.onContact});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: responsiveSectionInsets(context, vertical: 90),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Наши проекты',
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

              final spacing = 25.0;
              return Wrap(
                spacing: spacing,
                runSpacing: spacing,
                children: [
                  _ProjectCard(
                    quadrant: 0,
                    title: 'Shop App',
                    text: 'Мобильное приложение для онлайн-магазина.',
                    cardWidth: columns == 1
                        ? constraints.maxWidth
                        : (constraints.maxWidth - spacing) / 2,
                  ),
                  _ProjectCard(
                    quadrant: 1,
                    title: 'Fit App',
                    text: 'Приложение для тренировок и контроля прогресса.',
                    cardWidth: columns == 1
                        ? constraints.maxWidth
                        : (constraints.maxWidth - spacing) / 2,
                  ),
                  _ProjectCard(
                    quadrant: 2,
                    title: 'Finance App',
                    text: 'Удобное приложение для управления финансами.',
                    cardWidth: columns == 1
                        ? constraints.maxWidth
                        : (constraints.maxWidth - spacing) / 2,
                  ),
                  _ProjectCard(
                    quadrant: 3,
                    title: 'Taxi App',
                    text: 'Сервис заказа поездок с мобильного устройства.',
                    cardWidth: columns == 1
                        ? constraints.maxWidth
                        : (constraints.maxWidth - spacing) / 2,
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
            child: const Text('Создать приложение'),
          ),
        ],
      ),
    );
  }
}

class _ProjectCard extends StatefulWidget {
  final String title;
  final String text;
  final int quadrant;
  final double cardWidth;

  const _ProjectCard({
    required this.title,
    required this.text,
    required this.quadrant,
    required this.cardWidth,
  });

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool isHover = false;

  // Смещение для нужного квадранта (применяется к изображению 2x размера)
  Offset _quadrantOffset(double w, double h) {
    switch (widget.quadrant) {
      case 0: return Offset(0, 0);
      case 1: return Offset(-w / 2, 0);
      case 2: return Offset(0, -h / 2);
      case 3: return Offset(-w / 2, -h / 2);
      default: return Offset(0, 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.cardWidth,
      child: MouseRegion(
        onEnter: (_) => setState(() => isHover = true),
        onExit: (_) => setState(() => isHover = false),

        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          decoration: BoxDecoration(
            color: isHover ? const Color(0xFF4412A7) : const Color(0xFF1A0A3B),
            border: Border.all(
              color: isHover ? const Color(0xFF7C3AED) : const Color(0xFF2D1B69),
            ),
            borderRadius: BorderRadius.circular(8),
          ),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Изображение — показываем нужный квадрант
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(7)),
                child: SizedBox(
                  width: widget.cardWidth,
                  height: widget.cardWidth * 9 / 16,
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final imgW = constraints.maxWidth * 2;
                      final imgH = constraints.maxHeight * 2;
                      return OverflowBox(
                        maxWidth: imgW,
                        maxHeight: imgH,
                        alignment: Alignment.topLeft,
                        child: Transform.translate(
                          offset: _quadrantOffset(imgW, imgH),
                          child: Image.asset(
                            'assets/images/projectlogos.png',
                            width: imgW,
                            height: imgH,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),

              // Текст
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      widget.text,
                      style: TextStyle(
                        fontSize: 13,
                        height: 1.5,
                        color: isHover ? const Color(0xFFE8E8E8) : const Color(0xFFB0A0D0),
                      ),
                    ),
                  ],
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
// CONTACT
// ======================================================

class _ContactSection extends StatelessWidget {
  final VoidCallback onContact;

  const _ContactSection({required this.onContact});

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
            'Есть идея\nдля приложения?',
            style: TextStyle(
              fontSize: responsiveHeadingSize(context, desktop: 55),
              fontWeight: FontWeight.w500,
              color: Colors.white,
              height: 1.1,
            ),
          ),

          const SizedBox(height: 35),

          const Text(
            'Расскажите нам о проекте, а мы поможем '
            'превратить идею в готовое приложение.',
            style: TextStyle(color: const Color(0xFFE8E8E8), fontSize: 19, height: 1.6),
          ),

          const SizedBox(height: 40),

          ElevatedButton(
            onPressed: onContact,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4412A7),
              foregroundColor: Colors.white,
              minimumSize: const Size(210, 55),
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


