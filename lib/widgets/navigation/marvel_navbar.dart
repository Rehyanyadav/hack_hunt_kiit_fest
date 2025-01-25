import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui';
import '../../constants/colors.dart';
import '../../models/marvel_section.dart';
import 'responsive_nav_content.dart';

class MarvelNavBar extends StatelessWidget {
  final MarvelSection currentSection;
  final Function(MarvelSection) onSectionChanged;

  const MarvelNavBar({
    required this.currentSection,
    required this.onSectionChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          height: 70,
          decoration: BoxDecoration(
            color: AppColors.marvelDark.withOpacity(0.8),
            border: Border(
              bottom: BorderSide(
                color: AppColors.marvelRed.withOpacity(0.3),
                width: 1,
              ),
            ),
          ),
          child: ResponsiveNavContent(
            currentSection: currentSection,
            onSectionChanged: onSectionChanged,
          ),
        ),
      ),
    );
  }
}
