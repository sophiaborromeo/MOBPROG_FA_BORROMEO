import 'package:flutter/material.dart';
import 'package:fa4_reverse_engineering/commons/theme.dart';
import 'package:fa4_reverse_engineering/model/user.dart';
import 'package:fa4_reverse_engineering/screens/supply_screen.dart';
import 'package:fa4_reverse_engineering/screens/parameter_settings_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.user, required this.isDarkMode, required this.onToggleTheme, required this.onLogout,});

  final User user;
  final bool isDarkMode;
  final VoidCallback onToggleTheme;
  final VoidCallback onLogout;

  @override
  Widget build(BuildContext context) {
    final textColor = isDarkMode ? defaultColor : darkDefaultColor;
    final iconColor = isDarkMode ? defaultColor : darkDefaultColor;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                  vertical: verticalPadding,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: textLargeBoxSpacing),
                    Text(
                      'Hello\n${user.firstName} ${user.lastName}\n'
                      'You are now one of the Fireflies',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: headerFontSize,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                        height: textStyleHeight,
                      ),
                    ),
                    const SizedBox(height: textBoxSpacing),
                    Image.asset(
                      isDarkMode
                          ? 'assets/images/applogo_dark.png'
                          : 'assets/images/applogo_light.png',
                        width: logoWidth,
                        height: logoHeight,
                        fit: BoxFit.fill,
                      ),
                    const SizedBox(height: textBoxSpacing),
                    SizedBox(
                      width: sizedBoxWidth,
                      height: sizedBoxHeight,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SupplyScreen(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isDarkMode
                              ? defaultColor
                              : darkDefaultColor,
                          foregroundColor: isDarkMode
                              ? darkDefaultColor
                              : defaultColor,
                          shape: const StadiumBorder(),
                          padding: EdgeInsets.zero,
                          elevation: 0,
                        ),
                        child: const Text(
                          'Check for Supplies',
                          style: TextStyle(fontSize: textFontSize),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Align(
              alignment: Alignment.topCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: onToggleTheme,
                    icon: const Icon(Icons.brightness_6),
                    color: iconColor,
                    iconSize: iconSize,
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ParameterSettingsScreen(),
                            ),
                          );
                        },
                        icon: const Icon(Icons.settings),
                        color: iconColor,
                        iconSize: iconSize,
                      ),
                      IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (dialogContext) {
                              return AlertDialog(
                                title: const Text('Logout confirmation'),
                                content: const Text(
                                  'Are you sure you want to logout?',
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(dialogContext);
                                    },
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(dialogContext);
                                      onLogout();
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Yes'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        icon: const Icon(Icons.logout),
                        color: iconColor,
                        iconSize: iconSize,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
