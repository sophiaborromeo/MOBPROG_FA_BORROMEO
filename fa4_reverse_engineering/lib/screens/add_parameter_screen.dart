import 'dart:math' as math;
import 'package:fa4_reverse_engineering/screens/parameter_settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:fa4_reverse_engineering/commons/theme.dart';
import 'package:fa4_reverse_engineering/data/parameters.dart';
import 'package:fa4_reverse_engineering/model/parameter.dart';

const double parameterSizedBox= 8;
const double degreeToRadians= 180;
const double strokeWidth= 3;
const double circleRadius= 11;
const double circleRadius2= 10;
const double radiusDivisor= 2;

class AddParameterScreen extends StatefulWidget {
  const AddParameterScreen({super.key});

  @override
  State<AddParameterScreen> createState() {
    return _AddParameterScreenState();
  }
}

class _AddParameterScreenState extends State<AddParameterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _parameterNameController = TextEditingController();
  final _parameterClassController = TextEditingController();

  Color selectedColor = Colors.black;

  Color get textColor {
    return Theme.of(context).colorScheme.onSurface;
  }

  Color get validationColor {
    return Theme.of(context).brightness == Brightness.dark
        ? defaultColor
        : errorColor;
  }

  @override
  void dispose() {
    _parameterNameController.dispose();
    _parameterClassController.dispose();
    super.dispose();
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      isDense: true,
      counterStyle: TextStyle(
        color: Theme.of(context).colorScheme.onSurfaceVariant,
        fontSize: textFontSize,
      ),
      labelStyle: TextStyle(
        color: textColor.withOpacity(0.8),
        fontSize: fontSize,
      ),
      floatingLabelStyle: TextStyle(
        color: textColor,
        fontSize: fontSize,
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: textColor.withOpacity(0.5),
        ),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: textColor,
        ),
      ),
      errorBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: validationColor,
        ),
      ),
      focusedErrorBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: validationColor,
          width: 1.5,
        ),
      ),
      errorStyle: TextStyle(
        color: validationColor,
        fontSize: textFontSize,
      ),
    );
  }

  String get colorHex {
    return selectedColor.value
        .toRadixString(16)
        .padLeft(8, '0')
        .toUpperCase();
  }

  void _resetForm() {
    setState(() {
      _parameterNameController.clear();
      _parameterClassController.clear();
    });
  }

  void _addParameter() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    parameters.add(
      Parameter(
        _parameterNameController.text.trim(),
        _parameterClassController.text.trim(),
        selectedColor,
      ),
    );

    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(
          'Add a new parameter',
          style: TextStyle(
            color: textColor,
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final screenWidth = constraints.maxWidth;
            final wheelSize = math.min(
              260.0,
              screenWidth * 0.42,
            );

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(9, 24, 12, 30),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _parameterNameController,
                        maxLength: textMaxLength,
                        style: TextStyle(
                          color: textColor,
                          fontSize: fontSize,
                        ),
                        decoration: _inputDecoration(
                          'Parameter Name',
                        ),
                        validator: (value) {
                          if (value == null ||
                              value.trim().isEmpty ||
                              value.trim().length > textMaxLength) {
                            return 'Must be between 1 and 50 Characters';
                          }

                          return null;
                        },
                      ),

                      const SizedBox(height: parameterSizedBox),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(
                                top: wheelSize * 0.90,
                                right: 12,
                              ),
                              child: TextFormField(
                                controller: _parameterClassController,
                                maxLength: textMaxLength,
                                style: TextStyle(
                                  color: textColor,
                                  fontSize: fontSize,
                                ),
                                decoration: _inputDecoration(
                                  'Parameter Class',
                                ),
                                validator: (value) {
                                  if (value == null ||
                                      value.trim().isEmpty ||
                                      value.trim().length >
                                          textMaxLength) {
                                    return 'Must be between 1 and 50 Characters';
                                  }

                                  return null;
                                },
                              ),
                            ),
                          ),

                          SizedBox(
                            width: wheelSize + 12,
                            child: Column(
                              children: [
                                ColorWheel(
                                  size: wheelSize,
                                  selectedColor: selectedColor,
                                  onColorChanged: (color) {
                                    setState(() {
                                      selectedColor = color;
                                    });
                                  },
                                ),

                                const SizedBox(height: parameterSizedBox),

                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: width,
                                      height: height,
                                      color: selectedColor,
                                    ),
                                    const SizedBox(width: 2),
                                    Expanded(
                                      child: Text(
                                        colorHex,
                                        style: TextStyle(
                                          color: textColor,
                                          fontSize: fontSize,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: parameterSizedBox),

                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.end,
                                  children: [
                                    TextButton(
                                      onPressed: _resetForm,
                                      style: TextButton.styleFrom(
                                        foregroundColor:
                                            Theme.of(context)
                                                .colorScheme
                                                .onSurface,
                                        padding:
                                            const EdgeInsets.symmetric(
                                          horizontal: 10,
                                        ),
                                      ),
                                      child: const Text(
                                        'Reset',
                                        style: TextStyle(
                                          fontSize: fontSize,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    SizedBox(
                                      width: sizedBoxWidth,
                                      height: sizedBoxHeight,
                                      child: ElevatedButton(
                                        onPressed: _addParameter,
                                        style:
                                            ElevatedButton.styleFrom(
                                          shape: const StadiumBorder(),
                                          padding: EdgeInsets.zero,
                                        ),
                                        child: const Text(
                                          'Add Parameter',
                                          style: TextStyle(
                                            fontSize: fontSize,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class ColorWheel extends StatelessWidget {
  const ColorWheel({super.key, required this.size, required this.selectedColor, required this.onColorChanged,});

  final double size;
  final Color selectedColor;
  final ValueChanged<Color> onColorChanged;

  void _updateColor(
    Offset position,
    Size wheelSize,
  ) {
    final center = Offset(
      wheelSize.width / radiusDivisor,
      wheelSize.height / radiusDivisor,
    );

    final dx = position.dx - center.dx;
    final dy = position.dy - center.dy;
    final radius = wheelSize.width / radiusDivisor;
    final distance = math.sqrt(dx * dx + dy * dy);
    final saturation = (distance / radius).clamp(0.0, 1.0);

    double hue = math.atan2(dy, dx) * 180 / math.pi;

    if (hue < 0) {
      hue += 360;
    }

    onColorChanged(
      HSVColor.fromAHSV(
        1,
        hue,
        saturation,
        1,
      ).toColor(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanDown: (details) {
        _updateColor(details.localPosition, Size(size, size));
      },
      onPanUpdate: (details) {
        _updateColor(details.localPosition, Size(size, size));
      },
      child: SizedBox(
        width: size,
        height: size,
        child: CustomPaint(
          painter: _ColorWheelPainter(selectedColor),
        ),
      ),
    );
  }
}

class _ColorWheelPainter extends CustomPainter {
  _ColorWheelPainter(this.selectedColor);

  final Color selectedColor;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(
      size.width / radiusDivisor,
      size.height / radiusDivisor,
    );

    final radius = size.width / radiusDivisor;

    final circleRect = Rect.fromCircle(
      center: center,
      radius: radius,
    );

    final huePaint = Paint()
      ..shader = const SweepGradient(
        colors: [
          Colors.red,
          Colors.yellow,
          Colors.green,
          Colors.cyan,
          Colors.blue,
          Colors.purple,
          Colors.red,
        ],
      ).createShader(circleRect);

    canvas.drawCircle(center, radius, huePaint);

    final saturationPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          Colors.white,
          Colors.white.withOpacity(0),
        ],
      ).createShader(circleRect);

    canvas.drawCircle(center, radius, saturationPaint);

    final hsv = HSVColor.fromColor(selectedColor);
    final angle = hsv.hue * math.pi / degreeToRadians;
    final selectionDistance = radius * hsv.saturation;
    final selectionPosition = Offset(
      center.dx + math.cos(angle) * selectionDistance,
      center.dy + math.sin(angle) * selectionDistance,
    );

    final shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.2)
      ..maskFilter = const MaskFilter.blur(
        BlurStyle.normal,
        3,
      );

    canvas.drawCircle(
      selectionPosition,
      circleRadius,
      shadowPaint,
    );

    final selectorPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    canvas.drawCircle(
      selectionPosition,
      circleRadius2,
      selectorPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _ColorWheelPainter oldDelegate) {
    return oldDelegate.selectedColor != selectedColor;
  }
}
