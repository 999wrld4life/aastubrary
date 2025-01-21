import 'package:day_1/consttants.dart';
import 'package:day_1/fonts/expletus_sans.dart';
import 'package:day_1/fonts/font.dart';
import 'package:day_1/fonts/itim.dart';
import 'package:day_1/fonts/vt323.dart';
import 'package:flutter/material.dart';
import 'package:neopop/neopop.dart';

class MyNeopopButton extends StatelessWidget {
  final String text;
  final void Function()? onTapDown;

  const MyNeopopButton({super.key, required this.text, this.onTapDown});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.only(left: 15),
        child: NeoPopTiltedButton(
          isFloating: true,
          onTapUp: () {},
          onTapDown: onTapDown,
          decoration: const NeoPopTiltedButtonDecoration(
            color: kBlackColor,
            plunkColor: kBlackColor,
            shadowColor: Colors.grey,
            showShimmer: true,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 70.0,
              vertical: 15,
            ),
            child: Text(
              text,
              style: textStyleVt323(
                  color: Colors.white, size: 22, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
