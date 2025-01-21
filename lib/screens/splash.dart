import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:day_1/fonts/font.dart';
import 'package:day_1/screens/home_screen.dart';
import 'package:day_1/screens/main_screen.dart';
import 'package:day_1/screens/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    super.initState();
    _checkFirstLaunch();
  }

  Future<void> _checkFirstLaunch() async {
    final prefs = await SharedPreferences.getInstance();
    bool isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;

    Future.delayed(const Duration(seconds: 10), () {
      if (isFirstLaunch) {
        prefs.setBool('isFirstLaunch', false);

        Navigator.pushReplacement(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(builder: (context) => const OnboardingScreen()),
        );
      } else {
        Navigator.pushReplacement(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(builder: (context) => const MainScreen()),
        );
      }
    });
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.purple],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Lottie.asset('assets/Animation - 1730631313693.json'),
            DefaultTextStyle(
              style: textStylePressStart(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.1,
                size: 24,
              ),
              child: AnimatedTextKit(
                repeatForever: true,
                animatedTexts: [
                  WavyAnimatedText('AASTUBRARY',
                      speed: const Duration(seconds: 1)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
