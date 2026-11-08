import 'package:flutter/material.dart';
import 'package:fa4_reverse_engineering/commons/chart_bar.dart';
import 'package:fa4_reverse_engineering/data/parameters.dart';
import 'package:fa4_reverse_engineering/data/supplies.dart';
import 'package:fa4_reverse_engineering/model/supply.dart';
import 'package:fa4_reverse_engineering/screens/add_supply_screen.dart';

const double sizeWidth = 24;
const double sizeHeight= 24;
const double fontSize= 14;
const double radius= 14;
const double margin= 14;
const double supplyBoxHeight = 8;

class SupplyScreen extends StatefulWidget {
  const SupplyScreen({super.key});

  @override
  State<SupplyScreen> createState() {
    return _SupplyScreenState();
  }
}

class _SupplyScreenState extends State<SupplyScreen> {
  List<Supply> dismissedSupplies = [];

  Color get backgroundColor {
    return Theme.of(context).scaffoldBackgroundColor;
  }
  Color get textColor {
    return Theme.of(context).colorScheme.onSecondaryContainer;
  }
  Color get cardColor {
    return Theme.of(context).colorScheme.secondaryContainer;
  }
  Color get borderColor {
    return Theme.of(context).colorScheme.outlineVariant;
  }
  Color get dismissColor {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color(0xFFC99A91)
        : const Color(0xFFF4B6B0);
  }

  List<String> get categories {
    return parameters
        .where((parameter) => parameter.parameterClass == 'BASE_WEAPON')
        .map((parameter) => parameter.parameterName)
        .toList();
  }

  List<Supply> get filteredSupplies {
    return supplies.where((supply) {
      return categories.contains(supply.supplyCategory) &&
          !dismissedSupplies.contains(supply);
    }).toList();
  }

  int totalQuantity(String category) {
    int total = 0;

    for (final supply in supplies) {
      if (supply.supplyCategory == category) {
        total += supply.itemQuantity;
      }
    }
    return total;
  }

  int get maxTotalQuantity {
    int maxTotal = 0;

    for (final category in categories) {
      if (totalQuantity(category) > maxTotal) {
        maxTotal = totalQuantity(category);
      }
    }
    return maxTotal;
  }

  Color getCategoryColor(String category) {
    for (final parameter in parameters) {
      if (parameter.parameterName == category) {
        return parameter.color;
      }
    }
    return Colors.grey;
  }

  String formatPrice(double price) {
    return price.toStringAsFixed(2);
  }

  void _openAddSupply() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddSupplyScreen(),
      ),
    );

    if (!mounted) return;
    setState(() {
      dismissedSupplies.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
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
          'Supply Manager',
          style: TextStyle(
            color: textColor,
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: _openAddSupply,
            icon: const Icon(Icons.add, size: 24),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(14, 16, 14, 12),
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 16),
            width: double.infinity,
            height: 180,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(9),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  backgroundColor,
                  Theme.of(context).colorScheme.primaryContainer,
                  cardColor,
                ],
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (final category in categories)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Column(
                        children: [
                          ChartBar(
                            fill: maxTotalQuantity == 0
                                ? 0
                                : totalQuantity(category) / maxTotalQuantity,
                          ),
                          const SizedBox(height: 12),
                          Container(
                            width: double.infinity,
                            height: sizeHeight,
                            color: getCategoryColor(category),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(14, 0, 14, 12),
              itemCount: filteredSupplies.length,
              itemBuilder: (context, index) {
                final supply = filteredSupplies[index];
                final totalPrice = supply.itemQuantity * supply.unitPrice;

                return Dismissible(
                  key: ValueKey(supply),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    margin: const EdgeInsets.only(bottom: margin),
                    decoration: BoxDecoration(
                      color: dismissColor,
                      borderRadius: BorderRadius.circular(radius),
                    ),
                  ),
                  secondaryBackground: Container(
                    margin: const EdgeInsets.only(bottom: margin),
                    decoration: BoxDecoration(
                      color: dismissColor,
                      borderRadius: BorderRadius.circular(radius),
                    ),
                  ),
                  onDismissed: (direction) {
                    setState(() {
                      dismissedSupplies.add(supply);
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: margin),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: BorderRadius.circular(radius),
                      border: Border.all(
                        color: borderColor,
                        width: 0.8,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: textColor.withOpacity(0.10),
                          offset: const Offset(0, 2),
                          blurRadius: 1,
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                supply.itemName,
                                style: TextStyle(
                                  color: textColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: supplyBoxHeight),
                              Text(
                                '\$${formatPrice(supply.unitPrice)} X '
                                '${supply.itemQuantity} = '
                                '\$${formatPrice(totalPrice)}',
                                style: TextStyle(
                                  color: textColor,
                                  fontSize: fontSize,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: supplyBoxHeight),
                        Container(
                          width: sizeHeight,
                          height: sizeHeight,
                          color: getCategoryColor(supply.supplyCategory),
                        ),
                        const SizedBox(width: supplyBoxHeight),
                        Text(
                          supply.supplyCategory,
                          style: TextStyle(
                            color: textColor,
                            fontSize: fontSize,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
