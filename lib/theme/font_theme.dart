import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final fontTheme = TextTheme(
  // Headlines
  headlineLarge: GoogleFonts.poppins(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.5,
  ),
  headlineMedium: GoogleFonts.poppins(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.25,
  ),
  headlineSmall: GoogleFonts.poppins(
    fontSize: 24,
    fontWeight: FontWeight.w600,
  ),

  // Titles
  titleLarge: GoogleFonts.poppins(
    fontSize: 20,
    fontWeight: FontWeight.w500,
  ),
  titleMedium: GoogleFonts.poppins(
    fontSize: 18,
    fontWeight: FontWeight.w500,
  ),
  titleSmall: GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w500,
  ),

  // Body text
  bodyLarge: GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w400,
  ),
  bodyMedium: GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w400,
  ),
  bodySmall: GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.w400,
  ),

  // Labels
  labelLarge: GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w600,
  ),
  labelMedium: GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w500,
  ),
  labelSmall: GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: Colors.grey,
  ),
);
