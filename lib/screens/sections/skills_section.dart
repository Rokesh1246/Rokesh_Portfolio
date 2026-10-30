import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import '../../theme/app_theme.dart';
import '../../widgets/section_header.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 850;
    final isSmallMobile = screenWidth < 400;

    final skillCategories = [
      {
        'category': 'Mobile Development',
        'icon': Icons.phone_android_rounded,
        'color': AppTheme.accentCyan,
        'skills': [
          {'name': 'Flutter & Dart SDK', 'level': 0.95},
          {'name': 'Material Design 3 & Apple HIG', 'level': 0.92},
          {'name': 'Android SDK & iOS Cupertino', 'level': 0.88},
          {'name': 'Responsive & Adaptive UI', 'level': 0.94},
        ],
      },
      {
        'category': 'State & Architecture',
        'icon': Icons.account_tree_rounded,
        'color': AppTheme.accentPurple,
        'skills': [
          {'name': 'Provider Pattern', 'level': 0.95},
          {'name': 'GetX Reactive State', 'level': 0.90},
          {'name': 'Clean Architecture & MVC', 'level': 0.88},
          {'name': 'Business Logic Isolation', 'level': 0.92},
        ],
      },
      {
        'category': 'Backend & APIs',
        'icon': Icons.cloud_sync_rounded,
        'color': AppTheme.accentGreen,
        'skills': [
          {'name': 'REST APIs & Dio Interceptors', 'level': 0.94},
          {'name': 'Socket.IO (Real-time WebSockets)', 'level': 0.88},
          {'name': 'Firebase (Auth, Firestore, Storage)', 'level': 0.92},
          {'name': 'Push Notifications (FCM)', 'level': 0.90},
        ],
      },
      {
        'category': 'Integrations & Security',
        'icon': Icons.security_rounded,
        'color': AppTheme.accentOrange,
        'skills': [
          {'name': 'Cashfree Payment Gateway', 'level': 0.92},
          {'name': 'Apple In-App Purchases (IAP)', 'level': 0.86},
          {'name': 'JWT Auth & Refresh Token Rotation', 'level': 0.93},
          {'name': 'Google Maps API & Geolocation', 'level': 0.90},
        ],
      },
    ];

    final toolsAndLangs = [
      'Flutter', 'Dart', 'Android Studio', 'VS Code', 'Xcode', 'Git', 'GitHub',
      'Postman', 'Firebase', 'Dio', 'Provider', 'GetX', 'Socket.IO',
      'Cashfree Gateway', 'Apple IAP', 'Google Maps', 'SQLite', 'SharedPreferences',
      'Java', 'Python', 'JSON', 'JWT Auth', 'FCM Notifications',
    ];

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? (isSmallMobile ? 16 : 24) : 80,
        vertical: 70,
      ),
      child: Column(
        children: [
          SectionHeader(
            title: 'Technical Skills',
            subtitle: 'Core competencies & engineering toolset',
            isDark: isDark,
          ),
          const SizedBox(height: 50),

          // Skill Cards Grid
          LayoutBuilder(
            builder: (context, constraints) {
              final isTwoColumn = constraints.maxWidth >= 760;

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: skillCategories.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isTwoColumn ? 2 : 1,
                  crossAxisSpacing: 24,
                  mainAxisSpacing: 24,
                  childAspectRatio: isTwoColumn ? 1.3 : 1.15,
                ),
                itemBuilder: (context, index) {
                  final cat = skillCategories[index];
                  return FadeInUp(
                    delay: Duration(milliseconds: index * 120),
                    child: _buildSkillCategoryCard(
                      isDark: isDark,
                      category: cat['category'] as String,
                      icon: cat['icon'] as IconData,
                      color: cat['color'] as Color,
                      skills: cat['skills'] as List<Map<String, dynamic>>,
                    ),
                  );
                },
              );
            },
          ),

          const SizedBox(height: 50),

          // Tools & Technologies Cloud
          FadeInUp(
            delay: const Duration(milliseconds: 500),
            child: Container(
              padding: EdgeInsets.all(isMobile ? 20 : 32),
              decoration: BoxDecoration(
                color: isDark ? AppTheme.cardDark : Colors.white,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.1)
                      : Colors.black.withValues(alpha: 0.08),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.terminal_rounded,
                          size: 20,
                          color: isDark
                              ? AppTheme.accentCyan
                              : AppTheme.accentPurple),
                      const SizedBox(width: 10),
                      Text(
                        'Tools, SDKs & Technologies',
                        style: TextStyle(
                          fontSize: isMobile ? 16 : 19,
                          fontWeight: FontWeight.w800,
                          color: isDark ? Colors.white : AppTheme.lightTextPrimary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    alignment: WrapAlignment.center,
                    children: toolsAndLangs.map((t) {
                      return _buildTechChip(t, isDark);
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillCategoryCard({
    required bool isDark,
    required String category,
    required IconData icon,
    required Color color,
    required List<Map<String, dynamic>> skills,
  }) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isDark ? AppTheme.cardDark : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.25)),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.08),
            blurRadius: 24,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 22),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  category,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                    color: isDark ? Colors.white : AppTheme.lightTextPrimary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: skills.map((s) {
                final double level = s['level'] as double;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            s['name'] as String,
                            style: TextStyle(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w600,
                              color: isDark
                                  ? Colors.white.withValues(alpha: 0.9)
                                  : AppTheme.lightTextPrimary,
                            ),
                          ),
                        ),
                        Text(
                          '${(level * 100).toInt()}%',
                          style: TextStyle(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w700,
                            color: color,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: level,
                        minHeight: 6,
                        backgroundColor: isDark
                            ? Colors.white.withValues(alpha: 0.08)
                            : Colors.black.withValues(alpha: 0.06),
                        valueColor: AlwaysStoppedAnimation<Color>(color),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTechChip(String tech, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.05)
            : Colors.black.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.12)
              : Colors.black.withValues(alpha: 0.08),
        ),
      ),
      child: Text(
        tech,
        style: TextStyle(
          fontSize: 12.5,
          fontWeight: FontWeight.w600,
          color: isDark ? AppTheme.textSecondary : AppTheme.lightTextSecondary,
        ),
      ),
    );
  }
}
