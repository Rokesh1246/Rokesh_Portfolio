import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool isDark;

  const SectionHeader({
    super.key,
    required this.title,
    required this.subtitle,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: isDark
                ? [AppTheme.accentCyan, AppTheme.accentPurple]
                : [AppTheme.accentPurple, AppTheme.accentCyan],
          ).createShader(bounds),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              letterSpacing: -1,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 16,
            color: isDark ? AppTheme.textSecondary : AppTheme.lightTextSecondary,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          width: 60,
          height: 4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            gradient: LinearGradient(
              colors: isDark
                  ? [AppTheme.accentCyan, AppTheme.accentPurple]
                  : [AppTheme.accentPurple, AppTheme.accentCyan],
            ),
          ),
        ),
      ],
    );
  }
}
