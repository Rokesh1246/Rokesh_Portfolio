import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../theme/app_theme.dart';
import '../utils/url_helper.dart';
import '../widgets/navbar.dart';
import '../widgets/resume_modal.dart';
import 'sections/hero_section.dart';
import 'sections/about_section.dart';
import 'sections/skills_section.dart';
import 'sections/projects_section.dart';
import 'sections/experience_section.dart';
import 'sections/education_section.dart';
import 'sections/certifications_section.dart';
import 'sections/contact_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  final List<GlobalKey> _sectionKeys = List.generate(8, (_) => GlobalKey());
  int _activeSection = 0;
  double _scrollProgress = 0.0;
  bool _showFloatingActions = false;

  final List<String> _navItems = [
    'Home',
    'About',
    'Skills',
    'Projects',
    'Experience',
    'Education',
    'Certifications',
    'Contact',
  ];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;

    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll > 0) {
      final progress = (currentScroll / maxScroll).clamp(0.0, 1.0);
      if ((progress - _scrollProgress).abs() > 0.01) {
        setState(() => _scrollProgress = progress);
      }
    }

    final shouldShowFab = currentScroll > 400;
    if (shouldShowFab != _showFloatingActions) {
      setState(() => _showFloatingActions = shouldShowFab);
    }

    for (int i = _sectionKeys.length - 1; i >= 0; i--) {
      final ctx = _sectionKeys[i].currentContext;
      if (ctx != null) {
        final box = ctx.findRenderObject() as RenderBox?;
        if (box != null && box.hasSize) {
          final pos = box.localToGlobal(Offset.zero);
          if (pos.dy <= 180) {
            if (_activeSection != i) {
              setState(() => _activeSection = i);
            }
            break;
          }
        }
      }
    }
  }

  void scrollToSection(int index) {
    if (index >= 0 && index < _sectionKeys.length) {
      final ctx = _sectionKeys[index].currentContext;
      if (ctx != null) {
        Scrollable.ensureVisible(
          ctx,
          duration: const Duration(milliseconds: 650),
          curve: Curves.easeInOutCubic,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    return Scaffold(
      body: Stack(
        children: [
          // Ambient Dynamic Background Gradient
          AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            decoration: BoxDecoration(
              gradient: isDark
                  ? const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFF070B14),
                        Color(0xFF0D172A),
                        Color(0xFF070B14),
                      ],
                    )
                  : const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFFF1F5F9),
                        Color(0xFFF8FAFC),
                        Color(0xFFEFF6FF),
                      ],
                    ),
            ),
          ),

          // Main Scrollable Body
          SingleChildScrollView(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(
                  key: _sectionKeys[0],
                  child: HeroSection(
                    onViewProjects: () => scrollToSection(3),
                    onContactTap: () => scrollToSection(7),
                  ),
                ),
                SizedBox(
                  key: _sectionKeys[1],
                  child: const AboutSection(),
                ),
                SizedBox(
                  key: _sectionKeys[2],
                  child: const SkillsSection(),
                ),
                SizedBox(
                  key: _sectionKeys[3],
                  child: const ProjectsSection(),
                ),
                SizedBox(
                  key: _sectionKeys[4],
                  child: const ExperienceSection(),
                ),
                SizedBox(
                  key: _sectionKeys[5],
                  child: const EducationSection(),
                ),
                SizedBox(
                  key: _sectionKeys[6],
                  child: const CertificationsSection(),
                ),
                SizedBox(
                  key: _sectionKeys[7],
                  child: ContactSection(
                    onScrollToTop: () => scrollToSection(0),
                  ),
                ),
              ],
            ),
          ),

          // Fixed Top Navbar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                PortfolioNavbar(
                  navItems: _navItems,
                  activeIndex: _activeSection,
                  onNavTap: scrollToSection,
                ),
                // Top Scroll Progress Line
                Container(
                  height: 2.5,
                  width: double.infinity,
                  alignment: Alignment.centerLeft,
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.05)
                      : Colors.black.withValues(alpha: 0.04),
                  child: FractionallySizedBox(
                    widthFactor: _scrollProgress,
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppTheme.accentCyan,
                            AppTheme.accentPurple,
                            AppTheme.accentGreen,
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Floating Quick Actions Bar (Bottom Right)
          if (_showFloatingActions)
            Positioned(
              bottom: isMobile ? 18 : 28,
              right: isMobile ? 14 : 28,
              child: _buildFloatingQuickBar(isDark, isMobile),
            ),
        ],
      ),
    );
  }

  Widget _buildFloatingQuickBar(bool isDark, bool isMobile) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: isDark
            ? const Color(0xFF1E293B).withValues(alpha: 0.95)
            : Colors.white.withValues(alpha: 0.95),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: (isDark ? AppTheme.accentCyan : AppTheme.accentPurple)
              .withValues(alpha: 0.3),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // WhatsApp
          IconButton(
            icon: const Icon(FontAwesomeIcons.whatsapp, size: 17),
            color: const Color(0xFF25D366),
            tooltip: 'WhatsApp Quick Chat',
            onPressed: () => UrlHelper.launchWhatsAppChat(),
          ),
          // Call
          IconButton(
            icon: const Icon(Icons.call_rounded, size: 18),
            color: AppTheme.accentGreen,
            tooltip: 'Call Rokesh',
            onPressed: () => UrlHelper.launchPhoneDialer(),
          ),
          // Resume Modal
          IconButton(
            icon: const Icon(Icons.description_rounded, size: 18),
            color: AppTheme.accentCyan,
            tooltip: 'View Resume',
            onPressed: () => ResumeModal.show(context),
          ),
          // Download CV
          IconButton(
            icon: const Icon(Icons.download_rounded, size: 18),
            color: AppTheme.accentPurple,
            tooltip: 'Download Resume PDF',
            onPressed: () => UrlHelper.downloadResume(context),
          ),
          // Scroll to top
          IconButton(
            icon: const Icon(Icons.arrow_upward_rounded, size: 18),
            color: isDark ? Colors.white70 : Colors.black87,
            tooltip: 'Back to Top',
            onPressed: () => scrollToSection(0),
          ),
        ],
      ),
    );
  }
}
