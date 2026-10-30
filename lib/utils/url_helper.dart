import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlHelper {
  static const String phone = '+919943719312';
  static const String phoneDisplay = '+91 9943719312';
  static const String email = 'roga719@gmail.com';
  static const String linkedinUrl = 'https://www.linkedin.com/in/rokesh-g-878868255';
  static const String githubUrl = 'https://github.com/rokesh-g';
  static const String resumePdfPath = 'rokesh_resume.pdf';
  static const String resumeAssetPath = 'assets/resume/rokesh_resume.pdf';

  /// Open external URL safely in new tab or external app
  static Future<bool> launchExternal(String url) async {
    try {
      final uri = Uri.parse(url);
      return await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
    } catch (e) {
      debugPrint('Error launching URL ($url): $e');
      try {
        final uri = Uri.parse(url);
        return await launchUrl(uri, mode: LaunchMode.platformDefault);
      } catch (e2) {
        debugPrint('Fallback error launching URL: $e2');
        return false;
      }
    }
  }

  /// Launch phone dialer
  static Future<void> launchPhoneDialer([String? number]) async {
    final num = number ?? phone;
    final cleanNumber = num.replaceAll(' ', '');
    final uri = Uri(scheme: 'tel', path: cleanNumber);
    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      debugPrint('Error launching phone: $e');
      await launchUrl(uri);
    }
  }

  /// Launch email client with prefilled subject and body
  static Future<void> launchEmailClient({
    String? to,
    String subject = 'Opportunity / Project Discussion - Rokesh Govindaraj',
    String? body,
  }) async {
    final recipient = to ?? email;
    final defaultBody = body ??
        'Hi Rokesh,\n\nI reviewed your Flutter developer portfolio and would love to discuss an opportunity.\n\nBest regards,';
    
    final uri = Uri(
      scheme: 'mailto',
      path: recipient,
      queryParameters: {
        'subject': subject,
        'body': defaultBody,
      },
    );

    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      debugPrint('Error launching email: $e');
      await launchUrl(uri);
    }
  }

  /// Launch WhatsApp directly with prefilled message
  static Future<void> launchWhatsAppChat({
    String? number,
    String message = 'Hi Rokesh, I came across your Flutter developer portfolio!',
  }) async {
    final num = (number ?? phone).replaceAll('+', '').replaceAll(' ', '');
    final encodedMsg = Uri.encodeComponent(message);
    final url = 'https://wa.me/$num?text=$encodedMsg';
    await launchExternal(url);
  }

  /// Launch Google Play Store app or webpage
  static Future<void> launchPlayStore(String appIdOrUrl) async {
    if (appIdOrUrl.startsWith('http')) {
      await launchExternal(appIdOrUrl);
    } else {
      final webUrl = 'https://play.google.com/store/apps/details?id=$appIdOrUrl';
      await launchExternal(webUrl);
    }
  }

  /// Launch Apple App Store app or webpage
  static Future<void> launchAppStore(String appUrl) async {
    await launchExternal(appUrl);
  }

  /// Download Resume PDF
  static Future<void> downloadResume(BuildContext context) async {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Icons.downloading_rounded, color: Colors.white, size: 20),
            SizedBox(width: 12),
            Text(
              'Opening Rokesh\'s Resume...',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF00D4FF),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: const Duration(seconds: 3),
      ),
    );

    // If on web, we open the direct PDF route
    if (kIsWeb) {
      await launchUrl(
        Uri.parse(resumePdfPath),
        mode: LaunchMode.externalApplication,
      );
    } else {
      await launchUrl(
        Uri.parse(resumePdfPath),
        mode: LaunchMode.externalApplication,
      );
    }
  }

  /// Copy text to clipboard and show toast
  static Future<void> copy(BuildContext context, String text, String label) async {
    await Clipboard.setData(ClipboardData(text: text));
    if (context.mounted) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.check_circle_rounded, color: Color(0xFF10B981), size: 20),
              const SizedBox(width: 12),
              Text(
                '$label copied to clipboard!',
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ],
          ),
          backgroundColor: const Color(0xFF1F2937),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }
}
