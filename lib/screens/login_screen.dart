import 'package:flutter/material.dart';
import '../routes/app_routes.dart';

/// Login Screen
///
/// Demonstrates Phase 1 & Phase 2 Complete Components:
/// - Form validation state tracking
/// - Dropdown selection components 
/// - High-fidelity Instagram UI components with a custom multi-stop gradient logo
/// - Unified global layout system adapting cleanly to web/desktop monitors
/// - String parsers passing parameters contextually during layout swaps
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;
  String _selectedLanguage = 'English (US)';

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email or username is required';
    }
    if (!value.contains('@') && value.trim().length < 3) {
      return 'Enter a valid username or email';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  void _handleLogin() {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    // Simulated network delay context wrapper
    Future.delayed(const Duration(milliseconds: 900), () {
      if (!mounted) return;
      setState(() => _isLoading = false);

      final rawInput = _emailController.text.trim();
      final displayName = rawInput.contains('@') ? rawInput.split('@').first : rawInput;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Welcome back, $displayName! ✨'),
          backgroundColor: const Color(0xFF262626),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );

      // Phase 2: Route switch navigation matching global constants configuration
      Navigator.of(context).pushReplacementNamed(AppRoutes.home);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Instagram pure black style 
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Container(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Language Dropdown Selection Component
                    Center(
                      child: DropdownButton<String>(
                        value: _selectedLanguage,
                        dropdownColor: const Color(0xFF121212),
                        icon: const Icon(Icons.keyboard_arrow_down, size: 16, color: Colors.grey),
                        underline: const SizedBox(),
                        style: const TextStyle(color: Colors.grey, fontSize: 13),
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            setState(() => _selectedLanguage = newValue);
                          }
                        },
                        items: <String>['English (US)', 'Español', 'Français', 'Urdu']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 50),

                    // Phase 1 Component: Authentic High-Fidelity Instagram Gradient Logo
                    Center(
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFF405DE6), // Royal Blue base
                              Color(0xFF5851DB), // Purple-Blue
                              Color(0xFF833AB4), // Deep Purple
                              Color(0xFFC13584), // Magenta
                              Color(0xFFE1306C), // Deep Pink
                              Color(0xFFFD1D1D), // Vibrant Red
                              Color(0xFFF56040), // Dark Orange
                              Color(0xFFF77737), // Light Orange
                              Color(0xFFFCAF45), // Soft Yellow
                            ],
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                          ),
                        ),
                        child: Center(
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(18),
                              border: Border.all(color: Colors.white, width: 4.5), // Camera body outline
                            ),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                // Camera Lens Element
                                Container(
                                  width: 26,
                                  height: 26,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(color: Colors.white, width: 4.5),
                                  ),
                                ),
                                // Flash Dot Indicator element
                                Positioned(
                                  top: 5,
                                  right: 5,
                                  child: Container(
                                    width: 6.5,
                                    height: 6.5,
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Typography Header Component - Adjusted to fall back beautifully without custom typography packs
                    const Text(
                      'Instagram',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -1.0,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 40),

                    // Email / Username Input Field Layout
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                      decoration: InputDecoration(
                        hintText: 'Phone number, username, or email',
                        hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
                        filled: true,
                        fillColor: const Color(0xFF121212),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Color(0xFF262626), width: 1),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey, width: 1),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.redAccent, width: 1),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.redAccent, width: 1),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      validator: _validateEmail,
                    ),
                    const SizedBox(height: 14),

                    // Password Input Field Layout
                    TextFormField(
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                      decoration: InputDecoration(
                        hintText: 'Password',
                        hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
                        filled: true,
                        fillColor: const Color(0xFF121212),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Color(0xFF262626), width: 1),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey, width: 1),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.redAccent, width: 1),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.redAccent, width: 1),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: Colors.grey,
                            size: 20,
                          ),
                          onPressed: () {
                            setState(() => _obscurePassword = !_obscurePassword);
                          },
                        ),
                      ),
                      validator: _validatePassword,
                    ),
                    const SizedBox(height: 20),

                    // Instagram Signature Blue Action Submissions Button
                    ElevatedButton(
                      onPressed: _isLoading ? null : _handleLogin,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0095F6), 
                        disabledBackgroundColor: const Color(0xFF004C83),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
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
                              'Log In',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                    ),
                    const SizedBox(height: 24),

                    // Stylized Content Separator Grid Row
                    Row(
                      children: [
                        Expanded(child: Container(color: const Color(0xFF262626), height: 1)),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Text('OR', style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold)),
                        ),
                        Expanded(child: Container(color: const Color(0xFF262626), height: 1)),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Alternative Login Access Links Matrix
                    TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.facebook, color: Color(0xFF1877F2), size: 20),
                      label: const Text(
                        'Log in with Facebook',
                        style: TextStyle(color: Color(0xFF1877F2), fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    Center(
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Forgot password?',
                          style: TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    Divider(color: Colors.grey[900], thickness: 1),
                    const SizedBox(height: 16),

                    // Phase 2 Target Redirect Link to Registration configured with explicit constants path mappings
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account? ",
                          style: TextStyle(color: Colors.grey, fontSize: 13),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed(AppRoutes.register);
                          },
                          child: const Text(
                            'Sign up.',
                            style: TextStyle(
                              color: Color(0xFF0095F6),
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
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
      ),
    );
  }
}