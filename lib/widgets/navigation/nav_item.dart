import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../models/marvel_section.dart';

class NavItem extends StatefulWidget {
  final MarvelSection section;
  final bool isSelected;
  final VoidCallback onTap;

  const NavItem({
    required this.section,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<NavItem> with SingleTickerProviderStateMixin {
  bool isHovered = false;
  late AnimationController _controller;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);

    _glowAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedBuilder(
        animation: _glowAnimation,
        builder: (context, child) {
          return GestureDetector(
            onTap: widget.onTap,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: (isHovered || widget.isSelected)
                    ? LinearGradient(
                        colors: [
                          AppColors.marvelRed
                              .withOpacity(0.2 * _glowAnimation.value),
                          AppColors.marvelGold
                              .withOpacity(0.2 * _glowAnimation.value),
                        ],
                      )
                    : null,
              ),
              child: Text(
                getSectionName(widget.section),
                style: TextStyle(
                  color: widget.isSelected || isHovered
                      ? Colors.white
                      : Colors.white70,
                  fontWeight:
                      widget.isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
