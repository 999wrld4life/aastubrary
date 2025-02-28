import 'package:day_1/consttants.dart';
import 'package:flutter/material.dart';

class TwoSideRoundedButton extends StatelessWidget {
  final String? text;
  final double radious;
  final Function()? press;
  const TwoSideRoundedButton({
    super.key,
    this.text,
    this.radious = 29,
    this.press,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: kBlackColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(radious),
            bottomRight: Radius.circular(radious),
          ),
        ),
        child: Text(
          text!,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
