// full_screen_alert_dialog.dart

import 'dart:math';
import 'package:datagrid/providers/TableState.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

List<Map<String, dynamic>> suggestions = [
  {
    'id': 1,
    'Item': '001/Laptop Charger',
    'UOM': 'Each',
    'quantity': 1,
    'price': 45.99,
    'Amount': 1 * 45.99,
    'Remarks': '',
  },
  {
    'id': 2,
    'Item': '002/Ipad',
    'UOM': 'Each',
    'quantity': 1,
    'price': 329.00,
    'Amount': 1 * 329.00,
    'Remarks': '',
  },
  {
    'id': 3,
    'Item': '003/Iphone',
    'UOM': 'Each',
    'quantity': 1,
    'price': 999.00,
    'Amount': 1 * 999.00,
    'Remarks': '',
  },
  {
    'id': 4,
    'Item': '004/Samsung S21',
    'UOM': 'Each',
    'quantity': 1,
    'price': 799.99,
    'Amount': 1 * 799.99,
    'Remarks': '',
  },
  {
    'id': 5,
    'Item': '005/Oneplus Buds Pro',
    'UOM': 'Each',
    'quantity': 1,
    'price': 149.99,
    'Amount': 1 * 149.99,
    'Remarks': '',
  },
  {
    'id': 6,
    'Item': '006/Realme Phone',
    'UOM': 'Each',
    'quantity': 1,
    'price': 199.00,
    'Amount': 1 * 199.00,
    'Remarks': '',
  },
];

class FullScreenAlertDialog extends StatefulWidget {
  const FullScreenAlertDialog({super.key});

  @override
  _FullScreenAlertDialogState createState() => _FullScreenAlertDialogState();
}

class _FullScreenAlertDialogState extends State<FullScreenAlertDialog> {
  late TextEditingController idController;
  late TextEditingController itemController;
  late TextEditingController uomController;
  late TextEditingController qtyController;
  late TextEditingController priceController;
  late TextEditingController amountController;
  late TextEditingController remarksController;

  @override
  void initState() {
    super.initState();
    idController = TextEditingController(
      text: Random().nextInt(500).toString(),
    );
    itemController = TextEditingController(text: "");
    uomController = TextEditingController(text: "");
    qtyController = TextEditingController(text: "0");
    priceController = TextEditingController(text: "0.00");
    amountController = TextEditingController(text: "0.00");
    remarksController = TextEditingController(text: "");

    // Add listeners to update amount when quantity or price changes
    qtyController.addListener(_updateAmount);
    priceController.addListener(_updateAmount);
  }

  @override
  void dispose() {
    qtyController.removeListener(_updateAmount);
    priceController.removeListener(_updateAmount);
    qtyController.dispose();
    priceController.dispose();
    amountController.dispose();
    super.dispose();
  }

  void _updateAmount() {
    final qty = double.tryParse(qtyController.text) ?? 0.0;
    final price = double.tryParse(priceController.text) ?? 0.0;
    final amount = qty * price;
    setState(() {
      amountController.text = amount.toStringAsFixed(2);
    });
  }

  void _submitData() {
    if (itemController.text.isEmpty) {
      _showAlertDialog('Error', 'Item field is mandatory.');
      return;
    }

    final data = [
      idController.text,
      itemController.text,
      uomController.text,
      qtyController.text,
      priceController.text,
      amountController.text,
      remarksController.text,
    ];
    Navigator.of(context).pop(data); // Return the data to the caller
  }

  void _cancel() {
    Navigator.of(context)
        .pop(); // Simply close the dialog without returning data
  }

  void _showAlertDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _onItemSelected(Map<String, dynamic> selectedItem) {
    print('heere is ${selectedItem["Item"]}');
    setState(() {
      itemController.text = selectedItem['Item'];
      uomController.text = selectedItem['UOM'];
      qtyController.text = selectedItem['quantity'].toString();
      priceController.text = selectedItem['price'].toStringAsFixed(2);
      amountController.text = selectedItem['Amount'].toStringAsFixed(2);
      remarksController.text = selectedItem['Remarks'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Align(
        alignment: Alignment.center,
        child: Dialog(
          insetPadding: EdgeInsets.all(0),
          child: Container(
            width: MediaQuery.of(context).size.width - 20,
            height: MediaQuery.of(context).size.height - 150,
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Add Row',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: idController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'ID',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  ),
                  style: TextStyle(fontSize: 14),
                  readOnly: true, // Make ID field read-only
                ),
                SizedBox(height: 8),
                Autocomplete<Map<String, dynamic>>(
                  optionsBuilder: (TextEditingValue textEditingValue) {
                    if (textEditingValue.text.isEmpty) {
                      return suggestions; // Show all suggestions when empty
                    }
                    return suggestions.where((Map<String, dynamic> option) {
                      return option['Item']
                          .toLowerCase()
                          .contains(textEditingValue.text.toLowerCase());
                    });
                  },
                  displayStringForOption: (Map<String, dynamic> option) =>
                      option['Item'],
                  onSelected: (Map<String, dynamic> selection) {
                    _onItemSelected(selection);
                  },
                  fieldViewBuilder: (BuildContext context,
                      TextEditingController fieldTextEditingController,
                      FocusNode fieldFocusNode,
                      VoidCallback onFieldSubmitted) {
                    return TextField(
                      controller: fieldTextEditingController,
                      focusNode: fieldFocusNode,
                      style: TextStyle(fontSize: 14),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Select Item",
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                      ),
                    );
                  },
                  optionsViewBuilder: (BuildContext context,
                      AutocompleteOnSelected<Map<String, dynamic>> onSelected,
                      Iterable<Map<String, dynamic>> options) {
                    return Align(
                      alignment: Alignment.topLeft,
                      child: Material(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        elevation: 4.0,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.8,
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
                                    option['Item'],
                                    style: TextStyle(fontSize: 14),
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
                ),
                SizedBox(height: 8),
                TextField(
                  controller: uomController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'UOM',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  ),
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(height: 8),
                TextField(
                  controller: qtyController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Quantity',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  ),
                  style: TextStyle(fontSize: 14),
                  keyboardType: TextInputType.number, // Allow number input
                ),
                SizedBox(height: 8),
                TextField(
                  controller: priceController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Price',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  ),
                  style: TextStyle(fontSize: 14),
                  keyboardType: TextInputType.number, // Allow number input
                ),
                SizedBox(height: 8),
                TextField(
                  controller: amountController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Amount',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  ),
                  readOnly: true,
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(height: 8),
                TextField(
                  controller: remarksController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Remarks',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  ),
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: _submitData,
                      child: Text(
                        'Submit',
                        style: TextStyle(
                            color: const Color.fromARGB(255, 252, 139, 139)),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: _cancel,
                      child: Text(
                        'Cancel',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 240, 134, 127),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SelectableTableCell extends StatefulWidget {
  final String text;
  final Color color;
  final double width;

  const SelectableTableCell({
    Key? key,
    required this.text,
    this.color = Colors.white,
    this.width = 30,
  }) : super(key: key);

  @override
  _SelectableTableCellState createState() => _SelectableTableCellState();
}

class _SelectableTableCellState extends State<SelectableTableCell> {
  bool _isSelected = false;

  void _toggleSelection() {
    final selectedTextState =
        Provider.of<SelectedTextState>(context, listen: false);

    setState(() {
      _isSelected = !_isSelected;
    });

    selectedTextState.toggleTextSelection(widget.text);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final selectedTextState = Provider.of<SelectedTextState>(context);
    if (selectedTextState.selectedTexts.isEmpty && _isSelected) {
      setState(() {
        _isSelected = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: _toggleSelection,
      child: Container(
        width: widget.width,
        height: 50,
        decoration: BoxDecoration(
          color: _isSelected ? widget.color : Colors.transparent,
          border: Border.all(
            color:
                _isSelected ? Color.fromARGB(255, 247, 113, 113) : Colors.grey,
            width: 0.5,
          ),
        ),
        child: Center(
          child: Text(
            "",
            style: TextStyle(
              color: _isSelected ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
