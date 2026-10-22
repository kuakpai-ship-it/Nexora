import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:nexora/firebase_options.dart';
import 'package:nexora/presentation/pages/home_page.dart';
import 'package:nexora/presentation/pages/about_page.dart';
import 'package:nexora/presentation/mobile_screen_folders/screens/game_development_page.dart';
import 'package:nexora/presentation/mobile_screen_folders/screens/machine_learning.dart';
import 'package:nexora/presentation/mobile_screen_folders/screens/mobile_development_page.dart';
import 'package:nexora/presentation/mobile_screen_folders/screens/admin_login_page.dart';
import 'package:nexora/presentation/widgets/site_video_background.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      builder: (context, child) => SiteVideoBackground(child: child),
      routes: {
        '/about': (_) => const AboutPage(),
        '/admin': (_) => const AdminLoginPage(),
        '/web-mobile': (_) => const MobileDevelopmentPage(),
        '/games': (_) => const GameDevelopmentPage(),
        '/machine-learning': (_) => const MachineLearningPage(),
      },
    );
  }
}


