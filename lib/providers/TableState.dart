import 'package:flutter/material.dart';

class SelectedTextState with ChangeNotifier {
  List<String> _selectedTexts = [];

  List<String> get selectedTexts => _selectedTexts;

  void toggleTextSelection(String text) {
    if (_selectedTexts.contains(text)) {
      _selectedTexts.remove(text);
    } else {
      _selectedTexts.add(text);
    }
    notifyListeners();
  }


  void clearSelections() {
    _selectedTexts=[];
    notifyListeners();
  }
}