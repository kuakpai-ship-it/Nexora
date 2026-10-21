import 'package:flutter/material.dart';
import 'package:nexora/presentation/mobile_screen_folders/screens/admin_login_page.dart';
import 'package:nexora/presentation/mobile_screen_folders/screens/machine_learning.dart';
import 'package:video_player/video_player.dart';
import 'package:nexora/data/consts/app_colors.dart';
import 'package:nexora/presentation/mobile_screen_folders/screens/game_development_page.dart';
import 'package:nexora/presentation/mobile_screen_folders/screens/mobile_development_page.dart';
import 'package:nexora/presentation/pages/about_page.dart';
import 'package:nexora/presentation/widgets/animated_menu.dart';
import 'package:nexora/presentation/widgets/contacts_widget.dart';
import 'package:nexora/presentation/widgets/services_section.dart';
import 'package:nexora/presentation/widgets/technologies_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late VideoPlayerController videoController;

  final Color purple = const Color(0xFF4412A7);

  @override
  void initState() {
    super.initState();

    videoController = VideoPlayerController.asset('assets/videos/main.mp4');

    videoController.initialize().then((_) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    videoController.dispose();
    super.dispose();
  }

  void _showContactDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return const ContactsWidget();
      },
    );
  }

  void _showOrderRequestDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return const OrderRequestWidget();
      },
    );
  }

  void _openMobilePage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MobileDevelopmentPage()),
    );
  }

  void _openGamePage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const GameDevelopmentPage()),
    );
  }

  void _openAboutPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AboutPage()),
    );
  }

  void _openMachineLearningPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MachineLearningPage()),
    );
  }

  void _openAdminPage() {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const AdminLoginPage(),
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          _buildHeader(),

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildHero(),
                  const ServicesSection(),
                  const TechnologiesSection(),
                  _buildAboutSection(),
                  _buildContactSection(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 75,
      padding: const EdgeInsets.symmetric(horizontal: 35),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xFFEAEAEA))),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 850) {
            return _buildMobileHeader();
          }

          return _buildDesktopHeader();
        },
      ),
    );
  }

  Widget _buildDesktopHeader() {
    return Row(
      children: [
        Text(
          'Nexora',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: purple,
          ),
        ),

        const Spacer(),

        AnimatedMenu(
          title: 'Услуги',
          items: const [
            'Web / Mobile разработка',
            'Разработка игр',
            'Машинное обучение',
          ],
          onPressed: [_openMobilePage, _openGamePage, _openMachineLearningPage],
        ),

        const SizedBox(width: 40),

        AnimatedMenu(
          title: 'О нас',
          items: const ['О нас'],
          onPressed: [_openAboutPage, () {}],
        ),

        const SizedBox(width: 40),

        GestureDetector(
          onTap: _openAdminPage,
          child: const Text('Админ', style: TextStyle(fontSize: 15)),
        ),

        const SizedBox(width: 25),

        ElevatedButton(
          onPressed: _showContactDialog,
          style: ElevatedButton.styleFrom(
            backgroundColor: purple,
            foregroundColor: Colors.white,
            minimumSize: const Size(190, 45),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          child: const Text('Свяжитесь с нами', style: TextStyle(fontSize: 14)),
        ),
      ],
    );
  }

  Widget _buildMobileHeader() {
    return Row(
      children: [
        Text(
          'Nexora',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: purple,
          ),
        ),

        const Spacer(),

        AnimatedMenu(
          title: 'Услуги',
          items: const ['Web / Mobile разработка', 'Разработка игр'],
          onPressed: [_openMobilePage, _openGamePage],
        ),

        const SizedBox(width: 20),

        AnimatedMenu(
          title: 'О нас',
          items: const ['О нас', 'Отзывы наших клиентов'],
          onPressed: [_openAboutPage, () {}],
        ),

        const SizedBox(width: 20),

        ElevatedButton(
          onPressed: _showContactDialog,
          style: ElevatedButton.styleFrom(
            backgroundColor: purple,
            foregroundColor: Colors.white,
            minimumSize: const Size(150, 42),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          child: const Text('Связаться', style: TextStyle(fontSize: 13)),
        ),
      ],
    );
  }

  Widget _buildHero() {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: 650),
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 70),
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 900) {
            return _buildMobileHero();
          }

          return _buildDesktopHero();
        },
      ),
    );
  }

  Widget _buildDesktopHero() {
    return Row(
      children: [
        Expanded(
          flex: 6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Цифровые решения\nдля вашего бизнеса',
                style: TextStyle(
                  fontSize: 58,
                  fontWeight: FontWeight.w500,
                  height: 1.08,
                ),
              ),

              const SizedBox(height: 30),

              const Text(
                'Разработка сайтов\n'
                'Разработка приложений\n'
                'Разработка игр',
                style: TextStyle(
                  fontSize: 18,
                  height: 1.7,
                  color: Colors.black54,
                ),
              ),

              const SizedBox(height: 40),

              ElevatedButton(
                onPressed: _showOrderRequestDialog,
                style: ElevatedButton.styleFrom(
                  backgroundColor: purple,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(190, 55),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: const Text('Заявка на услугу', style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),

        const SizedBox(width: 50),

        Expanded(flex: 5, child: _buildVideo()),
      ],
    );
  }

  Widget _buildMobileHero() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Цифровые решения\nдля вашего бизнеса',
          style: TextStyle(
            fontSize: 42,
            fontWeight: FontWeight.w500,
            height: 1.1,
          ),
        ),

        const SizedBox(height: 25),

        const Text(
          'Разработка сайтов\n'
          'Разработка приложений\n'
          'Разработка игр',
          style: TextStyle(fontSize: 17, height: 1.7, color: Colors.black54),
        ),

        const SizedBox(height: 30),

        ElevatedButton(
          onPressed: _showOrderRequestDialog,
          style: ElevatedButton.styleFrom(
            backgroundColor: purple,
            foregroundColor: Colors.white,
            minimumSize: const Size(180, 52),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          child: const Text('Заявка на услугу', style: TextStyle(fontSize: 16)),
        ),

        const SizedBox(height: 45),

        _buildVideo(),
      ],
    );
  }

  Widget _buildVideo() {
    return Container(
      width: double.infinity,
      height: 400,
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7F7),
        border: Border.all(color: const Color(0xFFE5E5E5)),
      ),
      child: videoController.value.isInitialized
          ? ClipRect(
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: videoController.value.size.width,
                  height: videoController.value.size.height,
                  child: VideoPlayer(videoController),
                ),
              ),
            )
          : Center(child: CircularProgressIndicator(color: purple)),
    );
  }

  Widget _buildAboutSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 100),
      color: const Color(0xFFF7F7F7),
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 800) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _sectionNumber('03'),

                const SizedBox(height: 20),

                const Text(
                  'О компании',
                  style: TextStyle(fontSize: 44, fontWeight: FontWeight.w500),
                ),

                const SizedBox(height: 30),

                _aboutText(),
              ],
            );
          }

          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: 100, child: _sectionNumber('03')),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'О компании',
                      style: TextStyle(
                        fontSize: 52,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    const SizedBox(height: 35),

                    _aboutText(),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _sectionNumber(String number) {
    return Text(
      number,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: purple,
      ),
    );
  }

  Widget _aboutText() {
    return const Text(
      'Nexora — команда разработчиков, которая создаёт '
      'современные цифровые продукты для бизнеса.\n\n'
      'Мы разрабатываем сайты, мобильные приложения '
      'и игры, уделяя внимание дизайну, удобству и качеству.',
      style: TextStyle(fontSize: 19, height: 1.7, color: Colors.black54),
    );
  }

  Widget _buildContactSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 100),
      child: Column(
        children: [
          const Text(
            'Готовы создать\nчто-то новое?',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 55,
              fontWeight: FontWeight.w500,
              height: 1.1,
            ),
          ),

          const SizedBox(height: 35),

          const Text(
            'Расскажите нам о вашей идее',
            style: TextStyle(fontSize: 18, color: Colors.black54),
          ),

          const SizedBox(height: 35),

          ElevatedButton(
            onPressed: _showContactDialog,
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
