import 'package:flutter/material.dart';
import 'package:fa4_reverse_engineering/data/parameters.dart';
import 'package:fa4_reverse_engineering/model/parameter.dart';
import 'package:fa4_reverse_engineering/screens/add_parameter_screen.dart';

const double fontSize = 14;
const double parameterIconSize= 24;
const double height = 24;
const double width = 24;
const double parameterLargeSizedBox = 12;
const double smallFontSize = 10;

class ParameterSettingsScreen extends StatefulWidget {
  const ParameterSettingsScreen({super.key});

  @override
  State<ParameterSettingsScreen> createState() {
    return _ParameterSettingsScreenState();
  }
}

class _ParameterSettingsScreenState
    extends State<ParameterSettingsScreen> {
  final _searchController = TextEditingController();

  String searchQuery = '';

  Color get textColor {
    return Theme.of(context).colorScheme.onSurface;
  }

  List<Parameter> get filteredParameters {
    return parameters.where((parameter) {
      return parameter.parameterClass
          .toLowerCase()
          .contains(searchQuery.toLowerCase());
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
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
          'Parameter Settings',
          style: TextStyle(
            color: textColor,
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      const AddParameterScreen(),
                ),
              );

              if (mounted) {
                setState(() {});
              }
            },
            icon: const Icon(Icons.add, size: parameterIconSize),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(9, 20, 12, 0),
            child: TextField(
              controller: _searchController,
              style: TextStyle(
                color: textColor,
                fontSize: fontSize,
              ),
              decoration: InputDecoration(
                labelText: 'Search by Class',
                labelStyle: TextStyle(
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
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(25, 0, 40, 0),
              itemCount: filteredParameters.length,
              itemBuilder: (context, index) {
                final parameter = filteredParameters[index];

                return SizedBox(
                  height: 48,
                  child: Row(
                    children: [
                      Container(
                        width: width,
                        height: height,
                        color: parameter.color,
                      ),
                      const SizedBox(width: parameterLargeSizedBox),
                      Expanded(
                        child: Text(
                          parameter.parameterName,
                          style: TextStyle(
                            color: textColor,
                            fontSize: fontSize,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        parameter.parameterClass,
                        style: TextStyle(
                          fontSize: smallFontSize,
                        ),
                      ),
                    ],
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
