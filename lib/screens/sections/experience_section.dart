import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import '../../theme/app_theme.dart';
import '../../widgets/section_header.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 850;
    final isSmallMobile = screenWidth < 400;

    final experiences = [
      {
        'role': 'Mobile App Developer',
        'type': 'Full-Time',
        'company': 'Doubletap Innovations and Technologies Pvt. Ltd.',
        'period': 'Dec 2025 – Present',
        'location': 'Chennai, Tamil Nadu',
        'color': AppTheme.accentCyan,
        'current': true,
        'points': [
          'Architect and engineer scalable cross-platform mobile applications for Android and iOS adhering to Material 3 and Apple HIG.',
          'Manage app state and isolate business logic using the Provider pattern with clean, maintainable architecture.',
          'Integrate Cashfree Payment Gateway for online transactions, subscription checkouts, and secure verification.',
          'Implement secure JWT authentication with automated refresh token rotation and REST APIs with HTTP interceptors.',
          'Integrate Google Maps API and geolocation services; resolve Android (Gradle) and iOS (Xcode, CocoaPods) build constraints.',
          'Maintain source code, feature branching workflows, pull requests, and code reviews using Git and GitHub.',
        ],
        'tech': ['Flutter', 'Dart', 'Provider', 'Cashfree', 'JWT Auth', 'Google Maps', 'Git/GitHub'],
      },
      {
        'role': 'Flutter Developer Intern',
        'type': 'Internship',
        'company': 'Relie Tech Software Solution',
        'period': 'Aug 2024 – Nov 2025',
        'location': 'Puducherry',
        'color': AppTheme.accentPurple,
        'current': false,
        'points': [
          'Built production Flutter applications for Android and iOS with responsive, 60 FPS widget trees and clean UI.',
          'Configured Firebase backend services, including Authentication, Cloud Firestore real-time DB, and Cloud Storage.',
          'Integrated REST APIs, handled asynchronous data streams, and resolved platform-specific edge cases with DevTools.',
          'Collaborated with senior engineers on release testing, QA bug resolution, and Google Play Store deployment.',
        ],
        'tech': ['Flutter', 'Firebase Auth', 'Firestore', 'Cloud Storage', 'REST APIs', 'DevTools', 'Play Store'],
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
            title: 'Work Experience',
            subtitle: 'Professional engineering track record',
            isDark: isDark,
          ),
          const SizedBox(height: 50),
          ...List.generate(experiences.length, (index) {
            final exp = experiences[index];
            return FadeInUp(
              delay: Duration(milliseconds: index * 200),
              child: _buildExperienceCard(
                isDark: isDark,
                isMobile: isMobile,
                exp: exp,
                isLast: index == experiences.length - 1,
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildExperienceCard({
    required bool isDark,
    required bool isMobile,
    required Map<String, dynamic> exp,
    required bool isLast,
  }) {
    final color = exp['color'] as Color;
    final isCurrent = exp['current'] as bool;
    final points = exp['points'] as List<String>;
    final tech = exp['tech'] as List<String>;

    return Container(
      margin: EdgeInsets.only(bottom: isLast ? 0 : 28),
      padding: EdgeInsets.all(isMobile ? 20 : 32),
      decoration: BoxDecoration(
        color: isDark ? AppTheme.cardDark : Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: color.withValues(alpha: isCurrent ? 0.45 : 0.22),
          width: isCurrent ? 1.5 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: isCurrent ? 0.1 : 0.05),
            blurRadius: 28,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row
          isMobile
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: color.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            exp['type'] as String,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w800,
                              color: color,
                            ),
                          ),
                        ),
                        if (isCurrent) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppTheme.accentGreen.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text(
                              'CURRENT',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w800,
                                color: AppTheme.accentGreen,
                              ),
                            ),
                          ),
                        ],
                        const Spacer(),
                        Text(
                          exp['period'] as String,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: isDark ? Colors.white70 : AppTheme.lightTextPrimary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      exp['role'] as String,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: isDark ? Colors.white : AppTheme.lightTextPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      exp['company'] as String,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: color,
                      ),
                    ),
                    Text(
                      exp['location'] as String,
                      style: TextStyle(
                        fontSize: 12,
                        color: isDark ? AppTheme.textSecondary : AppTheme.lightTextSecondary,
                      ),
                    ),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Icon(Icons.business_rounded, color: color, size: 26),
                    ),
                    const SizedBox(width: 18),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                exp['role'] as String,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                  color: isDark ? Colors.white : AppTheme.lightTextPrimary,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: color.withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  exp['type'] as String,
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w800,
                                    color: color,
                                  ),
                                ),
                              ),
                              if (isCurrent) ...[
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: AppTheme.accentGreen.withValues(alpha: 0.15),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Text(
                                    'PRESENT ROLE',
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w800,
                                      color: AppTheme.accentGreen,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            exp['company'] as String,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: color,
                            ),
                          ),
                          Text(
                            exp['location'] as String,
                            style: TextStyle(
                              fontSize: 12.5,
                              color: isDark ? AppTheme.textSecondary : AppTheme.lightTextSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      exp['period'] as String,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: isDark ? Colors.white70 : AppTheme.lightTextPrimary,
                      ),
                    ),
                  ],
                ),

          const SizedBox(height: 20),

          // Bullet points
          ...points.map(
            (point) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 5, right: 10),
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: color,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      point,
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
            ),
          ),

          const SizedBox(height: 16),

          // Tech stack tags
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: tech.map((t) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.04)
                      : Colors.black.withValues(alpha: 0.04),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: isDark
                        ? Colors.white.withValues(alpha: 0.08)
                        : Colors.black.withValues(alpha: 0.06),
                  ),
                ),
                child: Text(
                  t,
                  style: TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white70 : AppTheme.lightTextPrimary,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
