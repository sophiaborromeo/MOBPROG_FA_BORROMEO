import 'package:flutter/material.dart';
import 'package:fa4_reverse_engineering/commons/theme.dart';
import 'package:fa4_reverse_engineering/data/users.dart';
import 'package:fa4_reverse_engineering/model/user.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key, required this.isDarkMode, required this.onToggleTheme,});

  final bool isDarkMode;
  final VoidCallback onToggleTheme;

  @override
  State<SignupScreen> createState() {
    return _SignupScreenState();
  }
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();

  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  void _signup() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    for (final user in users) {
      if (user.username == _usernameController.text.trim()) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Username already exists'),
          ),
        );
        return;
      }
    }

    users.add(
      User(
        _usernameController.text.trim(),
        _passwordController.text,
        _firstNameController.text.trim(),
        _lastNameController.text.trim(),
      ),
    );

    Navigator.pop(context);
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
                        width: logoWidth,
                        height: logoHeight,
                        fit: BoxFit.fill,
                      ),
                      const SizedBox(height: largeBoxSpacing),
                      Text(
                        'Become a Firefly',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: largeBoxSpacing),
                      TextFormField(
                        controller: _usernameController,
                        maxLength: textMaxLength,
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
                      TextFormField(
                        controller: _firstNameController,
                        maxLength: textMaxLength,
                        decoration: const InputDecoration(
                          hintText: 'First Name',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Kindly enter your first name';
                          }

                          return null;
                        },
                      ),
                      const SizedBox(height: boxSpacing),
                      TextFormField(
                        controller: _lastNameController,
                        maxLength: textMaxLength,
                        decoration: const InputDecoration(
                          hintText: 'Last Name',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Kindly enter your last name';
                          }

                          return null;
                        },
                      ),
                      const SizedBox(height: buttonSpacing),
                      SizedBox(
                        width: double.infinity,
                        height: sizedBoxHeight,
                        child: ElevatedButton(
                          onPressed: _signup,
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
                          child: const Text('Sign Up'),
                        ),
                      ),
                      const SizedBox(height: boxSpacing),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel'),
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
