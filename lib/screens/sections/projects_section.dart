import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../theme/app_theme.dart';
import '../../utils/url_helper.dart';
import '../../widgets/project_details_modal.dart';
import '../../widgets/section_header.dart';

class ProjectsSection extends StatefulWidget {
  const ProjectsSection({super.key});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  String _selectedFilter = 'All';

  final List<String> _filters = [
    'All',
    'AI & Collaboration',
    'Healthcare',
    'Recruitment',
    'Logistics',
    'Business & CRM',
  ];

  final List<Map<String, dynamic>> _projects = [
    {
      'title': 'TOICE',
      'tagline': 'AI-Powered Task Collaboration App',
      'category': 'AI & Collaboration',
      'platform': 'Android & iOS',
      'color': AppTheme.accentCyan,
      'tags': ['Flutter', 'Socket.IO', 'Cashfree', 'Apple IAP', 'StoreKit'],
      'playStore': 'https://play.google.com/store/apps/details?id=com.doubletap.toice.ai&hl=en_IN',
      'appStore': 'https://apps.apple.com/in/app/toice-your-voice-tasks/id6770540894',
      'graphic': null,
      'featured': true,
      'bullets': [
        'Developed cross-platform mobile application featuring task creation, team collaboration, and an AI-powered Task PRD generator.',
        'Integrated REST APIs and Socket.IO for low-latency bidirectional real-time communication and asynchronous media uploads.',
        'Implemented secure JWT authentication with access and refresh tokens for protected API sessions and session lifecycle management.',
        'Implemented dual monetization via Apple In-App Purchases (StoreKit) for iOS subscriptions and Cashfree for Android.',
      ],
    },
    {
      'title': 'SAALUVARS',
      'tagline': 'Healthcare Patient Management Platform',
      'category': 'Healthcare',
      'platform': 'Android',
      'color': const Color(0xFF10B981),
      'tags': ['Flutter', 'Provider', 'REST APIs', 'Firebase', 'Cashfree', 'JWT Auth'],
      'playStore': 'https://play.google.com/store/apps/details?id=com.doubletap.saaluvars.patient&hl=en_IN',
      'appStore': null,
      'graphic': 'assets/projects/saaluvars_feature_graphic_1024x500.png',
      'icon': 'assets/projects/saaluvars_icon_512.png',
      'featured': true,
      'bullets': [
        'Developed healthcare features for patient registration, hospital discovery, doctor appointment booking, and medical report management.',
        'Integrated Google Maps API with live location tracking to discover nearby hospitals and book appointments seamlessly.',
        'Built an intelligent conversational AI healthcare chatbot interface to assist patients with appointment triage and symptom assessment.',
        'Implemented secure JWT authentication with access/refresh token auto-renewal via Dio, multi-account switching, and Cashfree payments.',
      ],
    },
    {
      'title': 'INTERNSHARKS',
      'tagline': 'Recruitment & Internship Discovery Network',
      'category': 'Recruitment',
      'platform': 'Android',
      'color': const Color(0xFF8B5CF6),
      'tags': ['Flutter', 'GetX', 'Dio', 'REST APIs', 'SharedPreferences'],
      'playStore': 'https://play.google.com/store/apps/details?id=com.doubletap.internsharks.ai&hl=en_IN',
      'appStore': null,
      'graphic': null,
      'featured': false,
      'bullets': [
        'Developed candidate and recruiter workflows connecting students with active corporate internships through structured opportunity listings.',
        'Built high-performance home feed and dashboard modules featuring real-time category filtering, vacancy search, and company profiles.',
        'Architected centralized state and reactive route navigation using GetX; implemented Dio networking with custom JWT interceptors.',
      ],
    },
    {
      'title': 'LE PONT',
      'tagline': 'Hyperlocal Delivery Application',
      'category': 'Logistics',
      'platform': 'Android',
      'color': const Color(0xFFF59E0B),
      'tags': ['Flutter', 'Dart', 'REST APIs', 'Google Maps API'],
      'playStore': 'https://play.google.com/store/apps/details?id=com.relietech.le_pont&hl=en_IN',
      'appStore': null,
      'graphic': null,
      'featured': false,
      'bullets': [
        'Developed on-demand pickup and delivery mobile application serving local logistics with real-time location selection.',
        'Integrated Google Maps API for pickup and delivery location selection, route preview, and location-related functionalities.',
        'Integrated application REST APIs, executed UI testing/debugging, and handled Android build deployment to the Google Play Store.',
      ],
    },
    {
      'title': 'RELIE ENQUIRY',
      'tagline': 'Business Inquiry & Lead Management CRM',
      'category': 'Business & CRM',
      'platform': 'Android',
      'color': const Color(0xFF3B82F6),
      'tags': ['Flutter', 'Dart', 'Firebase Auth', 'Firestore'],
      'playStore': 'https://play.google.com/store/apps/details?id=com.relietech.relie_enquiry&hl=en_IN',
      'appStore': null,
      'graphic': null,
      'featured': false,
      'bullets': [
        'Developed and successfully published a production Android business utility application on the Google Play Store.',
        'Architected a business inquiry management engine enabling small and medium enterprises to log, categorize, and prioritize customer leads.',
        'Implemented a proactive lead follow-up reminder system ensuring zero dropped leads, backed by Firebase Firestore real-time sync.',
      ],
    },
  ];

  List<Map<String, dynamic>> get _filteredProjects {
    if (_selectedFilter == 'All') return _projects;
    return _projects.where((p) => p['category'] == _selectedFilter).toList();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 900;
    final isSmallMobile = screenWidth < 400;

    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 1200),
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? (isSmallMobile ? 16 : 24) : 40,
          vertical: isMobile ? 28 : 40,
        ),
        child: Column(
          children: [
            SectionHeader(
              title: 'Key Production Projects',
              subtitle: 'Live cross-platform mobile apps deployed to App Stores',
              isDark: isDark,
            ),
            const SizedBox(height: 18),

            // Filter chips
            FadeInDown(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: _filters.map((filter) {
                    final isActive = _selectedFilter == filter;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: GestureDetector(
                        onTap: () => setState(() => _selectedFilter = filter),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 7),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            gradient: isActive
                                ? LinearGradient(
                                    colors: isDark
                                        ? [AppTheme.accentCyan, AppTheme.accentPurple]
                                        : [AppTheme.accentPurple, AppTheme.accentCyan],
                                  )
                                : null,
                            color: isActive
                                ? null
                                : (isDark
                                    ? Colors.white.withValues(alpha: 0.06)
                                    : Colors.black.withValues(alpha: 0.05)),
                            border: Border.all(
                              color: isActive
                                  ? Colors.transparent
                                  : (isDark
                                      ? Colors.white.withValues(alpha: 0.12)
                                      : Colors.black.withValues(alpha: 0.1)),
                            ),
                          ),
                          child: Text(
                            filter,
                            style: TextStyle(
                              fontSize: 12.5,
                              fontWeight:
                                  isActive ? FontWeight.w800 : FontWeight.w600,
                              color: isActive
                                  ? Colors.white
                                  : (isDark
                                      ? AppTheme.textSecondary
                                      : AppTheme.lightTextSecondary),
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),

            const SizedBox(height: 22),

            // Projects Grid (2-Column Prominent Layout with Natural Fitted Height - Zero Empty Space)
            LayoutBuilder(
              builder: (context, constraints) {
                final isTwoColumn = constraints.maxWidth >= 720;

                if (isTwoColumn && _filteredProjects.length > 1) {
                  final leftProjects = <Map<String, dynamic>>[];
                  final rightProjects = <Map<String, dynamic>>[];
                  for (int i = 0; i < _filteredProjects.length; i++) {
                    if (i % 2 == 0) {
                      leftProjects.add(_filteredProjects[i]);
                    } else {
                      rightProjects.add(_filteredProjects[i]);
                    }
                  }

                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          children: leftProjects.map((proj) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 24),
                              child: FadeInUp(
                                child: _buildProjectCard(proj, isDark),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        child: Column(
                          children: rightProjects.map((proj) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 24),
                              child: FadeInUp(
                                child: _buildProjectCard(proj, isDark),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  );
                } else {
                  return Column(
                    children: _filteredProjects.map((proj) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 24),
                        child: FadeInUp(
                          child: _buildProjectCard(proj, isDark),
                        ),
                      );
                    }).toList(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProjectCard(Map<String, dynamic> proj, bool isDark) {
    final color = proj['color'] as Color;
    final bullets = proj['bullets'] as List<String>;
    final tags = proj['tags'] as List<String>;

    final cardContent = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Top status badges
          Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 11, vertical: 4.5),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  proj['platform'] as String,
                  style: TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w800,
                    color: color,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4.5),
                decoration: BoxDecoration(
                  color: AppTheme.accentGreen.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.circle,
                        size: 7, color: AppTheme.accentGreen),
                    SizedBox(width: 5),
                    Text(
                      'LIVE APP',
                      style: TextStyle(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w800,
                        color: AppTheme.accentGreen,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                icon: Icon(Icons.arrow_outward_rounded,
                    size: 19, color: color),
                tooltip: 'View Architecture & Details',
                onPressed: () => ProjectDetailsModal.show(context, proj),
              ),
            ],
          ),

          const SizedBox(height: 14),

          // Title and Tagline
          Row(
            children: [
              if (proj['icon'] != null) ...[
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    proj['icon'] as String,
                    width: 44,
                    height: 44,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        const SizedBox.shrink(),
                  ),
                ),
                const SizedBox(width: 12),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      proj['title'] as String,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        color: isDark
                            ? Colors.white
                            : AppTheme.lightTextPrimary,
                        letterSpacing: -0.4,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      proj['tagline'] as String,
                      style: TextStyle(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w600,
                        color: color,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Tech tags
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: tags
                .map((t) => Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4.5),
                      decoration: BoxDecoration(
                        color: isDark
                            ? Colors.white.withValues(alpha: 0.06)
                            : Colors.black.withValues(alpha: 0.04),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: isDark
                              ? Colors.white.withValues(alpha: 0.12)
                              : Colors.black.withValues(alpha: 0.08),
                        ),
                      ),
                      child: Text(
                        t,
                        style: TextStyle(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w700,
                          color: isDark
                              ? AppTheme.textSecondary
                              : AppTheme.lightTextSecondary,
                        ),
                      ),
                    ))
                .toList(),
          ),

          const SizedBox(height: 16),

          // Key bullet points preview (natural height, zero empty gap)
          _buildBulletsList(bullets, color, isDark),

          const SizedBox(height: 18),

          // Live App Store and Play Store direct launch buttons
          Row(
            children: [
              // Play store
              if (proj['playStore'] != null)
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => UrlHelper.launchPlayStore(
                        proj['playStore'] as String),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color(0xFF01875F).withValues(alpha: 0.16),
                      foregroundColor: const Color(0xFF01875F),
                      side: BorderSide(
                          color: const Color(0xFF01875F)
                              .withValues(alpha: 0.4),
                          width: 1.2),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(11)),
                      padding: const EdgeInsets.symmetric(vertical: 12.5),
                      elevation: 0,
                    ),
                    icon: const FaIcon(FontAwesomeIcons.googlePlay, size: 14),
                    label: const Text(
                      'Play Store',
                      style: TextStyle(
                          fontSize: 13, fontWeight: FontWeight.w800),
                    ),
                  ),
                ),
              if (proj['playStore'] != null && proj['appStore'] != null)
                const SizedBox(width: 10),
              // App store
              if (proj['appStore'] != null)
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => UrlHelper.launchAppStore(
                        proj['appStore'] as String),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Colors.blueAccent.withValues(alpha: 0.16),
                      foregroundColor: Colors.blueAccent,
                      side: BorderSide(
                          color:
                              Colors.blueAccent.withValues(alpha: 0.4),
                          width: 1.2),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(11)),
                      padding: const EdgeInsets.symmetric(vertical: 12.5),
                      elevation: 0,
                    ),
                    icon: const FaIcon(FontAwesomeIcons.apple, size: 15),
                    label: const Text(
                      'App Store',
                      style: TextStyle(
                          fontSize: 13, fontWeight: FontWeight.w800),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );

    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppTheme.cardDark : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: color.withValues(alpha: 0.32),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.09),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () => ProjectDetailsModal.show(context, proj),
          child: cardContent,
        ),
      ),
    );
  }

  Widget _buildBulletsList(List<String> bullets, Color color, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: bullets.map((b) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 5, right: 10),
                child: Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  b,
                  style: TextStyle(
                    fontSize: 13.5,
                    height: 1.55,
                    color: isDark
                        ? AppTheme.textSecondary
                        : AppTheme.lightTextSecondary,
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
