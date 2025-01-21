import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle textStylePressStart({
  double? size,
  Color? color,
  FontWeight? fontWeight,
  double? letterSpacing,
}) {
  return GoogleFonts.pressStart2p(
      fontSize: size,
      color: color,
      fontWeight: fontWeight,
      letterSpacing: letterSpacing,
      shadows: [
        const Shadow(
          blurRadius: 7,
          offset: Offset(0, 0),
          color: Colors.white,
        ),
      ]);
}
