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
        'role': 'Flutter Developer',
        'type': 'Full-Time',
        'company': 'Doubletap Innovations and Technologies Pvt. Ltd.',
        'period': 'December 2025 – Present',
        'location': 'Chennai, Tamil Nadu',
        'color': AppTheme.accentCyan,
        'current': true,
        'points': [
          'Architect and engineer scalable cross-platform mobile apps for Android and iOS with Flutter and Dart, spearheading core client applications: Saaluver (Healthcare), Toice (AI Task Collaboration), and Internsharks (Recruitment Discovery).',
          'Implement robust application architecture and reactive state management using Provider and GetX patterns.',
          'Integrate Cashfree Payment Gateway and Apple In-App Purchases (StoreKit) for multi-tier subscriptions, payment processing, and automated webhook verification.',
          'Implement secure JWT authentication, access token management, and refresh token handling using Flutter Secure Storage.',
          'Integrate REST APIs via Dio with HTTP interceptors for automatic token renewal, request signing, and structured error logging.',
          'Engineer Google Maps API integration with live location tracking, distance calculations, and native geolocation services.',
          'Develop healthcare modules (appointment booking, refills, lab tests, AI chatbot) and resolve Gradle/Xcode build constraints for store submissions.',
          'Manage Git/GitHub workflows, feature branching, pull requests, and collaborative code reviews across agile sprints.',
        ],
        'tech': ['Flutter', 'Dart', 'Provider', 'GetX', 'Cashfree', 'Apple IAP', 'StoreKit', 'JWT Auth', 'Dio', 'Google Maps', 'Git/GitHub'],
      },
      {
        'role': 'Full-Stack Developer (Flutter & Firebase)',
        'type': 'Full-Time',
        'company': 'RelieTech',
        'period': 'November 2024 – November 2025',
        'location': 'Puducherry, India',
        'color': AppTheme.accentPurple,
        'current': false,
        'points': [
          'Developed cross-platform mobile applications for Android and iOS using Flutter and Dart, and engineered responsive web applications and dynamic websites using Flutter Web, HTML5, and CSS3.',
          'Engineered and deployed production client applications: Le Pont (Hyperlocal Delivery) and Relie Enquiry (Business Inquiry CRM on Play Store).',
          'Designed responsive user interfaces adapting smoothly across mobile, tablet, and desktop browser viewports using Material Design 3 and Cupertino widgets.',
          'Configured Firebase backend services (Authentication, Cloud Firestore real-time DB, Cloud Storage) for scalable application data.',
          'Integrated REST APIs and managed asynchronous frontend-backend data communication with optimized local caching.',
          'Engineered reusable Flutter widget libraries, conducted QA bug resolution, app signing, and production release to the Google Play Store.',
        ],
        'tech': ['Flutter', 'Dart', 'Flutter Web', 'Firebase Auth', 'Firestore', 'Cloud Storage', 'REST APIs', 'HTML5/CSS3', 'Play Store'],
      },
    ];

    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 1200),
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? (isSmallMobile ? 16 : 24) : 40,
          vertical: 50,
        ),
        child: Column(
          children: [
            SectionHeader(
              title: 'Work Experience',
              subtitle: 'Professional engineering track record from resume',
              isDark: isDark,
            ),
            const SizedBox(height: 36),
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
