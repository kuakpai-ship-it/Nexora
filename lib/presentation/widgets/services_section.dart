import 'package:flutter/material.dart';
import 'package:nexora/presentation/widgets/scroll_reveal.dart';

class ServicesSection extends StatefulWidget {
  final VoidCallback onWebMobileTap;
  final VoidCallback onGamesTap;
  final VoidCallback onMachineLearningTap;

  const ServicesSection({
    super.key,
    required this.onWebMobileTap,
    required this.onGamesTap,
    required this.onMachineLearningTap,
  });

  @override
  State<ServicesSection> createState() => _ServicesSectionState();
}

class _ServicesSectionState extends State<ServicesSection> {
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
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFF4412A7), width: 1),
        ),
        clipBehavior: Clip.hardEdge,
        child: Stack(
          children: [
            // Картинка на весь фон секции
            Positioned.fill(
              child: Image.asset(
                'assets/images/It_project1.png',
                fit: BoxFit.cover,
                filterQuality: FilterQuality.high,
                alignment: Alignment.center,
              ),
            ),
            // Тёмный оверлей для читаемости текста
            Positioned.fill(
              child: ColoredBox(
                color: const Color(0xFF0D0520).withValues(alpha: 0.50),
              ),
            ),
            // Контент поверх
            Padding(
          padding: EdgeInsets.all(compact ? 20 : 50),
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Заголовок секции
            ScrollReveal(
              child: Text(
                'Какие услуги мы предоставляем?',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: compact ? 32 : 52,
                  fontWeight: FontWeight.w500,
                  height: 1.1,
                ),
              ),
            ),

            SizedBox(height: compact ? 36 : 52),

            if (compact) ...[
              ScrollReveal(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const _ProcessColumn(),
                    const SizedBox(height: 40),
                    _ServicesColumn(
                      onWebMobileTap: widget.onWebMobileTap,
                      onGamesTap: widget.onGamesTap,
                      onMachineLearningTap: widget.onMachineLearningTap,
                    ),
                  ],
                ),
              ),
            ] else
              ScrollReveal(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Expanded(child: _ProcessColumn()),
                    const SizedBox(width: 80),
                    Expanded(
                      child: _ServicesColumn(
                        onWebMobileTap: widget.onWebMobileTap,
                        onGamesTap: widget.onGamesTap,
                        onMachineLearningTap: widget.onMachineLearningTap,
                      ),
                    ),
                  ],
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
// ПРОЦЕСС
// ======================================================

class _ProcessColumn extends StatelessWidget {
  const _ProcessColumn();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Процесс',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500, color: Colors.white),
        ),

        SizedBox(height: 20),

        Text(
          'Мы обеспечиваем полный цикл цифрового '
          'производства — от анализа продукта до '
          'разработки и поддержки.',
          style: TextStyle(fontSize: 19, height: 1.6, color: Color(0xFFE8E8E8)),
        ),

        SizedBox(height: 35),

        _ProcessItem(number: '01', title: 'Аналитика'),

        _ProcessItem(number: '02', title: 'Разработка'),

        _ProcessItem(number: '03', title: 'Дизайн'),

        _ProcessItem(number: '04', title: 'Тестирование'),

        _ProcessItem(number: '05', title: 'Поддержка'),
      ],
    );
  }
}

// ======================================================
// УСЛУГИ
// ======================================================

class _ServicesColumn extends StatelessWidget {
  final VoidCallback onWebMobileTap;
  final VoidCallback onGamesTap;
  final VoidCallback onMachineLearningTap;

  const _ServicesColumn({
    required this.onWebMobileTap,
    required this.onGamesTap,
    required this.onMachineLearningTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Услуги',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500, color: Colors.white),
        ),

        const SizedBox(height: 20),

        const Text(
          'Создаём цифровые продукты и решения '
          'для развития современного бизнеса.',
          style: TextStyle(fontSize: 19, height: 1.6, color: Color(0xFFE8E8E8)),
        ),

        const SizedBox(height: 35),

        _ServiceItem(
          number: '01',
          title: 'Web и Mobile разработка',
          onTap: onWebMobileTap,
        ),
        _ServiceItem(number: '02', title: 'Разработка игр', onTap: onGamesTap),
        _ServiceItem(
          number: '03',
          title: 'Машинное обучение',
          onTap: onMachineLearningTap,
        ),
      ],
    );
  }
}

// ======================================================
// ПРОЦЕСС ITEM
// ======================================================

class _ProcessItem extends StatelessWidget {
  final String number;
  final String title;

  const _ProcessItem({required this.number, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 13),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0x33FFFFFF))),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 45,
            child: Text(
              number,
              style: const TextStyle(
                fontSize: 13,
                color: Color.fromARGB(255, 68, 18, 167),
              ),
            ),
          ),

          Text(title, style: const TextStyle(fontSize: 19, color: Colors.white)),
        ],
      ),
    );
  }
}

// ======================================================
// SERVICE ITEM
// ======================================================

class _ServiceItem extends StatefulWidget {
  final String number;
  final String title;
  final VoidCallback onTap;

  const _ServiceItem({
    required this.number,
    required this.title,
    required this.onTap,
  });

  @override
  State<_ServiceItem> createState() => _ServiceItemState();
}

class _ServiceItemState extends State<_ServiceItem> {
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
        behavior: HitTestBehavior.opaque,
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          transform: Matrix4.translationValues(isHover ? 10 : 0, 0, 0),
          padding: const EdgeInsets.symmetric(vertical: 13),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isHover
                    ? const Color.fromARGB(255, 68, 18, 167)
                    : const Color(0x33FFFFFF),
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
                    color: Color.fromARGB(255, 68, 18, 167),
                  ),
                ),
              ),

              Expanded(
                child: Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: isHover ? FontWeight.w500 : FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ),

              AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: isHover ? 1 : 0.55,
                child: const Icon(
                  Icons.arrow_forward,
                  color: Color.fromARGB(255, 68, 18, 167),
                  size: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


