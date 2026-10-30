import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import '../../theme/app_theme.dart';
import '../../widgets/section_header.dart';

class CertificationsSection extends StatelessWidget {
  const CertificationsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 850;
    final isSmallMobile = screenWidth < 400;

    final certifications = [
      {
        'title': 'Full Stack & Mobile Development Certification',
        'issuer': 'RelieTech Software Solution, Puducherry',
        'duration': '6 Months',
        'specialization': 'Specialized in Flutter & Firebase Ecosystem',
        'color': AppTheme.accentCyan,
        'icon': Icons.phone_android_rounded,
        'skills': ['Flutter SDK', 'Dart', 'Firebase Real-time', 'Provider'],
      },
      {
        'title': 'Core Python Programming Certification',
        'issuer': 'CSC (Common Service Center), Tamil Nadu',
        'duration': '3 Months',
        'specialization': 'Core Programming Fundamentals & Algorithms',
        'color': AppTheme.accentPurple,
        'icon': Icons.code_rounded,
        'skills': ['Python 3', 'OOP Concepts', 'Data Structures', 'Scripting'],
      },
      {
        'title': 'Reactive Mobile State Management Masterclass',
        'issuer': 'Production Flutter Engineering',
        'duration': 'Advanced',
        'specialization': 'Provider, GetX & Clean Architecture Isolation',
        'color': AppTheme.accentGreen,
        'icon': Icons.layers_rounded,
        'skills': ['Provider', 'GetX', 'Dependency Injection', 'Clean Arch'],
      },
      {
        'title': 'Payment Gateways & Security Integration',
        'issuer': 'Fintech & Enterprise Integrations',
        'duration': 'Production Verified',
        'specialization': 'Cashfree Payment Gateway, Apple IAP & JWT Auth',
        'color': AppTheme.accentOrange,
        'icon': Icons.verified_user_rounded,
        'skills': ['Cashfree', 'Apple IAP', 'JWT Token Rotation', 'REST APIs'],
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
            title: 'Certifications & Specializations',
            subtitle: 'Validated credentials and specialized engineering proficiencies',
            isDark: isDark,
          ),
          const SizedBox(height: 50),
          LayoutBuilder(
            builder: (context, constraints) {
              final isTwoColumn = constraints.maxWidth >= 760;

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: certifications.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isTwoColumn ? 2 : 1,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  childAspectRatio: isTwoColumn ? 1.9 : 1.7,
                ),
                itemBuilder: (context, index) {
                  final cert = certifications[index];
                  final color = cert['color'] as Color;
                  final skills = cert['skills'] as List<String>;

                  return FadeInUp(
                    delay: Duration(milliseconds: index * 100),
                    child: Container(
                      padding: const EdgeInsets.all(22),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: isDark ? AppTheme.cardDark : Colors.white,
                        border: Border.all(color: color.withValues(alpha: 0.25)),
                        boxShadow: [
                          BoxShadow(
                            color: color.withValues(alpha: 0.08),
                            blurRadius: 20,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 44,
                                height: 44,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: color.withValues(alpha: 0.15),
                                ),
                                child: Icon(cert['icon'] as IconData,
                                    color: color, size: 22),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      cert['title'] as String,
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w800,
                                        color: isDark
                                            ? Colors.white
                                            : AppTheme.lightTextPrimary,
                                        height: 1.25,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      cert['issuer'] as String,
                                      style: TextStyle(
                                        fontSize: 12.5,
                                        fontWeight: FontWeight.w600,
                                        color: color,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: color.withValues(alpha: 0.12),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  cert['duration'] as String,
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w800,
                                    color: color,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            cert['specialization'] as String,
                            style: TextStyle(
                              fontSize: 12.5,
                              color: isDark
                                  ? AppTheme.textSecondary
                                  : AppTheme.lightTextSecondary,
                            ),
                          ),
                          const Spacer(),
                          Wrap(
                            spacing: 6,
                            runSpacing: 6,
                            children: skills.map((s) {
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  color: isDark
                                      ? Colors.white.withValues(alpha: 0.04)
                                      : Colors.black.withValues(alpha: 0.04),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  s,
                                  style: TextStyle(
                                    fontSize: 10.5,
                                    fontWeight: FontWeight.w600,
                                    color: isDark
                                        ? Colors.white70
                                        : AppTheme.lightTextPrimary,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
