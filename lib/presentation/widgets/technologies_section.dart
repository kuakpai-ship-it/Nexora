import 'package:flutter/material.dart';
import 'package:nexora/presentation/widgets/segment_info.dart';

class TechnologiesSection extends StatelessWidget {
  const TechnologiesSection({super.key});

  static const List<Map<String, String>> technologies = [
    {'name': 'Flutter',    'type': 'Framework', 'image': 'assets/images/image.png'},
    {'name': 'Dart',       'type': 'Language',  'image': 'assets/images/dart.png'},
    {'name': 'Python',     'type': 'Language',  'image': 'assets/images/pythonphoto.png'},
    {'name': 'JavaScript', 'type': 'Language',  'image': 'assets/images/javascript.png'},
    {'name': 'React JS',   'type': 'Framework', 'image': 'assets/images/reactlogo.png'},
    {'name': 'HTML5',      'type': 'Technology','image': 'assets/images/html5logo.png'},
    {'name': 'CSS',        'type': 'Technology','image': 'assets/images/csslogo.png'},
    {'name': 'Firebase',   'type': 'Backend',   'image': 'assets/images/firebaselogo.png'},
    {'name': 'PostgreSQL', 'type': 'Database',  'image': 'assets/images/postgresqllogo.png'},
    {'name': 'GitHub',     'type': 'Tools',     'image': 'assets/images/githublogo.png'},
    {'name': 'Figma',      'type': 'Design',    'image': 'assets/images/figmalogo.png'},
    {'name': 'Unity',      'type': 'Game Engine','image': 'assets/images/unitylogo.png'},
  ];

  @override
  Widget build(BuildContext context) {
    final compact = MediaQuery.sizeOf(context).width < 600;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: compact ? 16 : 60,
        vertical: compact ? 40 : 80,
      ),
      color: Colors.transparent,
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFF4412A7)),
        ),
        child: Stack(
          children: [
            // Фоновая картинка
            Positioned.fill(
              child: Image.asset(
                'assets/images/languege3.png',
                fit: BoxFit.cover,
                filterQuality: FilterQuality.high,
              ),
            ),
            // Тёмный оверлей
            Positioned.fill(
              child: ColoredBox(
                color: const Color(0xFF0D0520).withValues(alpha: 0.55),
              ),
            ),
            // Контент
            Padding(
              padding: EdgeInsets.all(compact ? 20 : 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Языки и\nтехнологии',
                    style: TextStyle(
                      fontSize: 52,
                      fontWeight: FontWeight.w500,
                      height: 1.1,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 25),
                  const Text(
                    'Используем современные языки программирования, '
                    'фреймворки и инструменты для создания '
                    'быстрых и удобных цифровых продуктов.',
                    style: TextStyle(
                      fontSize: 17,
                      height: 1.6,
                      color: Color(0xFFE8E8E8),
                    ),
                  ),
                  const SizedBox(height: 60),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      int columns = 4;
                      if (constraints.maxWidth < 900) columns = 2;
                      if (constraints.maxWidth < 500) columns = 1;
                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: technologies.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: columns,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 15,
                          childAspectRatio: 2.2,
                        ),
                        itemBuilder: (context, index) {
                          return _TechCard(
                            name: technologies[index]['name']!,
                            type: technologies[index]['type']!,
                            image: technologies[index]['image']!,
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

class _TechCard extends StatefulWidget {
  final String name;
  final String type;
  final String image;

  const _TechCard({
    required this.name,
    required this.type,
    required this.image,
  });

  @override
  State<_TechCard> createState() => _TechCardState();
}

class _TechCardState extends State<_TechCard> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => isHover = true),
      onExit: (_) => setState(() => isHover = false),
      child: InkWell(
        onTap: () => showSegmentInfo(context, widget.name),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          transform: Matrix4.translationValues(0, isHover ? -4 : 0, 0),
          decoration: BoxDecoration(
            border: Border.all(
              color: isHover ? const Color(0xFF7C3AED) : const Color(0xFF2D1B69),
            ),
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                widget.image,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const ColoredBox(
                  color: Color(0xFF1A0A2E),
                  child: Center(
                    child: Icon(Icons.code, color: Color(0xFF4412A7), size: 30),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  color: Colors.black.withValues(alpha: 0.55),
                  child: Text(
                    widget.type,
                    style: const TextStyle(fontSize: 12, color: Colors.white70),
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
