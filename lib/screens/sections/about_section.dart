import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import '../../theme/app_theme.dart';
import '../../utils/url_helper.dart';
import '../../widgets/resume_modal.dart';
import '../../widgets/section_header.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

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
            title: 'About Me',
            subtitle: 'Crafting high-impact mobile experiences',
            isDark: isDark,
          ),
          const SizedBox(height: 50),
          isMobile
              ? Column(
                  children: [
                    _buildAboutText(context, isDark, isMobile),
                    const SizedBox(height: 36),
                    _buildQuickCards(context, isDark, isMobile),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 5,
                      child: _buildAboutText(context, isDark, isMobile),
                    ),
                    const SizedBox(width: 48),
                    Expanded(
                      flex: 4,
                      child: _buildQuickCards(context, isDark, isMobile),
                    ),
                  ],
                ),
        ],
      ),
    );
  }

  Widget _buildAboutText(BuildContext context, bool isDark, bool isMobile) {
    return FadeInLeft(
      duration: const Duration(milliseconds: 700),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: AppTheme.accentCyan.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: AppTheme.accentCyan.withValues(alpha: 0.3),
              ),
            ),
            child: const Text(
              'PASSIONATE MOBILE ENGINEER',
              style: TextStyle(
                fontSize: 11.5,
                fontWeight: FontWeight.w800,
                color: AppTheme.accentCyan,
                letterSpacing: 0.8,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Specialized in Flutter, Dart & Scalable Mobile Architecture',
            style: TextStyle(
              fontSize: isMobile ? 22 : 28,
              fontWeight: FontWeight.w800,
              color: isDark ? Colors.white : AppTheme.lightTextPrimary,
              height: 1.25,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 18),
          Text(
            'I\'m Rokesh Govindaraj, a results-driven Flutter Developer based in Chennai, Tamil Nadu with over 2+ years of hands-on experience designing, scaling, and deploying fluid cross-platform mobile apps for Android and iOS.',
            style: TextStyle(
              fontSize: 15,
              color: isDark ? AppTheme.textSecondary : AppTheme.lightTextSecondary,
              height: 1.7,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            'Currently serving as a Full-Time Mobile App Developer at Doubletap Innovations and Technologies Pvt. Ltd., I architect clean, scalable solutions following Material 3 and Apple Human Interface Guidelines (HIG). My day-to-day focuses on reactive state management with Provider and GetX, secure JWT authentication with automated refresh token rotation, Cashfree Payment Gateway, Apple IAP monetization, and Google Maps live geolocation.',
            style: TextStyle(
              fontSize: 15,
              color: isDark ? AppTheme.textSecondary : AppTheme.lightTextSecondary,
              height: 1.7,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            'With 4 live production applications shipped across AI collaboration, telemedicine, hyperlocal logistics, and recruitment, I take immense pride in profiling app performance with Flutter DevTools to consistently maintain smooth 60 FPS widget trees and resolve tough native Gradle/CocoaPods build edge cases.',
            style: TextStyle(
              fontSize: 15,
              color: isDark ? AppTheme.textSecondary : AppTheme.lightTextSecondary,
              height: 1.7,
            ),
          ),
          const SizedBox(height: 28),

          // Chips info row
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              _buildInfoBadge(Icons.location_on_rounded, 'Chennai, India', isDark),
              _buildInfoBadge(Icons.translate_rounded, 'Tamil (Native), English', isDark),
              _buildInfoBadge(Icons.bolt_rounded, 'Immediate Joiner', isDark),
              _buildInfoBadge(Icons.devices_rounded, 'Android & iOS Native', isDark),
            ],
          ),
          const SizedBox(height: 32),

          // Resume CTAs in About section
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              ElevatedButton.icon(
                onPressed: () => ResumeModal.show(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: isDark ? AppTheme.accentCyan : AppTheme.accentPurple,
                  foregroundColor: isDark ? Colors.black : Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 13),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 0,
                ),
                icon: const Icon(Icons.visibility_rounded, size: 18),
                label: const Text('View Full Resume', style: TextStyle(fontWeight: FontWeight.w800)),
              ),
              OutlinedButton.icon(
                onPressed: () => UrlHelper.downloadResume(context),
                style: OutlinedButton.styleFrom(
                  foregroundColor: isDark ? Colors.white : AppTheme.lightTextPrimary,
                  side: BorderSide(
                    color: (isDark ? AppTheme.accentCyan : AppTheme.accentPurple)
                        .withValues(alpha: 0.4),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                icon: const Icon(Icons.download_rounded, size: 18),
                label: const Text('Download Resume PDF', style: TextStyle(fontWeight: FontWeight.w700)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoBadge(IconData icon, String text, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.05)
            : Colors.black.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.1)
              : Colors.black.withValues(alpha: 0.08),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon,
              size: 14,
              color: isDark ? AppTheme.accentCyan : AppTheme.accentPurple),
          const SizedBox(width: 6),
          Text(
            text,
            style: TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white70 : AppTheme.lightTextPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickCards(BuildContext context, bool isDark, bool isMobile) {
    return FadeInRight(
      duration: const Duration(milliseconds: 700),
      child: Column(
        children: [
          // Current Role Card
          _buildFeatureCard(
            title: 'Current Role',
            subtitle: 'Doubletap Innovations and Technologies',
            description:
                'Mobile App Developer (Full-Time) leading architectural state isolation, Cashfree gateway, JWT refresh token rotation, and Google Maps integration.',
            icon: Icons.work_rounded,
            color: AppTheme.accentCyan,
            isDark: isDark,
          ),
          const SizedBox(height: 16),

          // 5 Production Apps Shipped
          _buildFeatureCard(
            title: '5 Live Production Apps',
            subtitle: 'Google Play & Apple App Store',
            description:
                'TOICE (AI Collaboration), SAALUVARS (Healthcare), INTERNSHARKS (Recruitment), LE PONT (Logistics), and RELIE ENQUIRY (CRM).',
            icon: Icons.store_rounded,
            color: AppTheme.accentGreen,
            isDark: isDark,
          ),
          const SizedBox(height: 16),

          // Engineering Excellence Card
          _buildFeatureCard(
            title: 'Engineering Quality',
            subtitle: '60 FPS & Clean Architecture',
            description:
                'Deep experience profiling memory leaks & widget rebuilds in DevTools, resolving native Gradle & CocoaPods build constraints.',
            icon: Icons.speed_rounded,
            color: AppTheme.accentPurple,
            isDark: isDark,
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard({
    required String title,
    required String subtitle,
    required String description,
    required IconData icon,
    required Color color,
    required bool isDark,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? AppTheme.cardDark : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.25)),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 22),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: isDark ? Colors.white : AppTheme.lightTextPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                    color: color,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12.5,
                    height: 1.5,
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
  }
}
