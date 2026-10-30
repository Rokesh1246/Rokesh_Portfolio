import 'dart:async';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../theme/app_theme.dart';
import '../../utils/url_helper.dart';
import '../../widgets/resume_modal.dart';

class HeroSection extends StatefulWidget {
  final VoidCallback? onViewProjects;
  final VoidCallback? onContactTap;

  const HeroSection({
    super.key,
    this.onViewProjects,
    this.onContactTap,
  });

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> {
  int _currentRoleIndex = 0;
  Timer? _roleTimer;

  final List<String> _roles = [
    'Flutter Developer',
    'Mobile App Architect (Android & iOS)',
    'Reactive State Expert (Provider & GetX)',
    'Payment & JWT Auth Specialist',
    '60 FPS Fluid UI Craftsman',
  ];

  @override
  void initState() {
    super.initState();
    _roleTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (mounted) {
        setState(() => _currentRoleIndex = (_currentRoleIndex + 1) % _roles.length);
      }
    });
  }

  @override
  void dispose() {
    _roleTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 850;
    final isSmallMobile = screenWidth < 400;

    return Container(
      constraints: const BoxConstraints(minHeight: 650),
      padding: EdgeInsets.fromLTRB(
        isMobile ? (isSmallMobile ? 16 : 24) : 80,
        isMobile ? 110 : 130,
        isMobile ? (isSmallMobile ? 16 : 24) : 80,
        isMobile ? 50 : 80,
      ),
      child: isMobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildProfileImage(isDark, true),
                const SizedBox(height: 36),
                _buildHeroContent(context, isDark, true, isSmallMobile),
                const SizedBox(height: 48),
                _buildHighlightsGrid(isDark, true),
              ],
            )
          : Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 6,
                      child: _buildHeroContent(context, isDark, false, false),
                    ),
                    const SizedBox(width: 48),
                    Expanded(
                      flex: 4,
                      child: _buildProfileImage(isDark, false),
                    ),
                  ],
                ),
                const SizedBox(height: 60),
                _buildHighlightsGrid(isDark, false),
              ],
            ),
    );
  }

  Widget _buildHeroContent(
    BuildContext context,
    bool isDark,
    bool isMobile,
    bool isSmallMobile,
  ) {
    return Column(
      crossAxisAlignment:
          isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        // Available for work pill
        FadeInDown(
          duration: const Duration(milliseconds: 600),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: isDark
                    ? AppTheme.accentCyan.withValues(alpha: 0.4)
                    : AppTheme.accentPurple.withValues(alpha: 0.4),
              ),
              color: isDark
                  ? AppTheme.accentCyan.withValues(alpha: 0.08)
                  : AppTheme.accentPurple.withValues(alpha: 0.08),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 9,
                  height: 9,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppTheme.accentGreen,
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.accentGreen.withValues(alpha: 0.6),
                        blurRadius: 8,
                        spreadRadius: 1,
                      )
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'Available for Immediate Opportunities',
                  style: TextStyle(
                    fontSize: isSmallMobile ? 11.5 : 13,
                    fontWeight: FontWeight.w700,
                    color: isDark ? AppTheme.accentCyan : AppTheme.accentPurple,
                    letterSpacing: 0.4,
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 20),

        // Salutation
        FadeInLeft(
          delay: const Duration(milliseconds: 150),
          child: Text(
            'Hello, I\'m',
            style: TextStyle(
              fontSize: isMobile ? 18 : 22,
              color: isDark ? AppTheme.textSecondary : AppTheme.lightTextSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),

        const SizedBox(height: 6),

        // Name with glowing gradient
        FadeInLeft(
          delay: const Duration(milliseconds: 250),
          child: ShaderMask(
            shaderCallback: (bounds) => LinearGradient(
              colors: isDark
                  ? [AppTheme.accentCyan, const Color(0xFF60A5FA), AppTheme.accentPurple]
                  : [AppTheme.accentPurple, const Color(0xFF2563EB), AppTheme.accentCyan],
            ).createShader(bounds),
            child: Text(
              'Rokesh Govindaraj',
              textAlign: isMobile ? TextAlign.center : TextAlign.start,
              style: TextStyle(
                fontSize: isMobile ? (isSmallMobile ? 36 : 46) : 62,
                fontWeight: FontWeight.w900,
                color: Colors.white,
                letterSpacing: -1.5,
                height: 1.1,
              ),
            ),
          ),
        ),

        const SizedBox(height: 12),

        // Cycling role title
        FadeInLeft(
          delay: const Duration(milliseconds: 350),
          child: Container(
            height: isMobile ? 36 : 42,
            alignment: isMobile ? Alignment.center : Alignment.centerLeft,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 400),
              transitionBuilder: (child, animation) => SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 0.4),
                  end: Offset.zero,
                ).animate(animation),
                child: FadeTransition(opacity: animation, child: child),
              ),
              child: Text(
                _roles[_currentRoleIndex],
                key: ValueKey(_currentRoleIndex),
                textAlign: isMobile ? TextAlign.center : TextAlign.start,
                style: TextStyle(
                  fontSize: isMobile ? (isSmallMobile ? 17 : 21) : 26,
                  fontWeight: FontWeight.w700,
                  color: isDark ? AppTheme.accentCyan : AppTheme.accentPurple,
                  letterSpacing: -0.3,
                ),
              ),
            ),
          ),
        ),

        const SizedBox(height: 16),

        // Professional Summary Teaser
        FadeInLeft(
          delay: const Duration(milliseconds: 450),
          child: Text(
            'Results-driven Flutter Developer with 2+ years of experience engineering high-performance cross-platform mobile apps for Android and iOS. Built 4 live production apps across AI collaboration, telemedicine, hyperlocal delivery, and recruitment.',
            textAlign: isMobile ? TextAlign.center : TextAlign.start,
            style: TextStyle(
              fontSize: isMobile ? 14 : 16,
              color: isDark ? AppTheme.textSecondary : AppTheme.lightTextSecondary,
              height: 1.65,
            ),
          ),
        ),

        const SizedBox(height: 32),

        // Primary Action Buttons
        FadeInUp(
          delay: const Duration(milliseconds: 550),
          child: Wrap(
            alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
            spacing: 12,
            runSpacing: 12,
            children: [
              // View Resume button (Modal)
              _buildGradientButton(
                label: 'View Resume',
                icon: Icons.description_rounded,
                isDark: isDark,
                onPressed: () => ResumeModal.show(context),
              ),

              // Download CV button
              _buildOutlinedButton(
                label: 'Download CV',
                icon: Icons.download_rounded,
                color: AppTheme.accentCyan,
                isDark: isDark,
                onPressed: () => UrlHelper.downloadResume(context),
              ),

              // View Projects button
              _buildOutlinedButton(
                label: 'View Projects',
                icon: Icons.rocket_launch_rounded,
                color: AppTheme.accentPurple,
                isDark: isDark,
                onPressed: widget.onViewProjects ?? () {},
              ),
            ],
          ),
        ),

        const SizedBox(height: 32),

        // Contact / Social Links strip
        FadeInUp(
          delay: const Duration(milliseconds: 650),
          child: Wrap(
            alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
            spacing: 12,
            runSpacing: 10,
            children: [
              _buildQuickContactIcon(
                icon: Icons.phone_in_talk_rounded,
                label: 'Call',
                color: AppTheme.accentGreen,
                isDark: isDark,
                onTap: () => UrlHelper.launchPhoneDialer(),
              ),
              _buildQuickContactIcon(
                icon: Icons.email_rounded,
                label: 'Email',
                color: AppTheme.accentCyan,
                isDark: isDark,
                onTap: () => UrlHelper.launchEmailClient(),
              ),
              _buildQuickContactIcon(
                icon: FontAwesomeIcons.whatsapp,
                label: 'WhatsApp',
                color: const Color(0xFF25D366),
                isDark: isDark,
                onTap: () => UrlHelper.launchWhatsAppChat(),
              ),
              _buildQuickContactIcon(
                icon: FontAwesomeIcons.linkedin,
                label: 'LinkedIn',
                color: const Color(0xFF0A66C2),
                isDark: isDark,
                onTap: () => UrlHelper.launchExternal(UrlHelper.linkedinUrl),
              ),
              _buildQuickContactIcon(
                icon: FontAwesomeIcons.github,
                label: 'GitHub',
                color: isDark ? Colors.white : Colors.black87,
                isDark: isDark,
                onTap: () => UrlHelper.launchExternal(UrlHelper.githubUrl),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProfileImage(bool isDark, bool isMobile) {
    final double avatarSize = isMobile ? 220 : 310;

    return FadeInRight(
      duration: const Duration(milliseconds: 800),
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Outer glowing blur halo
            Container(
              width: avatarSize + 40,
              height: avatarSize + 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    (isDark ? AppTheme.accentCyan : AppTheme.accentPurple)
                        .withValues(alpha: 0.28),
                    Colors.transparent,
                  ],
                ),
              ),
            ),

            // Rotating gradient border ring
            Container(
              width: avatarSize + 12,
              height: avatarSize + 12,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: SweepGradient(
                  colors: [
                    AppTheme.accentCyan,
                    AppTheme.accentPurple,
                    AppTheme.accentGreen,
                    AppTheme.accentCyan,
                  ],
                ),
              ),
              padding: const EdgeInsets.all(4),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isDark ? const Color(0xFF0A0E1A) : Colors.white,
                ),
              ),
            ),

            // Profile Picture
            ClipOval(
              child: Image.asset(
                'assets/images/profile.png',
                width: avatarSize,
                height: avatarSize,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: avatarSize,
                    height: avatarSize,
                    color: AppTheme.accentCyan.withValues(alpha: 0.2),
                    child: const Icon(Icons.person, size: 80, color: AppTheme.accentCyan),
                  );
                },
              ),
            ),

            // Floating Experience Badge
            Positioned(
              bottom: 12,
              right: isMobile ? 4 : 12,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF1E293B) : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppTheme.accentCyan.withValues(alpha: 0.4),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.35),
                      blurRadius: 15,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.verified_rounded,
                        color: AppTheme.accentCyan, size: 18),
                    const SizedBox(width: 6),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          '2+ YEARS',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w900,
                            color: AppTheme.accentCyan,
                            letterSpacing: 0.6,
                          ),
                        ),
                        Text(
                          'Flutter & Dart',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: isDark
                                ? AppTheme.textSecondary
                                : AppTheme.lightTextSecondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Top-left Floating Badge (60 FPS Native)
            Positioned(
              top: 14,
              left: isMobile ? 4 : 10,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF1E293B) : Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: AppTheme.accentGreen.withValues(alpha: 0.4),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.25),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.bolt_rounded,
                        color: AppTheme.accentGreen, size: 16),
                    SizedBox(width: 4),
                    Text(
                      '60 FPS UI',
                      style: TextStyle(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w800,
                        color: AppTheme.accentGreen,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHighlightsGrid(bool isDark, bool isMobile) {
    final highlights = [
      {
        'value': '4+',
        'label': 'Live Production Apps',
        'sub': 'Android & iOS Stores',
        'icon': Icons.apps_rounded,
        'color': AppTheme.accentCyan,
      },
      {
        'value': '2+',
        'label': 'Years Experience',
        'sub': 'Flutter & Dart SDK',
        'icon': Icons.trending_up_rounded,
        'color': AppTheme.accentPurple,
      },
      {
        'value': '60 FPS',
        'label': 'Fluid Widget Trees',
        'sub': 'DevTools Profiled',
        'icon': Icons.speed_rounded,
        'color': AppTheme.accentGreen,
      },
      {
        'value': '100%',
        'label': 'Payment & Auth',
        'sub': 'Cashfree, IAP & JWT',
        'icon': Icons.security_rounded,
        'color': AppTheme.accentOrange,
      },
    ];

    return FadeInUp(
      delay: const Duration(milliseconds: 700),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final crossAxisCount = constraints.maxWidth < 600
              ? 2
              : (constraints.maxWidth < 950 ? 2 : 4);

          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: highlights.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: constraints.maxWidth < 450 ? 1.6 : 2.1,
            ),
            itemBuilder: (context, index) {
              final h = highlights[index];
              final color = h['color'] as Color;

              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                decoration: BoxDecoration(
                  color: isDark ? AppTheme.cardDark : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: color.withValues(alpha: 0.25),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: color.withValues(alpha: 0.08),
                      blurRadius: 18,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(h['icon'] as IconData, color: color, size: 22),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            h['value'] as String,
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.w900,
                              color: isDark ? Colors.white : AppTheme.lightTextPrimary,
                              height: 1.1,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            h['label'] as String,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w700,
                              color: color,
                            ),
                          ),
                          Text(
                            h['sub'] as String,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 10,
                              color: isDark
                                  ? AppTheme.textSecondary
                                  : AppTheme.lightTextSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildGradientButton({
    required String label,
    required IconData icon,
    required bool isDark,
    required VoidCallback onPressed,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          colors: isDark
              ? [AppTheme.accentCyan, AppTheme.accentPurple]
              : [AppTheme.accentPurple, AppTheme.accentCyan],
        ),
        boxShadow: [
          BoxShadow(
            color: (isDark ? AppTheme.accentCyan : AppTheme.accentPurple)
                .withValues(alpha: 0.35),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 13),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, color: Colors.white, size: 18),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                    letterSpacing: 0.3,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOutlinedButton({
    required String label,
    required IconData icon,
    required Color color,
    required bool isDark,
    required VoidCallback onPressed,
  }) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: isDark ? Colors.white : AppTheme.lightTextPrimary,
        side: BorderSide(color: color.withValues(alpha: 0.45), width: 1.4),
        backgroundColor: color.withValues(alpha: 0.08),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      icon: Icon(icon, color: color, size: 18),
      label: Text(
        label,
        style: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 14,
          letterSpacing: 0.2,
        ),
      ),
    );
  }

  Widget _buildQuickContactIcon({
    required IconData icon,
    required String label,
    required Color color,
    required bool isDark,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isDark
              ? Colors.white.withValues(alpha: 0.05)
              : Colors.black.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 14, color: color),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: isDark ? Colors.white : AppTheme.lightTextPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
