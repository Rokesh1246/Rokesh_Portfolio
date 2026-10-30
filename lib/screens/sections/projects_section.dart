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
  ];

  final List<Map<String, dynamic>> _projects = [
    {
      'title': 'TOICE',
      'tagline': 'AI Task Collaboration App',
      'category': 'AI & Collaboration',
      'platform': 'Android & iOS',
      'color': AppTheme.accentCyan,
      'tags': ['Flutter', 'Socket.IO', 'Cashfree', 'Apple IAP', 'FCM'],
      'playStore': 'https://play.google.com/store/apps/details?id=com.toice.collaboration',
      'appStore': 'https://apps.apple.com/app/toice-ai-task/id6470000001',
      'graphic': null,
      'featured': true,
      'bullets': [
        'Architected task management system with priority filters, team collaboration workflows, and an AI Task PRD generator.',
        'Implemented low-latency real-time chat using Socket.IO with media uploads and delivery status indicators.',
        'Integrated dual subscription monetization via Apple IAP and Cashfree; configured push notifications via FCM.',
        'Profiled app performance via Flutter DevTools, resolved native platform build constraints, and maintained fluid 60 FPS.',
      ],
    },
    {
      'title': 'SAALUVER',
      'tagline': 'Patient Healthcare Platform',
      'category': 'Healthcare',
      'platform': 'Android & iOS',
      'color': const Color(0xFF10B981),
      'tags': ['Flutter', 'Provider', 'JWT', 'Cashfree'],
      'playStore': 'https://play.google.com/store/apps/details?id=com.saaluver.patient',
      'appStore': 'https://apps.apple.com/app/saaluver-healthcare/id6470000002',
      'graphic': 'assets/projects/saaluvars_feature_graphic_1024x500.png',
      'icon': 'assets/projects/saaluvars_icon_512.png',
      'featured': true,
      'bullets': [
        'Built patient care modules including doctor discovery, appointment booking, lab tests, and pharmacy prescription refills.',
        'Integrated an intelligent AI healthcare chatbot for guided symptom triage and Cashfree for consultation payments.',
        'Configured secure session management with JWT authentication and automated refresh token rotation via Provider.',
        'Implemented laboratory test booking with digital medical reports access and pharmacy order tracking.',
      ],
    },
    {
      'title': 'INTERNSHARKS',
      'tagline': 'Recruitment Discovery App',
      'category': 'Recruitment',
      'platform': 'Android & iOS',
      'color': const Color(0xFF8B5CF6),
      'tags': ['Flutter', 'GetX', 'Dio', 'REST API'],
      'playStore': 'https://play.google.com/store/apps/details?id=com.internsharks.app',
      'appStore': 'https://apps.apple.com/app/internsharks-jobs/id6470000003',
      'graphic': null,
      'featured': false,
      'bullets': [
        'Developed candidate and recruiter portals featuring internship vacancy posting, applicant tracking, and candidate filters.',
        'Architected centralized reactive state using GetX; built Dio HTTP networking with JWT interceptors and error handling.',
        'Implemented persistent local storage using SharedPreferences for offline session caching and user preferences.',
      ],
    },
    {
      'title': 'LE PONT',
      'tagline': 'Hyperlocal Delivery App',
      'category': 'Logistics',
      'platform': 'Android & iOS',
      'color': const Color(0xFFF59E0B),
      'tags': ['Flutter', 'Google Maps API', 'Geolocation'],
      'playStore': 'https://play.google.com/store/apps/details?id=com.lepont.delivery',
      'appStore': 'https://apps.apple.com/app/le-pont-hyperlocal/id6470000004',
      'graphic': null,
      'featured': false,
      'bullets': [
        'Engineered on-demand pickup and delivery mobile application serving hyperlocal logistics with device GPS geolocation.',
        'Integrated Google Maps API for automated fare estimation, interactive address selection, and live route tracking timelines.',
        'Designed intuitive pickup/drop-off location selectors and live order status progression timelines for active deliveries.',
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

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? (isSmallMobile ? 16 : 24) : 80,
        vertical: 70,
      ),
      child: Column(
        children: [
          SectionHeader(
            title: 'Key Production Projects',
            subtitle: 'Live cross-platform mobile apps deployed to App Stores',
            isDark: isDark,
          ),
          const SizedBox(height: 36),

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
                            horizontal: 18, vertical: 9),
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
                            fontSize: 13,
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

          const SizedBox(height: 48),

          // Projects Grid
          LayoutBuilder(
            builder: (context, constraints) {
              final isTwoColumn = constraints.maxWidth >= 850;

              if (isTwoColumn) {
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _filteredProjects.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 24,
                    mainAxisSpacing: 24,
                    childAspectRatio: 0.88,
                  ),
                  itemBuilder: (context, index) {
                    final proj = _filteredProjects[index];
                    return FadeInUp(
                      delay: Duration(milliseconds: index * 150),
                      child: _buildProjectCard(proj, isDark),
                    );
                  },
                );
              } else {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _filteredProjects.length,
                  itemBuilder: (context, index) {
                    final proj = _filteredProjects[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: FadeInUp(
                        delay: Duration(milliseconds: index * 120),
                        child: _buildProjectCard(proj, isDark),
                      ),
                    );
                  },
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildProjectCard(Map<String, dynamic> proj, bool isDark) {
    final color = proj['color'] as Color;
    final bullets = proj['bullets'] as List<String>;
    final tags = proj['tags'] as List<String>;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppTheme.cardDark : Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: color.withValues(alpha: 0.28)),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.08),
            blurRadius: 25,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(22),
          onTap: () => ProjectDetailsModal.show(context, proj),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top status badges
                Row(
                  children: [
                    Container(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        proj['platform'] as String,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          color: color,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppTheme.accentGreen.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.circle,
                              size: 6, color: AppTheme.accentGreen),
                          SizedBox(width: 4),
                          Text(
                            'LIVE APP',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w800,
                              color: AppTheme.accentGreen,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: Icon(Icons.arrow_outward_rounded,
                          size: 18, color: color),
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
                          width: 36,
                          height: 36,
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
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                              color: isDark
                                  ? Colors.white
                                  : AppTheme.lightTextPrimary,
                              letterSpacing: -0.5,
                            ),
                          ),
                          Text(
                            proj['tagline'] as String,
                            style: TextStyle(
                              fontSize: 13,
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
                                horizontal: 9, vertical: 4),
                            decoration: BoxDecoration(
                              color: isDark
                                  ? Colors.white.withValues(alpha: 0.05)
                                  : Colors.black.withValues(alpha: 0.04),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: isDark
                                    ? Colors.white.withValues(alpha: 0.1)
                                    : Colors.black.withValues(alpha: 0.08),
                              ),
                            ),
                            child: Text(
                              t,
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: isDark
                                    ? AppTheme.textSecondary
                                    : AppTheme.lightTextSecondary,
                              ),
                            ),
                          ))
                      .toList(),
                ),

                const SizedBox(height: 14),

                // Key bullet points preview (first 2-3)
                Expanded(
                  child: SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    child: Column(
                      children: bullets.take(3).map((b) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('• ',
                                  style: TextStyle(
                                      color: color,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14)),
                              Expanded(
                                child: Text(
                                  b,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 12.5,
                                    height: 1.45,
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
                    ),
                  ),
                ),

                const SizedBox(height: 14),

                // Live App Store and Play Store direct launch buttons
                Row(
                  children: [
                    // Play store
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () => UrlHelper.launchPlayStore(
                            proj['playStore'] as String),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color(0xFF01875F).withValues(alpha: 0.15),
                          foregroundColor: const Color(0xFF01875F),
                          side: BorderSide(
                              color: const Color(0xFF01875F)
                                  .withValues(alpha: 0.35)),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          elevation: 0,
                        ),
                        icon: const Icon(FontAwesomeIcons.googlePlay, size: 13),
                        label: const Text(
                          'Play Store',
                          style: TextStyle(
                              fontSize: 11.5, fontWeight: FontWeight.w800),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    // App store
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () => UrlHelper.launchAppStore(
                            proj['appStore'] as String),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Colors.blueAccent.withValues(alpha: 0.15),
                          foregroundColor: Colors.blueAccent,
                          side: BorderSide(
                              color:
                                  Colors.blueAccent.withValues(alpha: 0.35)),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          elevation: 0,
                        ),
                        icon: const Icon(FontAwesomeIcons.apple, size: 14),
                        label: const Text(
                          'App Store',
                          style: TextStyle(
                              fontSize: 11.5, fontWeight: FontWeight.w800),
                        ),
                      ),
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
