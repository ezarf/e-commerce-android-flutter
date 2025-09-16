import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'home_page.dart'; // Halaman beranda

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isObscure = true;
  bool _rememberMe = false;

  late AnimationController _fadeController;
  late AnimationController _slideController;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..forward();

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..forward();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDark
                ? [Colors.black, Colors.grey.shade900]
                : [Color(0xFFFFF3E0), Color(0xFFFFCCBC)],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: AnimatedBuilder(
              animation: Listenable.merge([_fadeController, _slideController]),
              builder: (context, child) {
                return AnimatedOpacity(
                  duration: const Duration(milliseconds: 500),
                  opacity: _fadeController.value,
                  child: AnimatedSlide(
                    duration: const Duration(milliseconds: 500),
                    offset: Offset(0, 0.2 * (1 - _slideController.value)),
                    child: child,
                  ),
                );
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Hero(
                    tag: 'logo',
                    child: Icon(
                      Icons.shopping_cart_rounded,
                      size: 80,
                      color: Color(0xFFFF7043),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Card(
                    elevation: 12,
                    shadowColor: Colors.black26,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(28.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Center(
                              child: Text(
                                'Welcome Back',
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFFF7043),
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Center(
                              child: Text(
                                'Sign in to continue',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),
                            TextFormField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                labelText: 'Email',
                                prefixIcon: const Icon(Icons.email_outlined),
                                filled: true,
                                fillColor: Colors.grey[100],
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email';
                                }
                                if (!value.contains('@')) {
                                  return 'Please enter a valid email';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: _passwordController,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                prefixIcon: const Icon(Icons.lock_outline),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _isObscure
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _isObscure = !_isObscure;
                                    });
                                  },
                                ),
                                filled: true,
                                fillColor: Colors.grey[100],
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              obscureText: _isObscure,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
                                }
                                if (value.length < 6) {
                                  return 'Password must be at least 6 characters';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 8),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {
                                  // Forgot password logic
                                },
                                child: const Text(
                                  'Forgot password?',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.deepOrange,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Checkbox(
                                  value: _rememberMe,
                                  onChanged: (value) {
                                    setState(() {
                                      _rememberMe = value ?? false;
                                    });
                                  },
                                ),
                                const Text(
                                  'Remember me',
                                  style: TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            SizedBox(
                              height: 50,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFFF7043),
                                  elevation: 8,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  shadowColor:
                                      Colors.deepOrange.withOpacity(0.4),
                                ),
                                onPressed: () {
                                  Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
                                },
                                child: const Text(
                                  'LOGIN',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: const [
                                Expanded(child: Divider()),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Text("or"),
                                ),
                                Expanded(child: Divider()),
                              ],
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                              height: 50,
                              child: OutlinedButton.icon(
                                icon: Image.asset(
                                  'assets/images/google_logo.png',
                                  height: 24,
                                ),
                                label: const Text(
                                  'Sign in with Google',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black87,
                                  ),
                                ),
                                style: OutlinedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  side: const BorderSide(color: Colors.grey),
                                  backgroundColor: Colors.white,
                                ),
                                onPressed: () {
                                  // Google Sign-In logic
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                      // Sign-up logic
                    },
                    child: const Text(
                      "Don't have an account? Sign Up",
                      style: TextStyle(
                        color: Colors.white,
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
