import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import '../../theme/app_theme.dart';
import '../../widgets/section_header.dart';

class EducationSection extends StatelessWidget {
  const EducationSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 850;
    final isSmallMobile = screenWidth < 400;

    final educations = [
      {
        'degree': 'Bachelor of Science in Chemistry (B.Sc. Chemistry)',
        'institution': 'Government Arts College, Trichy (Bharathidasan University)',
        'location': 'Tiruchirappalli, Tamil Nadu',
        'score': '70% Aggregate',
        'status': 'Graduated',
        'color': AppTheme.accentCyan,
        'icon': Icons.school_rounded,
        'highlights': [
          'Developed strong analytical mindset, scientific methodology, and rigorous problem-solving approach.',
          'Active participant in university tech seminars and transitioned full-time into software engineering.',
        ],
      },
      {
        'degree': 'Full Stack & Mobile Development Training (6 Months)',
        'institution': 'RelieTech, Puducherry',
        'location': 'Puducherry, India',
        'score': 'Specialized Track',
        'status': 'Completed',
        'color': AppTheme.accentPurple,
        'icon': Icons.phone_android_rounded,
        'highlights': [
          'Intensive hands-on immersion in Flutter SDK, Dart OOP, Provider, and Firebase ecosystem.',
          'Built responsive 60 FPS widget trees and connected real-time cloud data pipelines.',
        ],
      },
    ];

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? (isSmallMobile ? 16 : 24) : 80,
        vertical: 70,
      ),
      child: Column(
        children: [
          SectionHeader(
            title: 'Education & Professional Training',
            subtitle: 'Academic foundation and specialized software engineering training',
            isDark: isDark,
          ),
          const SizedBox(height: 50),
          isMobile
              ? Column(
                  children: educations.map((edu) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: FadeInUp(
                        child: _buildEducationCard(isDark, edu, true),
                      ),
                    );
                  }).toList(),
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: educations.map((edu) {
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: FadeInUp(
                          child: _buildEducationCard(isDark, edu, false),
                        ),
                      ),
                    );
                  }).toList(),
                ),
        ],
      ),
    );
  }

  Widget _buildEducationCard(
    bool isDark,
    Map<String, dynamic> edu,
    bool isMobile,
  ) {
    final color = edu['color'] as Color;
    final highlights = edu['highlights'] as List<String>;

    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        color: isDark ? AppTheme.cardDark : Colors.white,
        border: Border.all(color: color.withValues(alpha: 0.25)),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.08),
            blurRadius: 28,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon and status badge
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: color.withValues(alpha: 0.15),
                ),
                child: Icon(edu['icon'] as IconData, color: color, size: 24),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: color.withValues(alpha: 0.15),
                ),
                child: Text(
                  edu['score'] as String,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    color: color,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          Text(
            edu['degree'] as String,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w800,
              color: isDark ? Colors.white : AppTheme.lightTextPrimary,
              height: 1.3,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            edu['institution'] as String,
            style: TextStyle(
              fontSize: 13.5,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),

          const SizedBox(height: 4),

          Text(
            edu['location'] as String,
            style: TextStyle(
              fontSize: 12,
              color: isDark ? AppTheme.textSecondary : AppTheme.lightTextSecondary,
            ),
          ),

          const SizedBox(height: 16),

          Divider(
            color: isDark
                ? Colors.white.withValues(alpha: 0.08)
                : Colors.black.withValues(alpha: 0.06),
          ),

          const SizedBox(height: 14),

          ...highlights.map(
            (hl) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 4, right: 10),
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: color,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      hl,
                      style: TextStyle(
                        fontSize: 12.5,
                        height: 1.5,
                        color: isDark
                            ? AppTheme.textSecondary
                            : AppTheme.lightTextSecondary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
