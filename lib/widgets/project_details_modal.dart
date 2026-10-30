import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../theme/app_theme.dart';
import '../utils/url_helper.dart';

class ProjectDetailsModal extends StatelessWidget {
  final Map<String, dynamic> project;

  const ProjectDetailsModal({super.key, required this.project});

  static void show(BuildContext context, Map<String, dynamic> project) {
    showDialog(
      context: context,
      barrierColor: Colors.black87,
      builder: (context) => ProjectDetailsModal(project: project),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;
    final color = project['color'] as Color? ?? AppTheme.accentCyan;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(
        horizontal: isMobile ? 14 : 40,
        vertical: isMobile ? 20 : 40,
      ),
      child: Container(
        width: 800,
        constraints: BoxConstraints(maxHeight: size.height * 0.9),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF0F172A) : Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: color.withValues(alpha: 0.35),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.15),
              blurRadius: 40,
              offset: const Offset(0, 15),
            ),
          ],
        ),
        child: Column(
          children: [
            // Top Modal Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1E293B) : const Color(0xFFF8FAFC),
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
                      color: color.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: color.withValues(alpha: 0.3)),
                    ),
                    child: Text(
                      'PRODUCTION APP',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        color: color,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(
                      Icons.close_rounded,
                      color: isDark ? Colors.white70 : Colors.black54,
                    ),
                  ),
                ],
              ),
            ),

            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(isMobile ? 20 : 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title and Platform
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                project['title'] as String,
                                style: TextStyle(
                                  fontSize: isMobile ? 22 : 28,
                                  fontWeight: FontWeight.w900,
                                  color: isDark ? Colors.white : AppTheme.lightTextPrimary,
                                  letterSpacing: -0.5,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                project['tagline'] as String? ??
                                    project['description'] as String,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: isDark
                                      ? AppTheme.textSecondary
                                      : AppTheme.lightTextSecondary,
                                  height: 1.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Store Action Badges (Play Store & App Store)
                    Wrap(
                      spacing: 12,
                      runSpacing: 10,
                      children: [
                        _buildStoreButton(
                          title: 'Google Play Store',
                          subtitle: 'Android App',
                          icon: FontAwesomeIcons.googlePlay,
                          color: const Color(0xFF01875F),
                          isDark: isDark,
                          onTap: () => UrlHelper.launchPlayStore(
                            project['playStore'] as String? ??
                                'https://play.google.com/store/apps',
                          ),
                        ),
                        _buildStoreButton(
                          title: 'Apple App Store',
                          subtitle: 'iOS App',
                          icon: FontAwesomeIcons.apple,
                          color: isDark ? Colors.white : Colors.black87,
                          isDark: isDark,
                          onTap: () => UrlHelper.launchAppStore(
                            project['appStore'] as String? ??
                                'https://apps.apple.com',
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Image / graphic preview if available
                    if (project['graphic'] != null) ...[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.asset(
                          project['graphic'] as String,
                          width: double.infinity,
                          height: isMobile ? 180 : 260,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const SizedBox.shrink(),
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],

                    // Architecture & Tech Stack
                    Text(
                      'TECH STACK & ARCHITECTURE',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.1,
                        color: isDark ? Colors.white70 : AppTheme.lightTextPrimary,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: (project['tags'] as List<String>)
                          .map((tag) => Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: color.withValues(alpha: 0.12),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: color.withValues(alpha: 0.3),
                                  ),
                                ),
                                child: Text(
                                  tag,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: color,
                                  ),
                                ),
                              ))
                          .toList(),
                    ),

                    const SizedBox(height: 24),

                    // Key Engineering Accomplishments
                    Text(
                      'KEY ENGINEERING HIGHLIGHTS',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.1,
                        color: isDark ? Colors.white70 : AppTheme.lightTextPrimary,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ...((project['bullets'] as List<String>? ?? [])).map(
                      (bullet) => Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 4, right: 10),
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: color,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                bullet,
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

                    const SizedBox(height: 20),

                    // Platform & Performance Notice
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isDark
                            ? Colors.white.withValues(alpha: 0.04)
                            : Colors.black.withValues(alpha: 0.03),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isDark
                              ? Colors.white.withValues(alpha: 0.08)
                              : Colors.black.withValues(alpha: 0.06),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.speed_rounded,
                              size: 22, color: AppTheme.accentGreen),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'Optimized for 60 FPS fluid rendering across Android (Gradle) and iOS (CocoaPods/Xcode), adhering to Material 3 & Apple HIG.',
                              style: TextStyle(
                                fontSize: 12,
                                color: isDark
                                    ? AppTheme.textSecondary
                                    : AppTheme.lightTextSecondary,
                              ),
                            ),
                          ),
                        ],
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

  Widget _buildStoreButton({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required bool isDark,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isDark
              ? Colors.white.withValues(alpha: 0.06)
              : Colors.black.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isDark
                ? Colors.white.withValues(alpha: 0.15)
                : Colors.black.withValues(alpha: 0.12),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 20, color: color),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  subtitle.toUpperCase(),
                  style: TextStyle(
                    fontSize: 9.5,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.8,
                    color: isDark ? Colors.white60 : Colors.black45,
                  ),
                ),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: isDark ? Colors.white : AppTheme.lightTextPrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 8),
            Icon(
              Icons.arrow_outward_rounded,
              size: 14,
              color: isDark ? Colors.white54 : Colors.black45,
            ),
          ],
        ),
      ),
    );
  }
}
