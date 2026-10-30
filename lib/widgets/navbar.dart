import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../main.dart';
import '../utils/url_helper.dart';
import 'resume_modal.dart';

class PortfolioNavbar extends StatefulWidget {
  final List<String> navItems;
  final int activeIndex;
  final void Function(int) onNavTap;

  const PortfolioNavbar({
    super.key,
    required this.navItems,
    required this.activeIndex,
    required this.onNavTap,
  });

  @override
  State<PortfolioNavbar> createState() => _PortfolioNavbarState();
}

class _PortfolioNavbarState extends State<PortfolioNavbar> {
  bool _mobileMenuOpen = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 950;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Navbar Header
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 16 : 40,
            vertical: 12,
          ),
          decoration: BoxDecoration(
            color: isDark
                ? const Color(0xFF0A0E1A).withValues(alpha: 0.9)
                : Colors.white.withValues(alpha: 0.95),
            border: Border(
              bottom: BorderSide(
                color: isDark
                    ? AppTheme.accentCyan.withValues(alpha: 0.15)
                    : AppTheme.accentPurple.withValues(alpha: 0.15),
                width: 1,
              ),
            ),
            boxShadow: [
              BoxShadow(
                color: isDark
                    ? Colors.black.withValues(alpha: 0.35)
                    : Colors.black.withValues(alpha: 0.06),
                blurRadius: 20,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              // Logo
              InkWell(
                onTap: () => widget.onNavTap(0),
                borderRadius: BorderRadius.circular(8),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ShaderMask(
                        shaderCallback: (bounds) => LinearGradient(
                          colors: isDark
                              ? [AppTheme.accentCyan, AppTheme.accentPurple]
                              : [AppTheme.accentPurple, AppTheme.accentCyan],
                        ).createShader(bounds),
                        child: const Text(
                          'ROKESH',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                            letterSpacing: -0.5,
                          ),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppTheme.accentCyan.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color: AppTheme.accentCyan.withValues(alpha: 0.3),
                          ),
                        ),
                        child: const Text(
                          'DEV',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w900,
                            color: AppTheme.accentCyan,
                            letterSpacing: 0.8,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const Spacer(),

              if (!isMobile) ...[
                // Desktop nav items
                ...List.generate(widget.navItems.length, (i) {
                  final isActive = widget.activeIndex == i;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    child: TextButton(
                      onPressed: () => widget.onNavTap(i),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        backgroundColor: isActive
                            ? (isDark
                                ? AppTheme.accentCyan.withValues(alpha: 0.12)
                                : AppTheme.accentPurple.withValues(alpha: 0.12))
                            : Colors.transparent,
                      ),
                      child: Text(
                        widget.navItems[i],
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight:
                              isActive ? FontWeight.w800 : FontWeight.w600,
                          color: isActive
                              ? (isDark
                                  ? AppTheme.accentCyan
                                  : AppTheme.accentPurple)
                              : (isDark
                                  ? AppTheme.textSecondary
                                  : AppTheme.lightTextSecondary),
                          letterSpacing: 0.2,
                        ),
                      ),
                    ),
                  );
                }),
                const SizedBox(width: 8),

                // Resume quick modal button
                ElevatedButton.icon(
                  onPressed: () => ResumeModal.show(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isDark
                        ? AppTheme.accentCyan.withValues(alpha: 0.15)
                        : AppTheme.accentPurple.withValues(alpha: 0.12),
                    foregroundColor:
                        isDark ? AppTheme.accentCyan : AppTheme.accentPurple,
                    side: BorderSide(
                      color: (isDark
                              ? AppTheme.accentCyan
                              : AppTheme.accentPurple)
                          .withValues(alpha: 0.35),
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    elevation: 0,
                  ),
                  icon: const Icon(Icons.description_rounded, size: 14),
                  label: const Text(
                    'Resume',
                    style:
                        TextStyle(fontSize: 12.5, fontWeight: FontWeight.w800),
                  ),
                ),

                const SizedBox(width: 14),
              ],

              // Theme toggle
              GestureDetector(
                onTap: () => RokeshPortfolioApp.of(context)?.toggleTheme(),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: 50,
                  height: 26,
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(13),
                    gradient: LinearGradient(
                      colors: isDark
                          ? [AppTheme.accentPurple, AppTheme.accentCyan]
                          : [
                              AppTheme.accentOrange.withValues(alpha: 0.8),
                              AppTheme.accentOrange
                            ],
                    ),
                  ),
                  child: AnimatedAlign(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.elasticOut,
                    alignment:
                        isDark ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: Icon(
                        isDark ? Icons.nightlight_round : Icons.wb_sunny_rounded,
                        size: 12,
                        color: isDark
                            ? AppTheme.accentPurple
                            : AppTheme.accentOrange,
                      ),
                    ),
                  ),
                ),
              ),

              if (isMobile) ...[
                const SizedBox(width: 8),
                IconButton(
                  icon: Icon(
                    _mobileMenuOpen ? Icons.close_rounded : Icons.menu_rounded,
                    color: isDark ? Colors.white : AppTheme.lightTextPrimary,
                  ),
                  onPressed: () =>
                      setState(() => _mobileMenuOpen = !_mobileMenuOpen),
                ),
              ],
            ],
          ),
        ),

        // Mobile dropdown menu
        if (isMobile && _mobileMenuOpen)
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            color: isDark
                ? const Color(0xFF0F172A).withValues(alpha: 0.98)
                : Colors.white.withValues(alpha: 0.98),
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              children: [
                ...List.generate(widget.navItems.length, (i) {
                  final isActive = widget.activeIndex == i;
                  return ListTile(
                    dense: true,
                    title: Text(
                      widget.navItems[i],
                      style: TextStyle(
                        color: isActive
                            ? (isDark
                                ? AppTheme.accentCyan
                                : AppTheme.accentPurple)
                            : (isDark
                                ? AppTheme.textSecondary
                                : AppTheme.lightTextSecondary),
                        fontWeight:
                            isActive ? FontWeight.w800 : FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    trailing: isActive
                        ? Icon(Icons.chevron_right_rounded,
                            color: isDark
                                ? AppTheme.accentCyan
                                : AppTheme.accentPurple)
                        : null,
                    onTap: () {
                      widget.onNavTap(i);
                      setState(() => _mobileMenuOpen = false);
                    },
                  );
                }),
                const Divider(),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            setState(() => _mobileMenuOpen = false);
                            ResumeModal.show(context);
                          },
                          icon: const Icon(Icons.description_rounded, size: 16),
                          label: const Text('View Resume'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: isDark
                                ? AppTheme.accentCyan
                                : AppTheme.accentPurple,
                            side: BorderSide(
                              color: isDark
                                  ? AppTheme.accentCyan
                                  : AppTheme.accentPurple,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            setState(() => _mobileMenuOpen = false);
                            UrlHelper.downloadResume(context);
                          },
                          icon: const Icon(Icons.download_rounded, size: 16),
                          label: const Text('Download'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.accentCyan,
                            foregroundColor: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
