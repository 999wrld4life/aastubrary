import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle textStyleSlabo(
    double size, Color color, FontWeight fontWeight, double letterSpacing) {
  return GoogleFonts.slabo13px(
    fontSize: size,
    color: color,
    fontWeight: fontWeight,
    letterSpacing: letterSpacing,
  );
}
