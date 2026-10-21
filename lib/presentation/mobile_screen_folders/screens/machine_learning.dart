import 'package:flutter/material.dart';
import 'package:nexora/presentation/widgets/contacts_widget.dart';
import 'package:nexora/presentation/widgets/keyboard_scrollable.dart';
import 'package:nexora/presentation/widgets/service_page_header.dart';
import 'package:nexora/presentation/widgets/responsive_layout.dart';
import 'package:nexora/presentation/widgets/scroll_reveal.dart';

class MachineLearningPage extends StatelessWidget {
  const MachineLearningPage({super.key});

  final Color purple = const Color(0xFF4412A7);

  void _showContactDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.black54,
      builder: (context) {
        return const OrderRequestWidget();
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
                    ScrollReveal(child: _buildHero(context)),
                    ScrollReveal(child: _buildServices(context)),
                    ScrollReveal(child: _buildProcess(context)),
                    ScrollReveal(child: _buildContact(context)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHero(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: responsiveSectionInsets(context, vertical: 100),
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 850) {
            return _buildMobileHero(context);
          }

          return _buildDesktopHero(context);
        },
      ),
    );
  }

  Widget _buildDesktopHero(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Машинное\nобучение',
                style: TextStyle(
                  fontSize: 64,
                  fontWeight: FontWeight.w500,
                  height: 1.05,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 30),

              const Text(
                'Умные решения для анализа данных,\n'
                'автоматизации процессов и развития бизнеса.',
                style: TextStyle(
                  fontSize: 19,
                  height: 1.7,
                  color: const Color(0xFFE8E8E8),
                ),
              ),

              const SizedBox(height: 40),

              ElevatedButton(
                onPressed: () => _showContactDialog(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: purple,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(210, 55),
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
            ],
          ),
        ),

        const SizedBox(width: 70),

        Expanded(
          flex: 4,
          child: Container(
            height: 420,
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(color: const Color(0xFFE5E5E5)),
            ),
            child: Center(
              child: Icon(Icons.auto_awesome, size: 150, color: purple),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileHero(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Машинное\nобучение',
          style: TextStyle(
            fontSize: responsiveHeadingSize(context, desktop: 45),
            fontWeight: FontWeight.w500,
            height: 1.05,
            color: Colors.white,
          ),
        ),

        const SizedBox(height: 25),

        const Text(
          'Умные решения для анализа данных,\n'
          'автоматизации процессов и развития бизнеса.',
          style: TextStyle(fontSize: 19, height: 1.7, color: const Color(0xFFE8E8E8)),
        ),

        const SizedBox(height: 30),

        ElevatedButton(
          onPressed: () => _showContactDialog(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: purple,
            foregroundColor: Colors.white,
            minimumSize: const Size(190, 52),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          child: const Text('Обсудить проект', style: TextStyle(fontSize: 16)),
        ),

        const SizedBox(height: 45),

        Container(
          width: double.infinity,
          height: 280,
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(color: const Color(0xFFE5E5E5)),
          ),
          child: Center(
            child: Icon(Icons.auto_awesome, size: 100, color: purple),
          ),
        ),
      ],
    );
  }

  Widget _buildServices(BuildContext context) {
    final items = [
      {'title': 'Анализ данных', 'text': 'Находим закономерности и полезную информацию в больших объёмах данных.'},
      {'title': 'AI-модели', 'text': 'Создаём модели машинного обучения под конкретные задачи бизнеса.'},
      {'title': 'Прогнозирование', 'text': 'Помогаем прогнозировать продажи, спрос и другие важные показатели.'},
    ];

    return Container(
      width: double.infinity,
      padding: responsiveSectionInsets(context, vertical: 100),
      color: Colors.transparent,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isDesktop = constraints.maxWidth >= 800;

          final header = Row(
            children: [
              Text(
                'Что мы делаем',
                style: TextStyle(
                  fontSize: responsiveHeadingSize(context, desktop: isDesktop ? 44 : 32),
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ],
          );

          // Единая картинка — обрезанная со всех сторон до краёв внутренних картинок
          final imageRow = ClipRect(
            child: Align(
              alignment: Alignment.center,
              heightFactor: 0.78,
              widthFactor: 0.96,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  'assets/images/ailogo.png',
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );

          // Подписи под картинкой — 3 колонки, ближе к картинке
          final labelsRow = isDesktop
              ? Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: items.map((item) => Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['title']!,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              item['text']!,
                              style: const TextStyle(
                                fontSize: 17,
                                height: 1.6,
                                color: const Color(0xFFE8E8E8),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )).toList(),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: items.map((item) => Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item['title']!,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            item['text']!,
                            style: const TextStyle(
                              fontSize: 14,
                              height: 1.6,
                              color: const Color(0xFFE8E8E8),
                            ),
                          ),
                        ],
                      ),
                    )).toList(),
                  ),
                );

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              header,
              const SizedBox(height: 40),
              imageRow,
              labelsRow,
            ],
          );
        },
      ),
    );
  }

  Widget _buildProcess(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: responsiveSectionInsets(context, vertical: 100),
      child: Column(
        children: [
          Text(
            'Как мы работаем',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: responsiveHeadingSize(context, desktop: 48),
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),

          const SizedBox(height: 60),

          Wrap(
            spacing: 25,
            runSpacing: 25,
            alignment: WrapAlignment.center,
            children: [
              _processCard(
                context,
                '01',
                'Задача',
                'Изучаем бизнес-задачу и определяем, где машинное обучение принесёт пользу.',
              ),

              _processCard(
                context,
                '02',
                'Данные',
                'Собираем, очищаем и подготавливаем данные для обучения модели.',
              ),

              _processCard(
                context,
                '03',
                'Модель',
                'Обучаем и тестируем модель, после чего внедряем её в проект.',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _processCard(
    BuildContext context,
    String number,
    String title,
    String text,
  ) {
    return Container(
      width: MediaQuery.sizeOf(context).width < 360
          ? MediaQuery.sizeOf(context).width - 56
          : 300,
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(color: const Color(0xFFE5E5E5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            number,
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: purple,
            ),
          ),

          const SizedBox(height: 25),

          Text(
            title,
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w500, color: Colors.white),
          ),

          const SizedBox(height: 15),

          Text(
            text,
            style: const TextStyle(
              fontSize: 17,
              height: 1.6,
              color: const Color(0xFFE8E8E8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContact(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: responsiveSectionInsets(context, vertical: 100),
      child: Column(
        children: [
          Text(
            'Есть идея\nдля AI-проекта?',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: responsiveHeadingSize(context, desktop: 55),
              fontWeight: FontWeight.w500,
              height: 1.1,
              color: Colors.white,
            ),
          ),

          const SizedBox(height: 30),

          const Text(
            'Расскажите нам о вашей задаче',
            style: TextStyle(fontSize: 18, color: const Color(0xFFE8E8E8)),
          ),

          const SizedBox(height: 35),

          ElevatedButton(
            onPressed: () => _showContactDialog(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: purple,
              foregroundColor: Colors.white,
              minimumSize: const Size(210, 58),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            child: const Text(
              'Связаться с нами',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}


