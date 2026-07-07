import 'package:flutter/material.dart';

/// Settings Screen
///
/// Production-Ready High-Fidelity UI Architecture:
/// - Custom Pixel-Precise Adaptive Dialog Overlays
/// - Theme-Reactive Component Configurations
/// - Native Device Navigation Properties
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _darkMode = true;
  bool _privateAccount = false;

  Future<void> _confirmLogout(
    Color bg, 
    Color primaryTxt, 
    Color secondaryTxt, 
    Color borderLine
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      barrierColor: Colors.black.withAlpha(140),
      builder: (context) => AlertDialog(
        backgroundColor: bg,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        titlePadding: const EdgeInsets.only(top: 22, left: 24, right: 24),
        contentPadding: const EdgeInsets.fromLTRB(24, 12, 24, 20),
        actionsPadding: EdgeInsets.zero,
        title: Text(
          'Log Out?',
          textAlign: TextAlign.center,
          style: TextStyle(color: primaryTxt, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        content: Text(
          'Are you sure you want to log out of your account?',
          textAlign: TextAlign.center,
          style: TextStyle(color: secondaryTxt, fontSize: 14),
        ),
        actions: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Divider(color: borderLine, height: 1),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: const Text(
                  'Log Out',
                  style: TextStyle(color: Color(0xFFED4956), fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
              Divider(color: borderLine, height: 1),
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  'Cancel',
                  style: TextStyle(color: primaryTxt, fontSize: 14),
                ),
              ),
            ],
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      Navigator.of(context).popUntil((route) => route.isFirst);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryTextColor = isDark ? Colors.white : Colors.black;
    final secondaryTextColor = isDark ? const Color(0xFF8E8E8E) : const Color(0xFF737373);
    final scaffoldBg = isDark ? Colors.black : Colors.white;
    final dialogBg = isDark ? const Color(0xFF262626) : Colors.white;
    final borderColor = isDark ? const Color(0xFF1A1A1A) : const Color(0xFFDBDBDB);
    final dialogBorderColor = isDark ? const Color(0xFF363636) : const Color(0xFFEFEFEF);
    final chevronColor = isDark ? const Color(0xFF555555) : const Color(0xFFCECECE);

    return Scaffold(
      backgroundColor: scaffoldBg,
      appBar: AppBar(
        backgroundColor: scaffoldBg,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: primaryTextColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Settings and privacy',
          style: TextStyle(
            color: primaryTextColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            letterSpacing: -0.3,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0.5),
          child: Container(color: borderColor, height: 0.5),
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          _buildSectionHeader('How you use InstaClone', secondaryTextColor),
          
          _buildSwitchTile(
            icon: Icons.notifications_outlined,
            title: 'Notifications',
            value: _notificationsEnabled,
            primaryColor: primaryTextColor,
            onChanged: (val) => setState(() => _notificationsEnabled = val),
          ),
          
          _buildSwitchTile(
            icon: Icons.dark_mode_outlined,
            title: 'Dark Mode',
            value: _darkMode,
            primaryColor: primaryTextColor,
            onChanged: (val) => setState(() => _darkMode = val),
          ),

          _buildSwitchTile(
            icon: Icons.lock_outline,
            title: 'Account Privacy',
            value: _privateAccount,
            primaryColor: primaryTextColor,
            onChanged: (val) => setState(() => _privateAccount = val),
          ),
          
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Divider(color: borderColor, height: 0.5),
          ),
          
          _buildSectionHeader('Your Account & Support', secondaryTextColor),
          
          _buildNavigationTile(Icons.person_outline, 'Edit Profile', primaryTextColor, chevronColor, () {}),
          _buildNavigationTile(Icons.security_outlined, 'Security & Passwords', primaryTextColor, chevronColor, () {}),
          _buildNavigationTile(Icons.help_outline, 'Help Center', primaryTextColor, chevronColor, () {}),
          
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Divider(color: borderColor, height: 0.5),
          ),
          
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
            leading: const Icon(Icons.logout, color: Color(0xFFED4956), size: 22),
            title: const Text(
              'Log Out', 
              style: TextStyle(color: Color(0xFFED4956), fontSize: 15, fontWeight: FontWeight.w600),
            ),
            onTap: () => _confirmLogout(dialogBg, primaryTextColor, secondaryTextColor, dialogBorderColor),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, Color textColor) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 10),
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w600, 
          color: textColor, 
          fontSize: 12.5,
          letterSpacing: 0.2,
        ),
      ),
    );
  }

  Widget _buildSwitchTile({
    required IconData icon,
    required String title,
    required bool value,
    required Color primaryColor,
    required ValueChanged<bool> onChanged,
  }) {
    return SwitchListTile.adaptive(
      secondary: Icon(icon, color: primaryColor, size: 22),
      title: Text(
        title, 
        style: TextStyle(color: primaryColor, fontSize: 15, fontWeight: FontWeight.w500),
      ),
      activeColor: const Color(0xFF0095F6),
      activeTrackColor: const Color(0xFF0095F6).withAlpha(45),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      value: value,
      onChanged: onChanged,
    );
  }

  Widget _buildNavigationTile(
    IconData icon, 
    String title, 
    Color primaryColor, 
    Color chevronColor, 
    VoidCallback onTap
  ) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 1),
      leading: Icon(icon, color: primaryColor, size: 22),
      title: Text(
        title, 
        style: TextStyle(color: primaryColor, fontSize: 15, fontWeight: FontWeight.w500),
      ),
      trailing: Icon(Icons.chevron_right, color: chevronColor, size: 20),
      onTap: onTap,
    );
  }
}