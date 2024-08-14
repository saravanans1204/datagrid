import 'package:datagrid/mymodel.dart';
import 'package:datagrid/providers/TableState.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum FieldType { input, autocomplete, amount }

class MyCustomTable extends StatefulWidget {
  @override
  _MyCustomTableState createState() => _MyCustomTableState();
}

class _MyCustomTableState extends State<MyCustomTable> {
  String reference = '12345678';
  List<Map<String, dynamic>> _data = [
    {
      'id': 1,
      'Item': '001/Laptop Charger',
      "UOM": "Each",
      'quantity': 2,
      'price': 10.0,
      'Amount': 2 * 10.0,
      "Remarks": ""
    },
    {
      'id': 1,
      'Item': '001/Laptop',
      "UOM": "Each",
      'quantity': 2,
      'price': 14.0,
      'Amount': 2 * 14.0,
      "Remarks": ""
    },
    // {
    //   'id': 2,
    //   'Item': '001/Laptop Charger',
    //   "UOM": "Each",
    //   'quantity': 2,
    //   'price': 10.0,
    //   'Amount': 21.00,
    //   "Remarks": ""
    // },
    //  {
    //   'id': 3,
    //   'Item':'bb',
    //   "UOM": "Each",
    //   'quantity': 2,
    //   'price': 10.0,
    //   'Amount': 21.00,
    //   "Remarks": ""
    // },
    // {
    //   'id': 4,
    //   'Item': '001/Laptop Charger',
    //   "UOM": "Each",
    //   'quantity': 2,
    //   'price': 10.0,
    //   'Amount': 21.00,
    //   "Remarks": ""
    // },
  ];

  List<Map<String, dynamic>> _dataArray = [
    // {
    //   'id': 2,
    //   'Item': '001/Laptop Charger',
    //   "UOM": "Each",
    //   'quantity': 2,
    //   'price': 10.0,
    //   'Amount': 21.00,
    //   "Remarks": ""
    // },
    //  {
    //   'id': 3,
    //   'Item':'bb',
    //   "UOM": "Each",
    //   'quantity': 2,
    //   'price': 10.0,
    //   'Amount': 21.00,
    //   "Remarks": ""
    // },
    // {
    //   'id': 4,
    //   'Item': '001/Laptop Charger',
    //   "UOM": "Each",
    //   'quantity': 2,
    //   'price': 10.0,
    //   'Amount': 21.00,
    //   "Remarks": ""
    // },
  ];

  bool _isAscending = true;
  String? selectedValue = 'Instruction';
  final TextEditingController _controller = TextEditingController(text: "");

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    print('666');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 20, left: 0, right: 0),
          child: Row(
            children: [
              //
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title with reference
                    Text(
                      'With Reference to',
                      style: TextStyle(
                        fontSize: 10.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0), // Spacing between title and dropdown

                    // Dropdown container
                    Container(
                      height: 40,
                      child: Theme(
                        data: Theme.of(context).copyWith(
                          inputDecorationTheme: InputDecorationTheme(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: const Color.fromARGB(255, 255, 124,
                                      124)), // Set focus color to grey
                            ),
                          ),
                        ),
                        child: DropdownButtonFormField<String>(
                          value: selectedValue,
                          items: <String>['Instruction', 'Reference']
                              .map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(
                                    fontSize: 12.0), // Small text size
                              ),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedValue = newValue;
                              newValue == "Reference"
                                  ? _controller.text = reference
                                  : _controller.text = "";
                            });
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 8.0),
                            border: OutlineInputBorder(),
                          ),
                          icon: Icon(
                              Icons.arrow_drop_down), // Use an up arrow icon
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                  width: 16.0), // Spacing between the dropdown and text field

              // Input Field with reference number
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title with reference
                  Text(
                    'Reference Number',
                    style: TextStyle(
                      fontSize: 10.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0), // Spacing between title and text field
                  // Text field container
                  Container(
                    height: 40,
                    child: TextField(
                      controller: _controller,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 8.0), // Adjust padding
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: const Color.fromARGB(255, 255, 124,
                                  124)), // Set focus color to grey
                        ),
                      ),
                      style: TextStyle(
                        fontSize: 12.0, // Set font size to a smaller value
                      ),
                    ),
                  ),
                ],
              ))
            ],
          ),
        ),
        // Row of icons for actions
        Container(
          margin: EdgeInsets.only(top: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Card(
                elevation: 4, // Adds a shadow to the card
                shape: CircleBorder(), // Ensures the card remains circular
                child: Container(
                  width: 24, // Adjust the width of the container
                  height: 24, // Adjust the height of the container
                  child: IconButton(
                    padding: EdgeInsets.all(
                        2), // Adjust padding to make the icon fit the smaller size
                    icon: Icon(Icons.add,
                        color: const Color.fromARGB(255, 255, 124, 124),
                        size: 16), // Set the icon color to grey and adjust size
                    onPressed: () async {
                      // Show the dialog and wait for the result
                      final result = await showDialog<List<dynamic>>(
                        context: context,
                        builder: (context) => FullScreenAlertDialog(),
                      );

                      if (result != null) {
                        print('Received data: $result');

                        // Create a map for the new item
                        final newItem = {
                          "id": int.parse(result[0]),
                          'Item': result[1].toString(),
                          "UOM": result[2],
                          'quantity': int.parse(result[3]),
                          'price': double.parse(result[4]),
                          'Amount': double.parse(result[5]),
                          "Remarks": result[6],
                        };

                        print(newItem);
                        print(_dataArray);
                        bool isDuplicate = (selectedValue == "Instruction")
                            ? _dataArray.any((item) =>
                                item['id'].toString() ==
                                    newItem['id'].toString() ||
                                item['Item'].toString() ==
                                    newItem['Item'].toString())
                            : _data.any((item) =>
                                item['id'].toString() ==
                                    newItem['id'].toString() ||
                                item['Item'].toString() ==
                                    newItem['Item'].toString());

                        if (isDuplicate) {
                          // Show alert dialog if duplicate is found
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text('Duplicate Item'),
                              content: Text(
                                  'Item  exists  and cannot be added again.'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pop(); // Close the alert dialog
                                  },
                                  child: Text('OK'),
                                ),
                              ],
                            ),
                          );
                        } else {
                          // If no duplicate, add the item to the appropriate list
                          setState(() {
                            if (selectedValue == "Instruction") {
                              _dataArray.add(newItem);
                            } else {
                              _data.add(newItem);
                            }
                          });
                        }
                      }
                    },
                    tooltip: 'Add Row',
                  ),
                ),
              ),
              SizedBox(width: 8),
              Card(
                elevation: 4, // Adds a shadow to the card
                shape: CircleBorder(), // Ensures the card remains circular
                child: Container(
                  width: 24, // Adjust the width of the container
                  height: 24, // Adjust the height of the container
                  child: IconButton(
                    padding: EdgeInsets.all(
                        2), // Adjust padding to make the icon fit the smaller size
                    icon: Icon(Icons.sort,
                        color: const Color.fromARGB(255, 255, 124, 124),
                        size: 16), // Set the icon color to grey and adjust size
                    onPressed: _sortRows,
                    tooltip: 'Sort Rows',
                  ),
                ),
              ),
              Card(
                elevation: 4, // Adds a shadow to the card
                shape: CircleBorder(), // Ensures the card remains circular
                child: Container(
                  width: 24, // Adjust the width of the container
                  height: 24, // Adjust the height of the container
                  child: IconButton(
                    padding: EdgeInsets.all(
                        2), // Adjust padding to make the icon fit the smaller size
                    icon: Icon(
                      Icons.delete,
                      size: 16.0,
                      color: const Color.fromARGB(255, 255, 124, 124),
                    ),
                    onPressed: () => _deleteRow(),
                    tooltip: 'Delete Row',
                  ),
                ),
              ),
            ],
          ),
        ),
        // Custom table
        SizedBox(
          height: 12,
        ),
        Container(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              children: [
                // Table header
                Row(
                  children: [
                    _buildTableHeaderCell('', width: 30),
                    _buildTableHeaderCell('Item'),
                    _buildTableHeaderCell('UOM'),
                    _buildTableHeaderCell('Qty'),
                    _buildTableHeaderCell('price'),
                    _buildTableHeaderCell('Amount'),
                    _buildTableHeaderCell('Remarks'),
                    // _buildTableHeaderCell('Actions'),
                  ],
                ),
                // Table rows
                selectedValue != "Instruction"
                    ? Column(
                        children: _data
                            .map((item) => DataRowWidget(item: item))
                            .toList(),
                      )
                    : Column(
                        children: _dataArray
                            .map((item) => DataRowWidget(item: item))
                            .toList(),
                      )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTableHeaderCell(String text, {double width = 100}) {
    return Container(
      width: width,
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(
            color: const Color.fromARGB(255, 73, 73, 73), width: 0.4),
      ),
      child: Text(
        text,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
      ),
    );
  }

  Widget _buildActionCell(int id) {
    return Container(
      width: 100,
      height: 50,
      // padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(
            color: const Color.fromARGB(255, 73, 73, 73), width: 0.4),
      ),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.edit, size: 14.0),
            onPressed: () => _editRow(id),
            tooltip: 'Edit Row',
          ),
          // IconButton(
          //   icon: Icon(Icons.delete, size: 14.0),
          //   onPressed: () => _deleteRow(),
          //   tooltip: 'Delete Row',
          // ),
        ],
      ),
    );
  }

  void _addRow(String name, double price, int quantity, String category) {
    setState(() {
      final int newId = (_data.isNotEmpty ? _data.last['id'] : 0) + 1;
      _data.add({
        'id': newId,
        'name': name,
        'price': price,
        'quantity': quantity,
        'category': category,
      });
    });
  }

  void _editRow(int id) {
    // Implement the edit row functionality
  }

  void _deleteRow() {
    final selectedTextState =
        Provider.of<SelectedTextState>(context, listen: false);

    // Print the list of selected texts
    print('Selected Texts: ${selectedTextState.selectedTexts}');

    if (selectedTextState.selectedTexts.isEmpty) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('No Items Selected'),
              content: Text('Please select items to delete.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: Text('OK'),
                ),
              ],
            );
          });
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Confirm Delete'),
            content: Text('Are you sure you want to delete this item?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .pop(); // Close the dialog without deleting
                },
                child: Text('No'),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    selectedTextState.selectedTexts.forEach((id) {
                      if (selectedValue == "Instruction") {
                        _dataArray
                            .removeWhere((item) => item['id'].toString() == id);
                      } else {
                        _data
                            .removeWhere((item) => item['id'].toString() == id);
                      }
                    });
                  });
                  Navigator.of(context)
                      .pop(); // Close the dialog after deleting
                  selectedTextState
                      .clearSelections(); // Close the dialog after deleting
                },
                child: Text('Yes'),
              ),
            ],
          );
        },
      );
    }
  }

  void _sortRows() {
    print(_data);
    setState(() {
      if (selectedValue == "Instruction") {
        _dataArray.sort((a, b) => _isAscending
            ? a['price'].compareTo(b['price'])
            : b['price'].compareTo(a['price']));

        // Print the sorted _dataArray to the console
        print("Sorted _dataArray:");
        _dataArray.forEach((item) {
          print(item);
        });
      } else {
        _data.sort((a, b) => _isAscending
            ? a['price'].compareTo(b['price'])
            : b['price'].compareTo(a['price']));

        // Print the sorted _data to the console
        print("Sorted _data:");
        _data.forEach((item) {
          print(item);
        });
      }

      // Toggle the sorting order
      _isAscending = !_isAscending;
    });
  }
}

class DataRowWidget extends StatefulWidget {
  final Map<String, dynamic> item;

  DataRowWidget({required this.item});

  @override
  _DataRowWidgetState createState() => _DataRowWidgetState();
}

class _DataRowWidgetState extends State<DataRowWidget> {
  late TextEditingController _quantityController;
  late TextEditingController _priceController;
  late TextEditingController _amountController;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  @override
  void didUpdateWidget(DataRowWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Reinitialize controllers if the item changes
    if (widget.item != oldWidget.item) {
      _initializeControllers();
    }
  }

  void _initializeControllers() {
    _quantityController = TextEditingController(
      text: widget.item['quantity'].toStringAsFixed(2),
    );
    _priceController = TextEditingController(
      text: widget.item['price'].toStringAsFixed(2),
    );
    _amountController = TextEditingController(
      text: (widget.item['quantity'] * widget.item['price']).toStringAsFixed(2),
    );

    // Add listeners to update the amount when quantity or price changes
    _quantityController.addListener(_updateAmount);
    _priceController.addListener(_updateAmount);
  }

  void _updateAmount() {
    final double quantity = double.tryParse(_quantityController.text) ?? 0.0;
    final double price = double.tryParse(_priceController.text) ?? 0.0;
    final double amount = quantity * price;

    setState(() {
      _amountController.text = amount.toStringAsFixed(2);
    });
  }

  @override
  void dispose() {
    _quantityController.dispose();
    _priceController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SelectableTableCell(
          text: widget.item['id'].toString(),
          color: Color.fromARGB(255, 255, 124, 124),
        ),
        _buildTableCell(widget.item['Item'], fieldType: FieldType.autocomplete),
        _buildTableCell(widget.item['UOM']),
        _buildTableCell(_quantityController.text,
            controller: _quantityController),
        _buildTableCell(_priceController.text, controller: _priceController),
        _buildTableCell(_amountController.text,
            controller: _amountController, fieldType: FieldType.amount),
        _buildTableCell(widget.item['Remarks']),
      ],
    );
  }

  Widget _buildTableCell(String text,
      {FieldType fieldType = FieldType.input,
      Color color = Colors.white,
      double width = 100,
      TextEditingController? controller,
      Function(String)? onChanged}) {
    TextEditingController _controller =
        controller ?? TextEditingController(text: text);

    return GestureDetector(
      onLongPress: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text(_controller.text),
            );
          },
        );
      },
      child: Tooltip(
        message: text,
        child: Container(
          width: width,
          height: 50,
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: color,
            border: Border.all(
              color: Colors.black.withOpacity(0.3),
              width: 0.5,
            ),
          ),
          child: fieldType == FieldType.autocomplete
              ? Autocomplete<String>(
                  optionsBuilder: (TextEditingValue textEditingValue) {
                    if (textEditingValue.text.isEmpty) {
                      // Convert suggestions to an Iterable<String>
                      return suggestions
                          .map((option) => option['Item'].toString());
                    }
                    return suggestions
                        .where((option) => option['Item']
                            .toLowerCase()
                            .contains(textEditingValue.text.toLowerCase()))
                        .map((option) => option['Item'].toString());
                  },
                  onSelected: (String selection) {
                    _controller.text = selection;
                    if (onChanged != null) onChanged(selection);
                  },
                  fieldViewBuilder: (BuildContext context,
                      TextEditingController fieldTextEditingController,
                      FocusNode fieldFocusNode,
                      VoidCallback onFieldSubmitted) {
                    fieldTextEditingController.text = text;
                    return TextField(
                      controller: fieldTextEditingController,
                      focusNode: fieldFocusNode,
                      style: TextStyle(fontSize: 10),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 5),
                      ),
                    );
                  },
                  optionsViewBuilder: (BuildContext context,
                      AutocompleteOnSelected<String> onSelected,
                      Iterable<String> options) {
                    return Align(
                      alignment: Alignment.topLeft,
                      child: Material(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        elevation: 4.0,
                        child: Container(
                          width: width + 30,
                          child: ListView.builder(
                            padding: EdgeInsets.all(8.0),
                            shrinkWrap: true,
                            itemCount: options.length,
                            itemBuilder: (BuildContext context, int index) {
                              final option = options.elementAt(index);
                              return GestureDetector(
                                onTap: () => onSelected(option),
                                child: ListTile(
                                  title: Text(
                                    option,
                                    style: TextStyle(fontSize: 10),
                                  ),
                                  tileColor: Colors.white,
                                  hoverColor: Colors.grey[200],
                                  selectedTileColor: Colors.lightBlueAccent,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  },
                )
              : TextField(
                  controller: _controller,
                  style: TextStyle(fontSize: 12),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 5),
                  ),
                  readOnly: fieldType == FieldType.amount,
                  onChanged: (value) {
                    if (onChanged != null) onChanged(value);
                  },
                ),
        ),
      ),
    );
  }
}
