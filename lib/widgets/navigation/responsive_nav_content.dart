import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../constants/breakpoints.dart';
import '../../models/marvel_section.dart';
import 'nav_item.dart';
import 'mobile_menu.dart';

class ResponsiveNavContent extends StatelessWidget {
  final MarvelSection currentSection;
  final Function(MarvelSection) onSectionChanged;

  const ResponsiveNavContent({
    required this.currentSection,
    required this.onSectionChanged,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isCompact = screenWidth < ResponsiveBreakpoints.tablet;

    return Row(
      children: [
        _buildLogo(),
        if (!isCompact) ...[
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: MarvelSection.values.map((section) {
                return NavItem(
                  section: section,
                  isSelected: section == currentSection,
                  onTap: () => onSectionChanged(section),
                );
              }).toList(),
            ),
          ),
          _buildJoinButton(),
        ] else
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(Icons.menu, color: Colors.white),
                  onPressed: () => _showMobileMenu(context),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildLogo() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.marvelRed, AppColors.marvelBlue],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.marvelRed.withOpacity(0.5),
                  blurRadius: 12,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Icon(Icons.code, color: Colors.white),
          ),
          SizedBox(width: 12),
          ShaderMask(
            shaderCallback: (bounds) => LinearGradient(
              colors: [AppColors.marvelRed, AppColors.marvelBlue],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ).createShader(bounds),
            child: Text(
              'HACK HUNT',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildJoinButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.marvelRed,
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
        child: Text(
          'JOIN NOW',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  void _showMobileMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => MobileMenu(
        currentSection: currentSection,
        onSectionChanged: (section) {
          Navigator.pop(context);
          onSectionChanged(section);
        },
      ),
    );
  }
}
