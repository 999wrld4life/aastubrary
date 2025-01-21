import 'package:day_1/consttants.dart';
import 'package:day_1/fonts/font.dart';
import 'package:flutter/material.dart';
import 'package:neopop/neopop.dart';

class OnBoardingButton extends StatelessWidget {
  final String text;
  final void Function()? onTapDown;

  const OnBoardingButton({super.key, required this.text, this.onTapDown});

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Padding(
        padding: const EdgeInsets.only(left: 15),
        child: NeoPopTiltedButton(
          isFloating: true,
          onTapUp: () {},
          onTapDown: onTapDown,
          decoration: const NeoPopTiltedButtonDecoration(
            color: Color.fromARGB(255, 114, 5, 41),
            plunkColor: Color.fromARGB(255, 114, 5, 41),
            shadowColor: Colors.grey,
            showShimmer: true,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 30.0,
              vertical: 8,
            ),
            child: Text(
              text,
              style: textStylePressStart(
                  color: Colors.white,
                  fontWeight: FontWeight.normal,
                  size: 10,
                  letterSpacing: 1.3),
            ),
          ),
        ),
      ),
    );
  }
}
