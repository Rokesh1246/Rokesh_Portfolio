import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../theme/app_theme.dart';
import '../utils/url_helper.dart';

class ResumeModal extends StatelessWidget {
  const ResumeModal({super.key});

  static void show(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.black87,
      builder: (context) => const ResumeModal(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(
        horizontal: isMobile ? 12 : 40,
        vertical: isMobile ? 16 : 30,
      ),
      child: Container(
        width: 900,
        constraints: BoxConstraints(maxHeight: size.height * 0.92),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF0F172A) : Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isDark
                ? AppTheme.accentCyan.withValues(alpha: 0.3)
                : AppTheme.accentPurple.withValues(alpha: 0.25),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.5),
              blurRadius: 40,
              offset: const Offset(0, 15),
            ),
          ],
        ),
        child: Column(
          children: [
            // Top Modal Action Bar
            _buildTopBar(context, isDark, isMobile),

            // Scrollable Resume Content
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.all(isMobile ? 16 : 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(isDark, isMobile),
                    const SizedBox(height: 20),
                    _buildQuickActionButtons(context, isDark, isMobile),
                    const SizedBox(height: 24),
                    _buildDivider(isDark),
                    const SizedBox(height: 20),
                    _buildSummary(isDark),
                    const SizedBox(height: 24),
                    _buildWorkExperience(isDark),
                    const SizedBox(height: 24),
                    _buildProjects(isDark),
                    const SizedBox(height: 24),
                    _buildSkills(isDark),
                    const SizedBox(height: 24),
                    _buildEducation(isDark),
                    const SizedBox(height: 32),
                    _buildBottomDownloadCTA(context, isDark),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context, bool isDark, bool isMobile) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E293B) : const Color(0xFFF1F5F9),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        border: Border(
          bottom: BorderSide(
            color: isDark
                ? Colors.white.withValues(alpha: 0.08)
                : Colors.black.withValues(alpha: 0.06),
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppTheme.accentCyan.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: AppTheme.accentCyan.withValues(alpha: 0.3),
              ),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.verified_user_rounded,
                    color: AppTheme.accentCyan, size: 14),
                SizedBox(width: 6),
                Text(
                  'RESUME PREVIEW',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    color: AppTheme.accentCyan,
                    letterSpacing: 0.8,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          // Download PDF button
          ElevatedButton.icon(
            onPressed: () => UrlHelper.downloadResume(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.accentCyan,
              foregroundColor: Colors.black,
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 12 : 18,
                vertical: isMobile ? 8 : 12,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 0,
            ),
            icon: const Icon(Icons.download_rounded, size: 16),
            label: Text(
              isMobile ? 'PDF' : 'Download PDF',
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
            ),
          ),
          const SizedBox(width: 8),
          // Close button
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(
              Icons.close_rounded,
              color: isDark ? Colors.white70 : Colors.black54,
            ),
            tooltip: 'Close',
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(bool isDark, bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Rokesh Govindaraj',
                    style: TextStyle(
                      fontSize: isMobile ? 24 : 32,
                      fontWeight: FontWeight.w900,
                      color: isDark ? Colors.white : AppTheme.lightTextPrimary,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Results-driven Flutter Developer (2+ Years)',
                    style: TextStyle(
                      fontSize: isMobile ? 14 : 16,
                      fontWeight: FontWeight.w600,
                      color: isDark ? AppTheme.accentCyan : AppTheme.accentPurple,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 16,
          runSpacing: 8,
          children: [
            _buildContactItem(
              icon: Icons.location_on_outlined,
              label: 'Chennai, Tamil Nadu, India',
              isDark: isDark,
            ),
            _buildContactItem(
              icon: Icons.phone_outlined,
              label: '+91 9943719312',
              isDark: isDark,
              onTap: () => UrlHelper.launchPhoneDialer(),
            ),
            _buildContactItem(
              icon: Icons.email_outlined,
              label: 'roga719@gmail.com',
              isDark: isDark,
              onTap: () => UrlHelper.launchEmailClient(),
            ),
            _buildContactItem(
              icon: FontAwesomeIcons.linkedin,
              label: 'linkedin.com/in/rokesh-g-878868255',
              isDark: isDark,
              onTap: () => UrlHelper.launchExternal(UrlHelper.linkedinUrl),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildContactItem({
    required IconData icon,
    required String label,
    required bool isDark,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 14,
              color: isDark ? AppTheme.accentCyan : AppTheme.accentPurple,
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 12.5,
                fontWeight: onTap != null ? FontWeight.w600 : FontWeight.w400,
                color: onTap != null
                    ? (isDark ? Colors.white : AppTheme.lightTextPrimary)
                    : (isDark ? AppTheme.textSecondary : AppTheme.lightTextSecondary),
                decoration: onTap != null ? TextDecoration.underline : null,
                decorationColor: (isDark ? AppTheme.accentCyan : AppTheme.accentPurple).withValues(alpha: 0.5),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActionButtons(
      BuildContext context, bool isDark, bool isMobile) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [
        OutlinedButton.icon(
          onPressed: () => UrlHelper.launchPhoneDialer(),
          style: OutlinedButton.styleFrom(
            foregroundColor: AppTheme.accentGreen,
            side: BorderSide(color: AppTheme.accentGreen.withValues(alpha: 0.4)),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          ),
          icon: const Icon(Icons.call_rounded, size: 14),
          label: const Text('Call Now', style: TextStyle(fontSize: 12)),
        ),
        OutlinedButton.icon(
          onPressed: () => UrlHelper.launchEmailClient(),
          style: OutlinedButton.styleFrom(
            foregroundColor: AppTheme.accentCyan,
            side: BorderSide(color: AppTheme.accentCyan.withValues(alpha: 0.4)),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          ),
          icon: const Icon(Icons.mail_outline_rounded, size: 14),
          label: const Text('Email Me', style: TextStyle(fontSize: 12)),
        ),
        OutlinedButton.icon(
          onPressed: () => UrlHelper.launchWhatsAppChat(),
          style: OutlinedButton.styleFrom(
            foregroundColor: const Color(0xFF25D366),
            side: BorderSide(color: const Color(0xFF25D366).withValues(alpha: 0.4)),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          ),
          icon: const Icon(FontAwesomeIcons.whatsapp, size: 14),
          label: const Text('WhatsApp', style: TextStyle(fontSize: 12)),
        ),
        OutlinedButton.icon(
          onPressed: () => UrlHelper.launchExternal(UrlHelper.linkedinUrl),
          style: OutlinedButton.styleFrom(
            foregroundColor: const Color(0xFF0A66C2),
            side: BorderSide(color: const Color(0xFF0A66C2).withValues(alpha: 0.4)),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          ),
          icon: const Icon(FontAwesomeIcons.linkedin, size: 14),
          label: const Text('LinkedIn', style: TextStyle(fontSize: 12)),
        ),
      ],
    );
  }

  Widget _buildDivider(bool isDark) {
    return Container(
      height: 1,
      color: isDark
          ? Colors.white.withValues(alpha: 0.1)
          : Colors.black.withValues(alpha: 0.08),
    );
  }

  Widget _buildSectionTitle(String title, IconData icon, bool isDark) {
    return Row(
      children: [
        Icon(icon,
            size: 18,
            color: isDark ? AppTheme.accentCyan : AppTheme.accentPurple),
        const SizedBox(width: 8),
        Text(
          title.toUpperCase(),
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.2,
            color: isDark ? Colors.white : AppTheme.lightTextPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildSummary(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Professional Summary', Icons.person_rounded, isDark),
        const SizedBox(height: 10),
        Text(
          'Results-driven Flutter Developer with 2+ years of hands-on experience developing, scaling, and deploying high-performance cross-platform mobile apps for Android and iOS using Flutter and Dart. Strong technical expertise in reactive state management (Provider, GetX), REST API integration with Dio/HTTP interceptors, Firebase ecosystem, secure JWT authentication with refresh token rotation, and payment gateways (Cashfree, Apple IAP). Proven track record across 4 live production apps in AI collaboration, telemedicine, and hyperlocal logistics.',
          style: TextStyle(
            fontSize: 13.5,
            height: 1.6,
            color: isDark ? AppTheme.textSecondary : AppTheme.lightTextSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildWorkExperience(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Work Experience', Icons.work_rounded, isDark),
        const SizedBox(height: 14),
        _buildExperienceItem(
          company: 'Doubletap Innovations and Technologies Pvt. Ltd.',
          location: 'Chennai, Tamil Nadu',
          role: 'Mobile App Developer — Full-Time',
          period: 'Dec 2025 – Present',
          isDark: isDark,
          points: [
            'Architect and engineer scalable cross-platform mobile applications for Android and iOS adhering to Material 3 and Apple HIG.',
            'Manage app state and isolate business logic using the Provider pattern with clean, maintainable architecture.',
            'Integrate Cashfree Payment Gateway for online transactions, subscription checkouts, and secure verification.',
            'Implement secure JWT authentication with automated refresh token rotation and REST APIs with HTTP interceptors.',
            'Integrate Google Maps API and geolocation services; resolve Android (Gradle) and iOS (Xcode, CocoaPods) build constraints.',
            'Maintain source code, feature branching workflows, pull requests, and code reviews using Git and GitHub.',
          ],
        ),
        const SizedBox(height: 20),
        _buildExperienceItem(
          company: 'Relie Tech Software Solution',
          location: 'Puducherry',
          role: 'Flutter Developer Intern',
          period: 'Aug 2024 – Nov 2025',
          isDark: isDark,
          points: [
            'Built production Flutter applications for Android and iOS with responsive, 60 FPS widget trees and clean UI.',
            'Configured Firebase backend services, including Authentication, Cloud Firestore real-time DB, and Cloud Storage.',
            'Integrated REST APIs, handled asynchronous data streams, and resolved platform-specific edge cases with DevTools.',
            'Collaborated with senior engineers on release testing, QA bug resolution, and Google Play Store deployment.',
          ],
        ),
      ],
    );
  }

  Widget _buildExperienceItem({
    required String company,
    required String location,
    required String role,
    required String period,
    required List<String> points,
    required bool isDark,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.03)
            : Colors.black.withValues(alpha: 0.02),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.08)
              : Colors.black.withValues(alpha: 0.06),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      company,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: isDark ? Colors.white : AppTheme.lightTextPrimary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      role,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: isDark ? AppTheme.accentCyan : AppTheme.accentPurple,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    period,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: isDark ? Colors.white70 : AppTheme.lightTextPrimary,
                    ),
                  ),
                  Text(
                    location,
                    style: TextStyle(
                      fontSize: 11,
                      color: isDark
                          ? AppTheme.textSecondary
                          : AppTheme.lightTextSecondary,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...points.map(
            (p) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('• ',
                      style: TextStyle(
                          color: isDark
                              ? AppTheme.accentCyan
                              : AppTheme.accentPurple,
                          fontWeight: FontWeight.bold)),
                  Expanded(
                    child: Text(
                      p,
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

  Widget _buildProjects(bool isDark) {
    final projects = [
      {
        'title': 'TOICE – AI Task Collaboration App',
        'tech': 'Flutter, Socket.IO, Cashfree, Apple IAP, FCM',
        'platform': 'Android & iOS',
        'playStore': 'https://play.google.com/store/apps/details?id=com.toice.collaboration',
        'appStore': 'https://apps.apple.com/app/toice-ai-task/id6470000001',
        'bullets': [
          'Architected task management system with priority filters, team collaboration workflows, and an AI Task PRD generator.',
          'Implemented low-latency real-time chat using Socket.IO with media uploads and delivery status indicators.',
          'Integrated dual subscription monetization via Apple IAP and Cashfree; configured push notifications via FCM.',
          'Profiled app performance via Flutter DevTools, resolved native platform build constraints, and maintained fluid 60 FPS.',
        ],
      },
      {
        'title': 'SAALUVER – Patient Healthcare Platform',
        'tech': 'Flutter, Provider, JWT, Cashfree',
        'platform': 'Android & iOS',
        'playStore': 'https://play.google.com/store/apps/details?id=com.saaluver.patient',
        'appStore': 'https://apps.apple.com/app/saaluver-healthcare/id6470000002',
        'bullets': [
          'Built patient care modules including doctor discovery, appointment booking, lab tests, and pharmacy prescription refills.',
          'Integrated an intelligent AI healthcare chatbot for guided symptom triage and Cashfree for consultation payments.',
          'Configured secure session management with JWT authentication and automated refresh token rotation via Provider.',
          'Implemented laboratory test booking with digital medical reports access and pharmacy order tracking.',
        ],
      },
      {
        'title': 'INTERNSHARKS – Recruitment Discovery App',
        'tech': 'Flutter, GetX, Dio, REST API',
        'platform': 'Android & iOS',
        'playStore': 'https://play.google.com/store/apps/details?id=com.internsharks.app',
        'appStore': 'https://apps.apple.com/app/internsharks-jobs/id6470000003',
        'bullets': [
          'Developed candidate and recruiter portals featuring internship vacancy posting, applicant tracking, and candidate filters.',
          'Architected centralized reactive state using GetX; built Dio HTTP networking with JWT interceptors and error handling.',
          'Implemented persistent local storage using SharedPreferences for offline session caching and user preferences.',
        ],
      },
      {
        'title': 'LE PONT – Hyperlocal Delivery App',
        'tech': 'Flutter, Google Maps API, Geolocation',
        'platform': 'Android & iOS',
        'playStore': 'https://play.google.com/store/apps/details?id=com.lepont.delivery',
        'appStore': 'https://apps.apple.com/app/le-pont-hyperlocal/id6470000004',
        'bullets': [
          'Engineered on-demand pickup and delivery mobile application serving hyperlocal logistics with device GPS geolocation.',
          'Integrated Google Maps API for automated fare estimation, interactive address selection, and live route tracking timelines.',
          'Designed intuitive pickup/drop-off location selectors and live order status progression timelines for active deliveries.',
        ],
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Key Production Projects', Icons.rocket_launch_rounded, isDark),
        const SizedBox(height: 14),
        ...projects.map(
          (proj) => Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.03)
                  : Colors.black.withValues(alpha: 0.02),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.08)
                    : Colors.black.withValues(alpha: 0.06),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            proj['title'] as String,
                            style: TextStyle(
                              fontSize: 14.5,
                              fontWeight: FontWeight.w700,
                              color: isDark ? Colors.white : AppTheme.lightTextPrimary,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            proj['tech'] as String,
                            style: const TextStyle(
                              fontSize: 12,
                              fontStyle: FontStyle.italic,
                              color: AppTheme.accentOrange,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: AppTheme.accentGreen.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        proj['platform'] as String,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.accentGreen,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                ...(proj['bullets'] as List<String>).map(
                  (b) => Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('• ',
                            style: TextStyle(
                              color: isDark ? AppTheme.accentCyan : AppTheme.accentPurple,
                              fontWeight: FontWeight.bold,
                            )),
                        Expanded(
                          child: Text(
                            b,
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
                  ),
                ),
                const SizedBox(height: 10),
                // Store links row
                Row(
                  children: [
                    InkWell(
                      onTap: () => UrlHelper.launchPlayStore(proj['playStore'] as String),
                      borderRadius: BorderRadius.circular(6),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: const Color(0xFF01875F).withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: const Color(0xFF01875F).withValues(alpha: 0.3)),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(FontAwesomeIcons.googlePlay, size: 12, color: Color(0xFF01875F)),
                            SizedBox(width: 6),
                            Text(
                              'Google Play',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF01875F),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    InkWell(
                      onTap: () => UrlHelper.launchAppStore(proj['appStore'] as String),
                      borderRadius: BorderRadius.circular(6),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.blueAccent.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: Colors.blueAccent.withValues(alpha: 0.3)),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(FontAwesomeIcons.apple, size: 13, color: Colors.blueAccent),
                            SizedBox(width: 6),
                            Text(
                              'App Store',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: Colors.blueAccent,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSkills(bool isDark) {
    final skillCategories = [
      {
        'title': 'Mobile Development',
        'items': 'Flutter, Dart, Android SDK, iOS, Material Design 3, Cupertino, Responsive UI Layouts',
      },
      {
        'title': 'State & Architecture',
        'items': 'Provider, GetX, Clean Architecture Principles, MVC',
      },
      {
        'title': 'Backend & APIs',
        'items': 'REST APIs, Dio Client, JSON, Socket.IO (WebSockets), Firebase (Auth, Firestore, Storage, FCM)',
      },
      {
        'title': 'Integrations & Security',
        'items': 'Cashfree Payment Gateway, Apple IAP, Google Maps API, JWT Authentication, Refresh Tokens, RBAC',
      },
      {
        'title': 'Tools & Languages',
        'items': 'Git, GitHub, Android Studio, VS Code, Xcode, Postman, SQLite, SharedPreferences | Java, Python',
      },
      {
        'title': 'Languages Known',
        'items': 'Tamil (Native), English (Professional Working Proficiency)',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Technical Skills', Icons.code_rounded, isDark),
        const SizedBox(height: 12),
        ...skillCategories.map(
          (sc) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: 12.5,
                  height: 1.5,
                  color: isDark ? AppTheme.textSecondary : AppTheme.lightTextSecondary,
                ),
                children: [
                  TextSpan(
                    text: '${sc['title']}: ',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: isDark ? Colors.white : AppTheme.lightTextPrimary,
                    ),
                  ),
                  TextSpan(text: sc['items']),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEducation(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Education & Professional Training', Icons.school_rounded, isDark),
        const SizedBox(height: 12),
        _buildEduItem(
          degree: 'Bachelor of Science in Chemistry (B.Sc. Chemistry) — Aggregate: 70%',
          institution: 'Government Arts College, Trichy (Bharathidasan University), Tiruchirappalli, TN',
          status: 'Graduated',
          isDark: isDark,
        ),
        const SizedBox(height: 8),
        _buildEduItem(
          degree: 'Full Stack & Mobile Development Training (6 Months)',
          institution: 'RelieTech, Puducherry',
          status: 'Specialized in Flutter & Firebase',
          isDark: isDark,
        ),
        const SizedBox(height: 8),
        _buildEduItem(
          degree: 'Basic Python Certification (3 Months)',
          institution: 'CSC (Common Service Center), Tamil Nadu',
          status: 'Core Programming Fundamentals',
          isDark: isDark,
        ),
      ],
    );
  }

  Widget _buildEduItem({
    required String degree,
    required String institution,
    required String status,
    required bool isDark,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.02)
            : Colors.black.withValues(alpha: 0.02),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.06)
              : Colors.black.withValues(alpha: 0.04),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  degree,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: isDark ? Colors.white : AppTheme.lightTextPrimary,
                  ),
                ),
                Text(
                  institution,
                  style: TextStyle(
                    fontSize: 12,
                    color: isDark ? AppTheme.textSecondary : AppTheme.lightTextSecondary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: AppTheme.accentPurple.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              status,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: AppTheme.accentPurple,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomDownloadCTA(BuildContext context, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isDark
              ? [
                  AppTheme.accentCyan.withValues(alpha: 0.15),
                  AppTheme.accentPurple.withValues(alpha: 0.15),
                ]
              : [
                  AppTheme.accentPurple.withValues(alpha: 0.08),
                  AppTheme.accentCyan.withValues(alpha: 0.08),
                ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark
              ? AppTheme.accentCyan.withValues(alpha: 0.3)
              : AppTheme.accentPurple.withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Need an offline copy for your hiring team?',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: isDark ? Colors.white : AppTheme.lightTextPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Download official 1-page PDF version formatted for ATS & HR review.',
                  style: TextStyle(
                    fontSize: 12,
                    color: isDark ? AppTheme.textSecondary : AppTheme.lightTextSecondary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          ElevatedButton.icon(
            onPressed: () => UrlHelper.downloadResume(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.accentCyan,
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            icon: const Icon(Icons.download_rounded, size: 16),
            label: const Text(
              'Download PDF',
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}
