import 'package:flutter/material.dart';
import 'package:fa4_reverse_engineering/commons/theme.dart';
import 'package:fa4_reverse_engineering/data/users.dart';
import 'package:fa4_reverse_engineering/model/user.dart';
import 'package:fa4_reverse_engineering/screens/signup_screen.dart';
import 'package:fa4_reverse_engineering/screens/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.isDarkMode, required this.onToggleTheme,});

  final bool isDarkMode;
  final VoidCallback onToggleTheme;

  @override
  State<LoginScreen> createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void clearLoginFields() {
    _usernameController.clear();
    _passwordController.clear();
  }

  void _login() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    await Future.delayed(const Duration(milliseconds: 700));

    User? loggedInUser;

    for (final user in users) {
      if (user.username == _usernameController.text.trim() &&
          user.password == _passwordController.text) {
        loggedInUser = user;
        break;
      }
    }

    if (!mounted) {
      return;
    }

    setState(() {
      _isLoading = false;
    });

    if (loggedInUser == null) {
      _showLoginFailed();
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(
            user: loggedInUser!,
            isDarkMode: widget.isDarkMode,
            onToggleTheme: widget.onToggleTheme,
            onLogout: clearLoginFields,
          ),
        ),
      );
    }
  }


  void _showLoginFailed() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Login failed.'),
          content: const Text('Invalid username or password'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                onPressed: widget.onToggleTheme,
                icon: const Icon(Icons.brightness_6),
                color: colorScheme.primary,
                iconSize: iconSize,
              ),
            ),
            Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                  vertical: verticalPadding,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        widget.isDarkMode
                            ? 'assets/images/applogo_dark.png'
                            : 'assets/images/applogo_light.png',
                        width: logoLoginWidth,
                        height: logoLoginHeight,
                        fit: BoxFit.fill,
                      ),
                      const SizedBox(height: largeBoxSpacing),
                      TextFormField(
                        controller: _usernameController,
                        decoration: const InputDecoration(
                          hintText: 'Username',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Kindly enter your username';
                          }

                          return null;
                        },
                      ),
                      const SizedBox(height: boxSpacing),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: !_isPasswordVisible,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          border: const OutlineInputBorder(),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible =
                                    !_isPasswordVisible;
                              });
                            },
                            icon: Icon(
                              _isPasswordVisible
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Kindly enter your password';
                          }

                          return null;
                        },
                      ),
                      const SizedBox(height: boxSpacing),
                      SizedBox(
                        width: double.infinity,
                        height: sizedBoxHeight,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _login,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: widget.isDarkMode
                                ? defaultColor
                                : darkDefaultColor,
                            foregroundColor: widget.isDarkMode
                                ? foregroundColorDark
                                : foregroundColorLight,
                            shape: const StadiumBorder(),
                            padding: EdgeInsets.zero,
                          ),
                          child: _isLoading
                              ? CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: widget.isDarkMode
                                    ? foregroundColorDark
                                    : foregroundColorLight,
                                )
                              : const Text('Login'),
                        ),
                      ),
                      const SizedBox(height: boxSpacing),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return SignupScreen(
                                  isDarkMode: widget.isDarkMode,
                                  onToggleTheme: widget.onToggleTheme,
                                );
                              },
                            ),
                          );
                        },
                        child: const Text(
                          'Does not have an account yet? Sign Up now!',
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
    );
  }
}
