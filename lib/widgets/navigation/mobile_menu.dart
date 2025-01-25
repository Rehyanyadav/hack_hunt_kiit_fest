import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../models/marvel_section.dart';

class MobileMenu extends StatelessWidget {
  final MarvelSection currentSection;
  final Function(MarvelSection) onSectionChanged;

  const MobileMenu({
    required this.currentSection,
    required this.onSectionChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.marvelDark,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: MarvelSection.values.map((section) {
          return ListTile(
            selected: section == currentSection,
            selectedTileColor: AppColors.marvelRed.withOpacity(0.1),
            leading: Icon(Icons.circle, color: AppColors.marvelRed),
            title: Text(
              getSectionName(section),
              style: TextStyle(color: Colors.white),
            ),
            onTap: () => onSectionChanged(section),
          );
        }).toList(),
      ),
    );
  }
}
