import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:day_1/fonts/exo.dart';
import 'package:day_1/fonts/font.dart';
import 'package:day_1/fonts/itim.dart';
import 'package:day_1/fonts/vt323.dart';
import 'package:day_1/main.dart';
import 'package:day_1/widgets/neopop_button.dart';
import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../widgets/onboarding_btn.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final controller = LiquidController();
  final indicatorController = PageController();
  bool isLastPage = false;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        LiquidSwipe(
          onPageChangeCallback: (activePageIndex) {
            setState(() {
              isLastPage = activePageIndex == 2;
            });
          },
          liquidController: controller,
          enableLoop: false,
          enableSideReveal: true,
          slideIconWidget: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          pages: [
            pageOne(),
            pageTwo(),
            const WelcomeScreen(),
          ],
        ),
        Positioned(
          bottom: 7,
          left: 16,
          right: 32,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              OnBoardingButton(
                text: "SKIP",
                onTapDown: () {
                  controller.jumpToPage(page: 2);
                },
              ),
              AnimatedSmoothIndicator(
                activeIndex: controller.currentPage,
                count: 3,
                effect: const ExpandingDotsEffect(
                    dotColor: Colors.black,
                    activeDotColor: Colors.grey,
                    expansionFactor: 2),
                onDotClicked: (index) {
                  controller.animateToPage(page: index);
                },
              ),
              isLastPage
                  ? const SizedBox()
                  : OnBoardingButton(
                      text: "NEXT",
                      onTapDown: () {
                        final page = controller.currentPage + 1;

                        controller.animateToPage(
                          page: page > 2 ? 0 : page,
                          duration: 400,
                        );
                      },
                    ),
            ],
          ),
        )
      ],
    );
  }

  Scaffold pageTwo() {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
            colors: [Colors.black, Colors.pink],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Stack(
                children: [
                  Lottie.asset('assets/Animation - 1733684367982.json'),
                  Lottie.asset('assets/Animation - 1733684484268.json'),
                ],
              ),
              SizedBox(
                width: 300,
                child: DefaultTextStyle(
                  style: textStyleVt323(color: Colors.white, size: 25),
                  child: AnimatedTextKit(
                      repeatForever: false,
                      totalRepeatCount: 1,
                      animatedTexts: [
                        TypewriterAnimatedText(
                            speed: const Duration(milliseconds: 60),
                            'Unlock Limitless Learning with AASTUBRARY!'),
                        TypewriterAnimatedText(
                            speed: const Duration(milliseconds: 30),
                            '- A smarter way to access knowledge anytime, anywhere\n- Inspire your academic growth with curated resources\n- Your journey to success starts here—step in today!'),
                      ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Scaffold pageOne() {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [Colors.black, Colors.pink])),
        child: SafeArea(
          child: Column(
            children: [
              Stack(
                children: [
                  Lottie.asset('assets/Animation - 1733684484268.json'),
                  Lottie.asset('assets/Animation - 1730631313693.json'),
                ],
              ),
              SizedBox(
                width: 300,
                child: DefaultTextStyle(
                  style: textStyleVt323(color: Colors.white, size: 25),
                  child: AnimatedTextKit(
                      repeatForever: false,
                      totalRepeatCount: 1,
                      animatedTexts: [
                        TypewriterAnimatedText(
                          speed: const Duration(milliseconds: 100),
                          'Everything You Need! Tailored to Your Academic Journey!',
                        ),
                        TypewriterAnimatedText(
                          speed: const Duration(milliseconds: 30),
                          '- Discover a world of knowledge—browse a wide range of books at your fingertips\n- Read books seamlessly within the app and save your favorites for easy access\n- Quickly find what you’re looking for with our powerful search feature.',
                        ),
                      ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
