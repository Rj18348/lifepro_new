import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifepro_new/presentation/providers/providers.dart';
import 'package:lifepro_new/presentation/home/home_screen.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen>
    with SingleTickerProviderStateMixin {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final fullNameController = TextEditingController();

  bool isLoading = false;
  bool isSignUp = false;

  late AnimationController animationController;
  late Animation<double> fadeAnimation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInOut,
    ));

    // Pre-fill with demo credentials for easy testing
    emailController.text = 'abcd@gmail.com';
    passwordController.text = '123456789';
    fullNameController.text = 'Demo User';

    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    emailController.dispose();
    passwordController.dispose();
    fullNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              colorScheme.primaryContainer,
              colorScheme.secondaryContainer,
              colorScheme.surface,
            ],
          ),
        ),
        child: FadeTransition(
          opacity: fadeAnimation,
          child: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Logo and App Name
                    Center(
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: colorScheme.surface.withValues(alpha: 0.9),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: colorScheme.shadow.withValues(alpha: 0.2),
                                  blurRadius: 20,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.self_improvement,
                              size: 48,
                              color: colorScheme.primary,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'LifeBalance AI',
                            style: textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: colorScheme.onSurface,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 48),

                    // Welcome Text
                    Text(
                      isSignUp ? 'Create Account' : 'Welcome Back',
                      style: textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      isSignUp
                          ? 'Join us to start your wellness journey'
                          : 'Sign in to continue your wellness journey',
                      style: textTheme.bodyLarge?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Full Name Field (only for sign up)
                    if (isSignUp) ...[
                      _buildTextField(
                        controller: fullNameController,
                        label: 'Full Name',
                        hint: 'Enter your full name',
                        icon: Icons.person,
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'Please enter your full name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                    ],

                    // Email Field
                    _buildTextField(
                      controller: emailController,
                      label: 'Email',
                      hint: 'Enter your email',
                      icon: Icons.email,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter your email';
                        }
                        final emailRegex =
                            RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                        if (!emailRegex.hasMatch(value!)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 16),

                    // Password Field
                    _buildTextField(
                      controller: passwordController,
                      label: 'Password',
                      hint: 'Enter your password',
                      icon: Icons.lock,
                      isPassword: true,
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter your password';
                        }
                        if (value!.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 32),

                    // Login/Sign Up Button
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: isLoading ? null : _handleAuth,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colorScheme.primary,
                          foregroundColor: colorScheme.onPrimary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 4,
                          shadowColor: colorScheme.shadow.withValues(alpha: 0.3),
                        ),
                        child: isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Text(
                                isSignUp ? 'Create Account' : 'Sign In',
                                style: textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Toggle Sign Up/Sign In
                    Center(
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            isSignUp = !isSignUp;
                            formKey.currentState?.reset();
                          });
                        },
                        child: Text(
                          isSignUp
                              ? 'Already have an account? Sign In'
                              : "Don't have an account? Sign Up",
                          style: textTheme.bodyMedium?.copyWith(
                            color: colorScheme.primary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Skip Button for demo/testing
                    Center(
                      child: TextButton(
                        onPressed: _handleSkip,
                        style: TextButton.styleFrom(
                          foregroundColor: colorScheme.onSurfaceVariant,
                        ),
                        child: Text(
                          'Skip Login (Demo)',
                          style: textTheme.bodyMedium?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Features Preview
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: colorScheme.surface.withValues(alpha: 0.8),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: colorScheme.outline.withValues(alpha: 0.2),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Features',
                            style: textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: colorScheme.onSurface,
                            ),
                          ),
                          const SizedBox(height: 16),
                          _buildFeatureRow(Icons.mood, 'Daily mood tracking'),
                          _buildFeatureRow(Icons.local_hospital, 'Health monitoring'),
                          _buildFeatureRow(Icons.spa, 'Wellness practices'),
                          _buildFeatureRow(Icons.sos, 'Emergency SOS'),
                        ],
                      ),
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

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    bool isPassword = false,
    required String? Function(String?) validator,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, color: colorScheme.onSurfaceVariant),
        filled: true,
        fillColor: colorScheme.surface.withValues(alpha: 0.8),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.outline.withValues(alpha: 0.3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.primary, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.outline.withValues(alpha: 0.3)),
        ),
      ),
      validator: validator,
      style: theme.textTheme.bodyLarge?.copyWith(
        color: colorScheme.onSurface,
      ),
    );
  }

  Widget _buildFeatureRow(IconData icon, String text) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: colorScheme.primary,
          ),
          const SizedBox(width: 12),
          Text(
            text,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _handleAuth() async {
    if (!formKey.currentState!.validate()) return;

    setState(() => isLoading = true);

    try {
      final authService = ref.read(authServiceProvider);

      final success = await authService.login(
        emailController.text.trim(),
        passwordController.text.trim(),
        fullNameController.text.trim(),
      );

      if (success && mounted) {
        // Pop the login screen - the main app will check auth state and route properly
        Navigator.of(context).pop();
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                isSignUp
                    ? 'Failed to create account. Please try again.'
                    : 'Invalid email or password.',
              ),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('An error occurred: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  void _handleSkip() {
    // Skip authentication and proceed directly to home screen
    final authService = ref.read(authServiceProvider);
    authService.login('demo@example.com', 'demo123', 'Demo User');
    if (mounted) {
      // Force navigation to home screen after successful demo login
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const HomeScreen()),
        (route) => false,
      );
    }
  }
}
