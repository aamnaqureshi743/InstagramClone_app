import 'package:flutter/material.dart';

/// Registration Screen
///
/// Production-Ready High-Fidelity UI Architecture:
/// - Reactive Form Validation Contexts
/// - Dynamic Light/Dark Theme Material Design Compliance
/// - High-Fidelity Password Visibility Actions
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  
  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  String? _validateUsername(String? value) {
    if (value == null || value.trim().isEmpty) return 'Username is required';
    if (value.trim().length < 3) return 'Username must be at least 3 characters';
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) return 'Email is required';
    final emailRegex = RegExp(r'^[\w.+-]+@[\w-]+\.[\w.-]+$');
    if (!emailRegex.hasMatch(value.trim())) return 'Enter a valid email address';
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Password is required';
    if (value.length < 6) return 'Password must be at least 6 characters';
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value != _passwordController.text) return 'Passwords do not match';
    return null;
  }

  void _handleRegister(Color snackBg, Color snackTxt) {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    Future.delayed(const Duration(milliseconds: 800), () {
      if (!mounted) return;
      setState(() => _isLoading = false);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Account created for @${_usernameController.text.trim()}!',
            style: TextStyle(color: snackTxt, fontWeight: FontWeight.w500),
          ),
          backgroundColor: const Color(0xFF0095F6),
          behavior: SnackBarBehavior.floating,
        ),
      );

      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryTextColor = isDark ? Colors.white : Colors.black;
    final secondaryTextColor = isDark ? const Color(0xFF737373) : const Color(0xFF737373);
    final scaffoldBg = isDark ? Colors.black : Colors.white;
    final formFieldBg = isDark ? const Color(0xFF121212) : const Color(0xFFFAFAFA);
    final innerBorderColor = isDark ? const Color(0xFF262626) : const Color(0xFFDBDBDB);
    final activeBorderColor = isDark ? const Color(0xFF555555) : const Color(0xFFA8A8A8);

    return Scaffold(
      backgroundColor: scaffoldBg,
      appBar: AppBar(
        backgroundColor: scaffoldBg,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: primaryTextColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Text(
                      'Instagram',
                      style: TextStyle(
                        fontSize: 38,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -1.2,
                        color: primaryTextColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Username Form Field
                  TextFormField(
                    controller: _usernameController,
                    style: TextStyle(color: primaryTextColor, fontSize: 14),
                    textInputAction: TextInputAction.next,
                    decoration: _buildInputDecoration(
                      hint: 'Username',
                      prefixIcon: Icons.person_outline,
                      bgColor: formFieldBg,
                      hintColor: secondaryTextColor,
                      enabledBorderColor: innerBorderColor,
                      focusedBorderColor: activeBorderColor,
                    ),
                    validator: _validateUsername,
                  ),
                  const SizedBox(height: 12),

                  // Email Form Field
                  TextFormField(
                    controller: _emailController,
                    style: TextStyle(color: primaryTextColor, fontSize: 14),
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    decoration: _buildInputDecoration(
                      hint: 'Email',
                      prefixIcon: Icons.email_outlined,
                      bgColor: formFieldBg,
                      hintColor: secondaryTextColor,
                      enabledBorderColor: innerBorderColor,
                      focusedBorderColor: activeBorderColor,
                    ),
                    validator: _validateEmail,
                  ),
                  const SizedBox(height: 12),

                  // Password Form Field
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    style: TextStyle(color: primaryTextColor, fontSize: 14),
                    textInputAction: TextInputAction.next,
                    decoration: _buildInputDecoration(
                      hint: 'Password',
                      prefixIcon: Icons.lock_outline,
                      bgColor: formFieldBg,
                      hintColor: secondaryTextColor,
                      enabledBorderColor: innerBorderColor,
                      focusedBorderColor: activeBorderColor,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                          color: secondaryTextColor,
                          size: 18,
                        ),
                        onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                      ),
                    ),
                    validator: _validatePassword,
                  ),
                  const SizedBox(height: 12),

                  // Confirm Password Form Field
                  TextFormField(
                    controller: _confirmPasswordController,
                    obscureText: _obscureConfirmPassword,
                    style: TextStyle(color: primaryTextColor, fontSize: 14),
                    textInputAction: TextInputAction.done,
                    decoration: _buildInputDecoration(
                      hint: 'Confirm Password',
                      prefixIcon: Icons.lock_outline,
                      bgColor: formFieldBg,
                      hintColor: secondaryTextColor,
                      enabledBorderColor: innerBorderColor,
                      focusedBorderColor: activeBorderColor,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureConfirmPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                          color: secondaryTextColor,
                          size: 18,
                        ),
                        onPressed: () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
                      ),
                    ),
                    onFieldSubmitted: (_) => _handleRegister(Colors.white, Colors.black),
                    validator: _validateConfirmPassword,
                  ),
                  const SizedBox(height: 16),

                  // Action Button
                  ElevatedButton(
                    onPressed: _isLoading ? null : () => _handleRegister(Colors.white, Colors.black),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0095F6),
                      disabledBackgroundColor: const Color(0xFF0095F6).withOpacity(0.4),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            height: 18,
                            width: 18,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Text(
                            'Sign Up',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                  const SizedBox(height: 24),
                  
                  // Bottom Footer Quick Links
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account? ',
                        style: TextStyle(color: secondaryTextColor, fontSize: 13),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: const Text(
                          'Log In.',
                          style: TextStyle(
                            color: Color(0xFF0095F6), 
                            fontSize: 13, 
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration({
    required String hint, 
    required IconData prefixIcon,
    required Color bgColor,
    required Color hintColor,
    required Color enabledBorderColor,
    required Color focusedBorderColor,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: hintColor, fontSize: 14),
      prefixIcon: Icon(prefixIcon, color: hintColor, size: 20),
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: bgColor,
      contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
      errorStyle: const TextStyle(color: Colors.redAccent, fontSize: 12),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: focusedBorderColor, width: 0.5),
        borderRadius: BorderRadius.circular(8),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: enabledBorderColor, width: 0.3),
        borderRadius: BorderRadius.circular(8),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.redAccent, width: 0.5),
        borderRadius: BorderRadius.circular(8),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.redAccent, width: 0.5),
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}