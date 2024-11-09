import 'package:flutter/material.dart';

class JournalViewModel extends ChangeNotifier {
  final List<JournalEntry> _entries = [];
  DateTime _selectedDate = DateTime.now();
  TextEditingController entryController = TextEditingController();

  List<JournalEntry> get entries => List.unmodifiable(_entries);
  DateTime get selectedDate => _selectedDate;

  void addEntry(String content) {
    if (content.isEmpty) return;

    _entries.add(JournalEntry(date: _selectedDate, content: content.trim()));
    entryController.clear();
    notifyListeners();
  }

  void deleteEntry(int index) {
    if (index >= 0 && index < _entries.length) {
      _entries.removeAt(index);
      notifyListeners();
    }
  }

  void setDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }
}

class JournalEntry {
  final DateTime date;
  final String content;

  JournalEntry({required this.date, required this.content});
}
