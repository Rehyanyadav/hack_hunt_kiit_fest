import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:math' as math;
import 'dart:ui';
import '../constants/colors.dart';
import 'screens/splash_screen.dart';

// Update the theme colors to Spider-Man colors
final spideyRed = Color(0xFFE23636);
final spideyBlue = Color(0xFF0D47A1);
final spideyWebColor = Colors.white.withOpacity(0.1);

// Add these constants at the top
final marvelRed = Color(0xFFE23636);
final marvelBlue = Color(0xFF0D47A1);
final marvelGold = Color(0xFFFFD700);
final marvelDark = Color(0xFF1A1A1A);

// Add this enum for navigation
enum MarvelSection {
  home,
  heroes,
  villains,
  universe,
  events,
}

// Add this ResponsiveBreakpoints class at the top
class ResponsiveBreakpoints {
  static const double mobile = 600;
  static const double tablet = 900;
  static const double desktop = 1200;
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hack Hunt 2024',
      theme: ThemeData(
        colorScheme: ColorScheme.dark(
          primary: AppColors.marvelRed,
          secondary: AppColors.marvelBlue,
          background: Colors.black,
        ),
        useMaterial3: true,
      ),
      home: SplashScreen(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  MarvelSection _currentSection = MarvelSection.home;
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: marvelDark,
      body: Stack(
        children: [
          _buildMarvelBackground(),
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverAppBar(
                floating: true,
                pinned: true,
                backgroundColor: Colors.transparent,
                expandedHeight: 70,
                flexibleSpace: MarvelNavBar(
                  currentSection: _currentSection,
                  onSectionChanged: (section) {
                    setState(() => _currentSection = section);
                    // Add scroll to section logic here
                  },
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: ResponsiveLayout(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Welcome Container
                        Container(
                          padding: EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: LinearGradient(
                              colors: [
                                spideyRed.withOpacity(0.9),
                                spideyBlue.withOpacity(0.9)
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: Column(
                            children: [
                              Text(
                                'Welcome to Hack Hunt 2024!',
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium
                                    ?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                          MediaQuery.of(context).size.width <
                                                  ResponsiveBreakpoints.mobile
                                              ? 24
                                              : 32,
                                    ),
                              ),
                              SizedBox(height: 16.0),
                              Text(
                                'Join us for an epic 24-hour hackathon filled with innovation, coding, and amazing prizes.',
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                      color: Colors.white,
                                      fontSize:
                                          MediaQuery.of(context).size.width <
                                                  ResponsiveBreakpoints.mobile
                                              ? 14
                                              : 16,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 16.0),
                        // Team Section
                        ResponsiveGrid(
                          title: 'Our Team',
                          children: [
                            TeamMemberCard(
                              name: 'Alex Johnson',
                              role: 'Lead Organizer',
                              imageUrl: 'https://i.pravatar.cc/150?img=1',
                              socialLinks: {
                                'github': 'alexj',
                                'linkedin': 'alex-johnson',
                                'twitter': '@alexj',
                              },
                            ),
                            TeamMemberCard(
                              name: 'Sarah Chen',
                              role: 'Technical Lead',
                              imageUrl: 'https://i.pravatar.cc/150?img=2',
                              socialLinks: {
                                'github': 'sarahc',
                                'linkedin': 'sarah-chen',
                                'twitter': '@sarahc',
                              },
                            ),
                            TeamMemberCard(
                              name: 'Mike Peters',
                              role: 'Event Coordinator',
                              imageUrl: 'https://i.pravatar.cc/150?img=3',
                              socialLinks: {
                                'github': 'mikep',
                                'linkedin': 'mike-peters',
                                'twitter': '@mikep',
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 16.0),
                        // Event Schedule Section
                        ResponsiveGrid(
                          title: 'Event Schedule',
                          children: [
                            EventCard(
                              title: 'Opening Ceremony',
                              time: '9:00 AM',
                              location: 'Main Hall',
                              icon: Icons.celebration,
                            ),
                            EventCard(
                              title: 'Hacking Begins',
                              time: '10:00 AM',
                              location: 'Hacking Arena',
                              icon: Icons.code,
                            ),
                            EventCard(
                              title: 'Project Showcase',
                              time: '8:00 AM (Next Day)',
                              location: 'Exhibition Area',
                              icon: Icons.rocket_launch,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: ResponsiveFloatingActionButton(),
    );
  }

  Widget _buildMarvelBackground() {
    return ShaderMask(
      shaderCallback: (bounds) => LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          marvelDark.withOpacity(0.9),
          marvelDark.withOpacity(1),
        ],
      ).createShader(bounds),
      child: Image.network(
        'https://images.unsplash.com/photo-1635805737707-575885ab0820',
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
      ),
    );
  }
}

// Add this new animated background widget
class SpiderWebBackground extends StatefulWidget {
  @override
  State<SpiderWebBackground> createState() => _SpiderWebBackgroundState();
}

class _SpiderWebBackgroundState extends State<SpiderWebBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 10),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: SpiderWebPainter(_controller.value),
          child: Container(),
        );
      },
    );
  }
}

// Custom painter for the web effect
class SpiderWebPainter extends CustomPainter {
  final double animation;

  SpiderWebPainter(this.animation);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = spideyWebColor
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2;

    for (var i = 0; i < 8; i++) {
      final angle = (i / 8) * 2 * math.pi + animation * 2 * math.pi;
      final x = center.dx + radius * math.cos(angle);
      final y = center.dy + radius * math.sin(angle);
      canvas.drawLine(center, Offset(x, y), paint);
    }

    for (var i = 1; i <= 5; i++) {
      canvas.drawCircle(
        center,
        radius * (i / 5) * (1 + math.sin(animation * 2 * math.pi) * 0.1),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(SpiderWebPainter oldDelegate) => true;
}

// Update the ParallaxBackground with a gradient overlay
class ParallaxBackground extends StatelessWidget {
  final String imageUrl;

  const ParallaxBackground({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final height = _getResponsiveHeight(screenWidth);

    return Stack(
      children: [
        SizedBox(
          height: height,
          width: double.infinity,
          child: Flow(
            delegate: ParallaxFlowDelegate(context),
            children: [
              ShaderMask(
                shaderCallback: (bounds) => LinearGradient(
                  colors: [
                    spideyRed.withOpacity(0.7),
                    spideyBlue.withOpacity(0.7),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ).createShader(bounds),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: height,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                        valueColor: AlwaysStoppedAnimation<Color>(spideyRed),
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: spideyBlue.withOpacity(0.1),
                    child: Icon(Icons.error_outline, color: spideyRed),
                  ),
                ),
              ),
            ],
          ),
        ),
        SpiderWebBackground(),
      ],
    );
  }

  double _getResponsiveHeight(double screenWidth) {
    if (screenWidth < ResponsiveBreakpoints.mobile) {
      return 200;
    } else if (screenWidth < ResponsiveBreakpoints.tablet) {
      return 250;
    } else if (screenWidth < ResponsiveBreakpoints.desktop) {
      return 300;
    }
    return 350;
  }
}

// Add this hover animation mixin
mixin HoverAnimationMixin<T extends StatefulWidget> on State<T> {
  bool isHovered = false;

  Widget addHoverEffect(Widget child) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedScale(
        scale: isHovered ? 1.05 : 1.0,
        duration: Duration(milliseconds: 200),
        child: child,
      ),
    );
  }
}

// Update TeamMemberCard to include hover animations
class TeamMemberCard extends StatefulWidget {
  final String name;
  final String role;
  final String imageUrl;
  final Map<String, String> socialLinks;

  const TeamMemberCard({
    required this.name,
    required this.role,
    required this.imageUrl,
    required this.socialLinks,
  });

  @override
  State<TeamMemberCard> createState() => _TeamMemberCardState();
}

class _TeamMemberCardState extends State<TeamMemberCard>
    with HoverAnimationMixin {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isCompact = screenWidth < ResponsiveBreakpoints.mobile;

    return addHoverEffect(
      Card(
        margin: EdgeInsets.symmetric(
          vertical: isCompact ? 4 : 8,
          horizontal: isCompact ? 0 : 8,
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                spideyRed.withOpacity(0.1),
                spideyBlue.withOpacity(0.1),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isHovered ? spideyRed : Colors.transparent,
              width: 2,
            ),
          ),
          child: ListTile(
            contentPadding: EdgeInsets.all(isCompact ? 8 : 16),
            leading: CircleAvatar(
              radius: isCompact ? 24 : 30,
              backgroundImage: NetworkImage(widget.imageUrl),
            ),
            title: Text(
              widget.name,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontSize: isCompact ? 16 : 20,
                  ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.role),
                SizedBox(height: 8),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.code, size: 20),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(Icons.work, size: 20),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(Icons.flutter_dash, size: 20),
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Update EventCard with similar hover effects
class EventCard extends StatefulWidget {
  final String title;
  final String time;
  final String location;
  final IconData icon;

  const EventCard({
    required this.title,
    required this.time,
    required this.location,
    required this.icon,
  });

  @override
  State<EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> with HoverAnimationMixin {
  @override
  Widget build(BuildContext context) {
    return addHoverEffect(
      Card(
        margin: EdgeInsets.symmetric(vertical: 8),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                spideyRed.withOpacity(0.1),
                spideyBlue.withOpacity(0.1),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isHovered ? spideyBlue : Colors.transparent,
              width: 2,
            ),
          ),
          child: ListTile(
            leading: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.purple.shade200, Colors.blue.shade200],
                ),
                shape: BoxShape.circle,
              ),
              child: Icon(widget.icon, size: 32, color: Colors.white),
            ),
            title: Text(widget.title,
                style: Theme.of(context).textTheme.titleLarge),
            subtitle: Text('${widget.time} • ${widget.location}'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Add event details navigation
            },
          ),
        ),
      ),
    );
  }
}

class ParallaxFlowDelegate extends FlowDelegate {
  final BuildContext buildContext;

  ParallaxFlowDelegate(this.buildContext);

  @override
  void paintChildren(FlowPaintingContext context) {
    // Get the scroll position
    final scrollable = Scrollable.of(buildContext);
    final scrollPosition = scrollable?.position.pixels ?? 0.0;

    // Calculate the parallax offset (reduced the effect for smoother scrolling)
    final parallaxOffset = scrollPosition * 0.3;

    // Paint the child (image) with the parallax effect
    context.paintChild(
      0,
      transform: Matrix4.translationValues(0.0, parallaxOffset, 0.0),
    );
  }

  @override
  bool shouldRepaint(ParallaxFlowDelegate oldDelegate) =>
      true; // Changed to true to update on scroll
}

// Add these new responsive widgets
class ResponsiveLayout extends StatelessWidget {
  final Widget child;

  const ResponsiveLayout({required this.child});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= ResponsiveBreakpoints.desktop) {
          return Center(
            child: SizedBox(
              width: ResponsiveBreakpoints.desktop,
              child: child,
            ),
          );
        }
        return child;
      },
    );
  }
}

class ResponsiveGrid extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const ResponsiveGrid({
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final crossAxisCount = screenWidth < ResponsiveBreakpoints.mobile
        ? 1
        : screenWidth < ResponsiveBreakpoints.tablet
            ? 2
            : 3;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontSize: screenWidth < ResponsiveBreakpoints.mobile ? 20 : 24,
              ),
        ),
        SizedBox(height: 16),
        screenWidth < ResponsiveBreakpoints.mobile
            ? Column(children: children)
            : GridView.count(
                crossAxisCount: crossAxisCount,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 16 / 9,
                children: children,
              ),
      ],
    );
  }
}

class ResponsiveFloatingActionButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: LinearGradient(
          colors: [spideyRed, spideyBlue],
        ),
      ),
      child: FloatingActionButton.extended(
        backgroundColor: Colors.transparent,
        onPressed: () {
          // Add registration functionality
        },
        label: Text(
          'Register Now',
          style: TextStyle(
            fontSize: screenWidth < ResponsiveBreakpoints.mobile ? 14 : 16,
          ),
        ),
        icon: Icon(
          Icons.app_registration,
          size: screenWidth < ResponsiveBreakpoints.mobile ? 20 : 24,
        ),
      ),
    );
  }
}

// Add the MarvelNavBar widget
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
            color: marvelDark.withOpacity(0.8),
            border: Border(
              bottom: BorderSide(
                color: marvelRed.withOpacity(0.3),
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
                return _NavItem(
                  section: section,
                  isSelected: section == currentSection,
                  onTap: () => onSectionChanged(section),
                );
              }).toList(),
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: marvelRed,
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
                colors: [marvelRed, marvelBlue],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: marvelRed.withOpacity(0.5),
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
              colors: [marvelRed, marvelBlue],
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

class _NavItem extends StatefulWidget {
  final MarvelSection section;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavItem({
    required this.section,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem>
    with SingleTickerProviderStateMixin {
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
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: (isHovered || widget.isSelected)
                  ? LinearGradient(
                      colors: [
                        marvelRed.withOpacity(0.2 * _glowAnimation.value),
                        marvelGold.withOpacity(0.2 * _glowAnimation.value),
                      ],
                    )
                  : null,
            ),
            child: Text(
              _getSectionName(widget.section),
              style: TextStyle(
                color: widget.isSelected || isHovered
                    ? Colors.white
                    : Colors.white70,
                fontWeight:
                    widget.isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          );
        },
      ),
    );
  }
}

String _getSectionName(MarvelSection section) {
  switch (section) {
    case MarvelSection.home:
      return 'HOME';
    case MarvelSection.heroes:
      return 'HEROES';
    case MarvelSection.villains:
      return 'VILLAINS';
    case MarvelSection.universe:
      return 'UNIVERSE';
    case MarvelSection.events:
      return 'EVENTS';
  }
}

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
        color: marvelDark,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: MarvelSection.values.map((section) {
          return ListTile(
            selected: section == currentSection,
            selectedTileColor: marvelRed.withOpacity(0.1),
            leading: Icon(Icons.circle, color: marvelRed),
            title: Text(
              _getSectionName(section),
              style: TextStyle(color: Colors.white),
            ),
            onTap: () => onSectionChanged(section),
          );
        }).toList(),
      ),
    );
  }
}
