import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../theme/app_theme.dart';
import '../../utils/url_helper.dart';
import '../../widgets/resume_modal.dart';
import '../../widgets/section_header.dart';

class ContactSection extends StatefulWidget {
  final VoidCallback? onScrollToTop;

  const ContactSection({super.key, this.onScrollToTop});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();
  bool _isSending = false;
  bool _sent = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _handleSubmit() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() => _isSending = true);
      
      final name = _nameController.text.trim();
      final subject = _subjectController.text.trim().isNotEmpty
          ? _subjectController.text.trim()
          : 'Inquiry from $name via Portfolio';
      final message = 'From: $name (${_emailController.text.trim()})\n\n${_messageController.text.trim()}';

      // Launch email client with prefilled details
      await UrlHelper.launchEmailClient(
        subject: subject,
        body: message,
      );

      setState(() {
        _isSending = false;
        _sent = true;
      });

      _nameController.clear();
      _emailController.clear();
      _subjectController.clear();
      _messageController.clear();

      await Future.delayed(const Duration(seconds: 4));
      if (mounted) setState(() => _sent = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 850;
    final isSmallMobile = screenWidth < 400;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? (isSmallMobile ? 16 : 24) : 80,
        vertical: 70,
      ),
      child: Column(
        children: [
          SectionHeader(
            title: 'Get In Touch',
            subtitle: 'Ready to build something exceptional together?',
            isDark: isDark,
          ),
          const SizedBox(height: 50),
          isMobile
              ? Column(
                  children: [
                    _buildContactInfo(isDark, true),
                    const SizedBox(height: 36),
                    _buildContactForm(isDark, true),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 4,
                      child: _buildContactInfo(isDark, false),
                    ),
                    const SizedBox(width: 48),
                    Expanded(
                      flex: 5,
                      child: _buildContactForm(isDark, false),
                    ),
                  ],
                ),
          const SizedBox(height: 80),
          _buildFooter(context, isDark, isMobile),
        ],
      ),
    );
  }

  Widget _buildContactInfo(bool isDark, bool isMobile) {
    return FadeInLeft(
      duration: const Duration(milliseconds: 600),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: AppTheme.accentGreen.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: AppTheme.accentGreen.withValues(alpha: 0.3),
              ),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.bolt_rounded, color: AppTheme.accentGreen, size: 14),
                SizedBox(width: 6),
                Text(
                  'OPEN FOR OPPORTUNITIES',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    color: AppTheme.accentGreen,
                    letterSpacing: 0.8,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Let\'s Connect & Build Scalable Mobile Apps',
            style: TextStyle(
              fontSize: isMobile ? 22 : 28,
              fontWeight: FontWeight.w800,
              color: isDark ? Colors.white : AppTheme.lightTextPrimary,
              height: 1.25,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            'Whether you have an immediate full-time engineering opening, a mobile app project, or want to discuss Flutter architecture, my inbox and phone are always open.',
            style: TextStyle(
              fontSize: 14.5,
              color: isDark ? AppTheme.textSecondary : AppTheme.lightTextSecondary,
              height: 1.65,
            ),
          ),
          const SizedBox(height: 28),

          // Contact Cards
          _buildContactCard(
            icon: Icons.phone_in_talk_rounded,
            title: 'Phone / Direct Call',
            value: UrlHelper.phoneDisplay,
            actionLabel: 'Call Now',
            color: AppTheme.accentGreen,
            isDark: isDark,
            onTap: () => UrlHelper.launchPhoneDialer(),
            onCopy: () => UrlHelper.copy(context, UrlHelper.phone, 'Phone number'),
          ),
          const SizedBox(height: 14),

          _buildContactCard(
            icon: Icons.mail_rounded,
            title: 'Email Address',
            value: UrlHelper.email,
            actionLabel: 'Send Email',
            color: AppTheme.accentCyan,
            isDark: isDark,
            onTap: () => UrlHelper.launchEmailClient(),
            onCopy: () => UrlHelper.copy(context, UrlHelper.email, 'Email address'),
          ),
          const SizedBox(height: 14),

          _buildContactCard(
            icon: FontAwesomeIcons.whatsapp,
            title: 'WhatsApp Chat',
            value: UrlHelper.phoneDisplay,
            actionLabel: 'Chat on WhatsApp',
            color: const Color(0xFF25D366),
            isDark: isDark,
            onTap: () => UrlHelper.launchWhatsAppChat(),
            onCopy: () => UrlHelper.copy(context, UrlHelper.phone, 'WhatsApp number'),
          ),
          const SizedBox(height: 14),

          _buildContactCard(
            icon: FontAwesomeIcons.linkedin,
            title: 'LinkedIn Profile',
            value: 'rokesh-g-878868255',
            actionLabel: 'View LinkedIn',
            color: const Color(0xFF0A66C2),
            isDark: isDark,
            onTap: () => UrlHelper.launchExternal(UrlHelper.linkedinUrl),
          ),
        ],
      ),
    );
  }

  Widget _buildContactCard({
    required IconData icon,
    required String title,
    required String value,
    required String actionLabel,
    required Color color,
    required bool isDark,
    required VoidCallback onTap,
    VoidCallback? onCopy,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      decoration: BoxDecoration(
        color: isDark ? AppTheme.cardDark : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.25)),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.06),
            blurRadius: 18,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: isDark ? AppTheme.textSecondary : AppTheme.lightTextSecondary,
                  ),
                ),
                const SizedBox(height: 2),
                InkWell(
                  onTap: onTap,
                  child: Text(
                    value,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: isDark ? Colors.white : AppTheme.lightTextPrimary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (onCopy != null)
            IconButton(
              icon: Icon(Icons.copy_rounded,
                  size: 16,
                  color: isDark ? AppTheme.textSecondary : AppTheme.lightTextSecondary),
              tooltip: 'Copy',
              onPressed: onCopy,
            ),
          ElevatedButton(
            onPressed: onTap,
            style: ElevatedButton.styleFrom(
              backgroundColor: color.withValues(alpha: 0.15),
              foregroundColor: color,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: Text(
              actionLabel,
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w800),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactForm(bool isDark, bool isMobile) {
    return FadeInRight(
      duration: const Duration(milliseconds: 600),
      child: Container(
        padding: EdgeInsets.all(isMobile ? 22 : 32),
        decoration: BoxDecoration(
          color: isDark ? AppTheme.cardDark : Colors.white,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: isDark
                ? Colors.white.withValues(alpha: 0.1)
                : Colors.black.withValues(alpha: 0.08),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 25,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Send a Message',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: isDark ? Colors.white : AppTheme.lightTextPrimary,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Submitting triggers your native email client with pre-filled parameters.',
                style: TextStyle(
                  fontSize: 12.5,
                  color: isDark ? AppTheme.textSecondary : AppTheme.lightTextSecondary,
                ),
              ),
              const SizedBox(height: 24),

              // Name
              _buildTextField(
                controller: _nameController,
                label: 'Your Name',
                hint: 'e.g. Alex Johnson',
                icon: Icons.person_outline_rounded,
                isDark: isDark,
                validator: (val) => val == null || val.trim().isEmpty
                    ? 'Please enter your name'
                    : null,
              ),
              const SizedBox(height: 18),

              // Email
              _buildTextField(
                controller: _emailController,
                label: 'Your Email',
                hint: 'e.g. alex@company.com',
                icon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
                isDark: isDark,
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!val.contains('@') || !val.contains('.')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 18),

              // Subject
              _buildTextField(
                controller: _subjectController,
                label: 'Subject',
                hint: 'e.g. Flutter Developer Role / Project Proposal',
                icon: Icons.subject_rounded,
                isDark: isDark,
              ),
              const SizedBox(height: 18),

              // Message
              _buildTextField(
                controller: _messageController,
                label: 'Message',
                hint: 'Tell me about your team, tech stack, or project requirements...',
                icon: Icons.chat_bubble_outline_rounded,
                maxLines: 4,
                isDark: isDark,
                validator: (val) => val == null || val.trim().isEmpty
                    ? 'Please write a message'
                    : null,
              ),
              const SizedBox(height: 24),

              // Submit Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: LinearGradient(
                      colors: isDark
                          ? [AppTheme.accentCyan, AppTheme.accentPurple]
                          : [AppTheme.accentPurple, AppTheme.accentCyan],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: (isDark
                                ? AppTheme.accentCyan
                                : AppTheme.accentPurple)
                            .withValues(alpha: 0.35),
                        blurRadius: 18,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: _isSending ? null : _handleSubmit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: _isSending
                        ? const SizedBox(
                            width: 22,
                            height: 22,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                              color: Colors.white,
                            ),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                _sent ? Icons.check_circle_rounded : Icons.send_rounded,
                                color: Colors.white,
                                size: 18,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                _sent ? 'Message Sent!' : 'Send Message',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 14,
                                  letterSpacing: 0.3,
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    required bool isDark,
    int maxLines = 1,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12.5,
            fontWeight: FontWeight.w700,
            color: isDark ? Colors.white70 : AppTheme.lightTextPrimary,
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          validator: validator,
          style: TextStyle(
            color: isDark ? Colors.white : AppTheme.lightTextPrimary,
            fontSize: 14,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: isDark ? Colors.white30 : Colors.black26,
              fontSize: 13,
            ),
            prefixIcon: Icon(icon,
                size: 18,
                color: (isDark ? AppTheme.accentCyan : AppTheme.accentPurple)
                    .withValues(alpha: 0.7)),
            filled: true,
            fillColor: isDark
                ? Colors.white.withValues(alpha: 0.04)
                : Colors.black.withValues(alpha: 0.03),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.12)
                    : Colors.black.withValues(alpha: 0.1),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.12)
                    : Colors.black.withValues(alpha: 0.1),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: isDark ? AppTheme.accentCyan : AppTheme.accentPurple,
                width: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFooter(BuildContext context, bool isDark, bool isMobile) {
    return Column(
      children: [
        Divider(
          color: isDark
              ? Colors.white.withValues(alpha: 0.1)
              : Colors.black.withValues(alpha: 0.08),
        ),
        const SizedBox(height: 30),
        isMobile
            ? Column(
                children: [
                  _buildFooterBrand(isDark),
                  const SizedBox(height: 20),
                  _buildFooterResumeButton(context, isDark),
                  const SizedBox(height: 20),
                  _buildFooterCopyright(isDark),
                ],
              )
            : Row(
                children: [
                  _buildFooterBrand(isDark),
                  const Spacer(),
                  _buildFooterResumeButton(context, isDark),
                  const SizedBox(width: 24),
                  _buildFooterCopyright(isDark),
                ],
              ),
      ],
    );
  }

  Widget _buildFooterBrand(bool isDark) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: isDark
                ? [AppTheme.accentCyan, AppTheme.accentPurple]
                : [AppTheme.accentPurple, AppTheme.accentCyan],
          ).createShader(bounds),
          child: const Text(
            'ROKESH GOVINDARAJ',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              letterSpacing: 0.8,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: AppTheme.accentCyan.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(4),
          ),
          child: const Text(
            'FLUTTER DEV',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w800,
              color: AppTheme.accentCyan,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFooterResumeButton(BuildContext context, bool isDark) {
    return Wrap(
      spacing: 10,
      children: [
        OutlinedButton.icon(
          onPressed: () => ResumeModal.show(context),
          style: OutlinedButton.styleFrom(
            foregroundColor: isDark ? Colors.white : AppTheme.lightTextPrimary,
            side: BorderSide(
              color: (isDark ? AppTheme.accentCyan : AppTheme.accentPurple)
                  .withValues(alpha: 0.4),
            ),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          ),
          icon: const Icon(Icons.description_rounded, size: 14),
          label: const Text('View CV', style: TextStyle(fontSize: 12)),
        ),
        ElevatedButton.icon(
          onPressed: () => UrlHelper.downloadResume(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.accentCyan,
            foregroundColor: Colors.black,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            elevation: 0,
          ),
          icon: const Icon(Icons.download_rounded, size: 14),
          label: const Text('Download PDF',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800)),
        ),
      ],
    );
  }

  Widget _buildFooterCopyright(bool isDark) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '© 2026 Rokesh Govindaraj. Built with Flutter Web.',
          style: TextStyle(
            fontSize: 12,
            color: isDark ? AppTheme.textSecondary : AppTheme.lightTextSecondary,
          ),
        ),
        const SizedBox(width: 12),
        if (widget.onScrollToTop != null)
          IconButton(
            icon: const Icon(Icons.arrow_upward_rounded, size: 18),
            tooltip: 'Back to Top',
            onPressed: widget.onScrollToTop,
          ),
      ],
    );
  }
}
