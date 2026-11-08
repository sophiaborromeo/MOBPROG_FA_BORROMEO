import 'package:fa4_reverse_engineering/screens/supply_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fa4_reverse_engineering/commons/theme.dart';
import 'package:fa4_reverse_engineering/data/parameters.dart';
import 'package:fa4_reverse_engineering/data/supplies.dart';
import 'package:fa4_reverse_engineering/model/supply.dart';

const double supplySizedBox = 45;
const double supplySpacing = 30;
const double paddingTop = 72;
const double paddingBottom = 30;

class AddSupplyScreen extends StatefulWidget {
  const AddSupplyScreen({super.key});

  @override
  State<AddSupplyScreen> createState() {
    return _AddSupplyScreenState();
  }
}

class _AddSupplyScreenState extends State<AddSupplyScreen> {
  final _formKey = GlobalKey<FormState>();
  final _itemNameController = TextEditingController();
  final _quantityController = TextEditingController(text: '1');
  final _unitPriceController = TextEditingController(text: '1.00');

  String? _selectedCategory;

  Color get textColor {
    return Theme.of(context).colorScheme.onSurface;
  }
  Color get borderColor {
    return Theme.of(context).colorScheme.outline;
  }
  Color get validationColor {
    return Theme.of(context).brightness == Brightness.dark
        ? defaultColor
        : errorColor;
  }
  TextStyle get fieldTextStyle {
    return TextStyle(
      color: textColor,
      fontSize: fontSize,
    );
  }

  OutlineInputBorder _fieldBorder(Color color, {double width = 1}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: BorderSide(
        color: color,
        width: width,
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    final weaponCategories = parameters.where(
      (parameter) => parameter.parameterClass == 'BASE_WEAPON',
    );

    if (weaponCategories.isNotEmpty) {
      _selectedCategory = weaponCategories.first.parameterName;
    }
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      isDense: true,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 13,
      ),
      labelStyle: fieldTextStyle.copyWith(
        color: textColor.withOpacity(0.85),
      ),
      floatingLabelStyle: fieldTextStyle.copyWith(
        color: textColor.withOpacity(0.85),
        fontSize: textFontSize,
      ),
      errorStyle: TextStyle(
        color: validationColor,
        fontSize: textFontSize,
      ),
      enabledBorder: _fieldBorder(borderColor.withOpacity(0.8)),
      focusedBorder: _fieldBorder(textColor),
      errorBorder: _fieldBorder(validationColor),
      focusedErrorBorder: _fieldBorder(validationColor, width: 2),
    );
  }

  void _changeQuantity(int amount) {
    int quantity = int.tryParse(_quantityController.text) ?? 1;

    quantity += amount;

    if (quantity < 1) {
      quantity = 1;
    }

    if (quantity > 100) {
      quantity = 100;
    }

    setState(() {
      _quantityController.text = quantity.toString();
    });
  }

  @override
  void dispose() {
    _itemNameController.dispose();
    _quantityController.dispose();
    _unitPriceController.dispose();
    super.dispose();
  }

  void _saveSupply() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    supplies.add(
      Supply(
        _itemNameController.text.trim(),
        int.parse(_quantityController.text),
        double.parse(_unitPriceController.text),
        _selectedCategory!,
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
          'Add a new supply',
          style: TextStyle(
            color: textColor,
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Align(
          alignment: Alignment.topCenter,
          child: FractionallySizedBox(
            widthFactor: 0.81,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: paddingTop,
                  bottom: paddingBottom,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: supplySizedBox,
                        child: TextFormField(
                          controller: _itemNameController,
                          style: fieldTextStyle,
                          decoration: _inputDecoration('Item Name'),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Input an item name';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 26),
                      SizedBox(
                        height: supplySizedBox,
                        child: TextFormField(
                          controller: _quantityController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            TextInputFormatter.withFunction(
                              (oldValue, newValue) {
                                if (newValue.text.isEmpty) {
                                  return newValue;
                                }

                                final quantity =
                                    int.tryParse(newValue.text);

                                if (quantity == null ||
                                    quantity < 1 ||
                                    quantity > 100) {
                                  return oldValue;
                                }

                                return newValue;
                              },
                            ),
                          ],
                          textAlign: TextAlign.center,
                          style: fieldTextStyle,
                          decoration:
                              _inputDecoration('Item Quantity').copyWith(
                            prefixIcon: IconButton(
                              onPressed: () {
                                _changeQuantity(-1);
                              },
                              icon: Icon(
                                Icons.remove,
                                color: textColor,
                                size: 20,
                              ),
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                _changeQuantity(1);
                              },
                              icon: Icon(
                                Icons.add,
                                color: textColor,
                                size: iconSize,
                              ),
                            ),
                          ),
                          validator: (value) {
                            final quantity =
                                int.tryParse(value ?? '');

                            if (quantity == null ||
                                quantity < 1 ||
                                quantity > 100) {
                              return 'Quantity must be from 1 to 100';
                            }

                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: supplySpacing),
                      SizedBox(
                        height: supplySizedBox,
                        child: TextFormField(
                          controller: _unitPriceController,
                          keyboardType:
                              const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          style: fieldTextStyle,
                          decoration:
                              _inputDecoration('Unit Price').copyWith(
                            prefixText: '\$ ',
                            prefixStyle: fieldTextStyle,
                          ),
                          validator: (value) {
                            final price =
                                double.tryParse(value ?? '');

                            if (price == null ||
                                !price.isFinite ||
                                price < 0) {
                              return 'Enter a valid unit price';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: supplySpacing),
                      SizedBox(
                        height: supplySizedBox,
                        child: DropdownButtonFormField<String>(
                          value: _selectedCategory,
                          isExpanded: true,
                          decoration: _inputDecoration('Supply Category'),
                          dropdownColor:
                              Theme.of(context).colorScheme.surface,
                          style: fieldTextStyle,
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: textColor,
                          ),
                          items: parameters
                              .where((parameter) =>
                                  parameter.parameterClass ==
                                  'BASE_WEAPON')
                              .map((parameter) {
                            return DropdownMenuItem(
                              value: parameter.parameterName,
                              child: Row(
                                children: [
                                  Container(
                                    width: sizeWidth,
                                    height: sizeHeight,
                                    color: parameter.color,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    parameter.parameterName,
                                    style: fieldTextStyle,
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedCategory = value;
                            });
                          },
                          validator: (value) {
                            if (value == null) {
                              return 'Kindly select a category';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: supplySpacing),
                      SizedBox(
                        height: sizedBoxHeight,
                        child: ElevatedButton(
                          onPressed: _saveSupply,
                          style: ElevatedButton.styleFrom(
                            shape: const StadiumBorder(),
                            padding: EdgeInsets.zero,
                          ),
                          child: const Text(
                            'Save',
                            style: TextStyle(fontSize: fontSize),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
