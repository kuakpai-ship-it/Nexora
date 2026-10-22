// ignore_for_file: avoid_web_libraries_in_flutter
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nexora/presentation/widgets/contacts_widget.dart';
import 'package:nexora/presentation/widgets/scroll_reveal.dart';
import 'package:nexora/presentation/widgets/service_page_header.dart';
import 'package:nexora/presentation/widgets/services_section.dart';
import 'package:nexora/presentation/widgets/technologies_section.dart';
import 'package:video_player/video_player.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();

  void _showContacts(BuildContext context) {
    showDialog<void>(
      context: context,
      barrierColor: Colors.white,
      builder: (context) => const ContactsWidget(),
    );
  }

  void _handleKeyEvent(KeyEvent event) {
    if (event is! KeyDownEvent && event is! KeyRepeatEvent) return;
    final isRepeat = event is KeyRepeatEvent;
    final step = isRepeat
        ? MediaQuery.sizeOf(context).height * 0.05
        : MediaQuery.sizeOf(context).height * 0.8;
    final duration = isRepeat
        ? const Duration(milliseconds: 80)
        : const Duration(milliseconds: 400);
    final curve = isRepeat ? Curves.linear : Curves.easeInOut;
    if (event.logicalKey == LogicalKeyboardKey.arrowDown ||
        event.logicalKey == LogicalKeyboardKey.pageDown) {
      _scrollController.animateTo(
        _scrollController.offset + step,
        duration: duration,
        curve: curve,
      );
    } else if (event.logicalKey == LogicalKeyboardKey.arrowUp ||
        event.logicalKey == LogicalKeyboardKey.pageUp) {
      _scrollController.animateTo(
        _scrollController.offset - step,
        duration: duration,
        curve: curve,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardListener(
      focusNode: _focusNode,
      autofocus: true,
      onKeyEvent: _handleKeyEvent,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            const ServicePageHeader(),
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: [
                    ScrollReveal(
                      child: _HomeHero(
                        onContact: () => showDialog(
                          context: context,
                          barrierColor: Colors.black54,
                          builder: (_) => const OrderRequestWidget(),
                        ),
                      ),
                    ),
                    ServicesSection(
                      onWebMobileTap: () =>
                          Navigator.pushNamed(context, '/web-mobile'),
                      onGamesTap: () => Navigator.pushNamed(context, '/games'),
                      onMachineLearningTap: () =>
                          Navigator.pushNamed(context, '/machine-learning'),
                    ),
                    const ScrollReveal(child: TechnologiesSection()),
                    ScrollReveal(
                      child: _HomeContactSection(
                        onContact: () => _showContacts(context),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeHero extends StatelessWidget {
  const _HomeHero({required this.onContact});

  final VoidCallback onContact;

  @override
  Widget build(BuildContext context) {
    final compact = MediaQuery.sizeOf(context).width < 850;
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        minHeight: MediaQuery.sizeOf(context).height - 76,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: compact ? 24 : 70,
        vertical: compact ? 56 : 80,
      ),
      alignment: Alignment.centerLeft,
      child: compact
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _heroText(context, compact),
                const SizedBox(height: 48),
                const _PhoneIllustration(),
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(child: _heroText(context, compact)),
                const SizedBox(width: 50),
                const Expanded(child: _PhoneIllustration()),
              ],
            ),
    );
  }

  Widget _heroText(BuildContext context, bool compact) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Цифровые решения\nдля вашего бизнеса',
          style: TextStyle(
            fontSize: compact ? 38 : 54,
            fontWeight: FontWeight.w500,
            height: 1.12,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 28),
        const Text(
          'Разработка сайтов\n'
          'Разработка приложений\n'
          'Разработка игр',
          style: TextStyle(
            fontSize: 19,
            height: 1.8,
            color: const Color(0xFFE8E8E8),
          ),
        ),
        const SizedBox(height: 36),
        ElevatedButton(
          onPressed: onContact,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF4412A7),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 18,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          child: const Text('Заявка на услуги'),
        ),
      ],
    );
  }
}

class _PhoneIllustration extends StatefulWidget {
  const _PhoneIllustration();

  @override
  State<_PhoneIllustration> createState() => _PhoneIllustrationState();
}

class _PhoneIllustrationState extends State<_PhoneIllustration> {
  VideoPlayerController? _controller;
  bool _videoReady = false;

  bool get _isMobile => MediaQuery.sizeOf(context).width < 850;

  @override
  void initState() {
    super.initState();
    // Видео загружаем только на десктопе
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_isMobile) {
        _initVideo();
      }
    });
  }

  void _initVideo() {
    _controller = VideoPlayerController.networkUrl(
      Uri.parse(
        'https://res.cloudinary.com/yqbdknq8/video/upload/v1792509210/logo_light.webm',
      ),
    );
    _controller!.addListener(_onUpdate);
    _controller!.initialize().then((_) {
      if (mounted) {
        _controller!.setVolume(0);
        _controller!.play();
      }
    }).catchError((_) {});
  }

  void _onUpdate() {
    if (!mounted) return;
    if (!_videoReady && (_controller?.value.isInitialized ?? false)) {
      setState(() => _videoReady = true);
    }
  }

  @override
  void dispose() {
    _controller?.removeListener(_onUpdate);
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final isMobile = size.width < 850;
    final videoWidth = isMobile
        ? (size.width * 0.9).clamp(200.0, 400.0)
        : (size.width * 0.52).clamp(380.0, 700.0);
    final videoHeight = videoWidth * 0.82;

    // На мобиле — GIF
    if (isMobile) {
      return Center(
        child: Image.network(
          'https://res.cloudinary.com/yqbdknq8/image/upload/v1792644876/logogif.gif',
          width: videoWidth,
          height: videoHeight,
          fit: BoxFit.contain,
        ),
      );
    }

    // На десктопе — видео
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: SizedBox(
          width: videoWidth,
          height: videoHeight,
          child: _videoReady && _controller != null
              ? FittedBox(
                  fit: BoxFit.contain,
                  child: SizedBox(
                    width: _controller!.value.size.width,
                    height: _controller!.value.size.height,
                    child: VideoPlayer(_controller!),
                  ),
                )
              : const ColoredBox(color: Color(0xFF0D0618)),
        ),
      ),
    );
  }
}

class _HomeContactSection extends StatelessWidget {
  const _HomeContactSection({required this.onContact});

  final VoidCallback onContact;

  @override
  Widget build(BuildContext context) {
    final compact = MediaQuery.sizeOf(context).width < 600;
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 24,
        vertical: compact ? 64 : 100,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Готовы создать\nчто-то новое?',
            style: TextStyle(
              fontSize: compact ? 38 : 56,
              fontWeight: FontWeight.w500,
              height: 1.12,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Расскажите нам о вашей идее',
            style: TextStyle(fontSize: 19, color: const Color(0xFFE8E8E8)),
          ),
          const SizedBox(height: 28),
          ElevatedButton(
            onPressed: onContact,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4412A7),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 17),
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


