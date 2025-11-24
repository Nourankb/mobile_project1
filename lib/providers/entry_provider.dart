import 'package:flutter/material.dart';
import '../models/entry.dart';

class EntryProvider extends ChangeNotifier {
  final List<CarbonEntry> _entries = [];
  bool _isDarkMode = false;

  // Add a new entry
  void addEntry(CarbonEntry entry) {
    _entries.add(entry);
    notifyListeners();
  }

  // Calculate total carbon score for an entry
  int calculateCarbonScore(CarbonEntry entry) {
    return _scoreTransport(entry.transport) +
        _scoreFood(entry.food) +
        _scoreEnergy(entry.energy);
  }

  // Clear all entries
  void clearAll() {
    _entries.clear();
    notifyListeners();
  }

  // Getter for entries list
  List<CarbonEntry> get entries => _entries;

  // 🌗 Theme toggle
  bool get isDarkMode => _isDarkMode;
  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  // 📊 Aggregate carbon data
  Map<String, int> get carbonData {
    int transportScore = 0;
    int foodScore = 0;
    int energyScore = 0;

    for (var entry in _entries) {
      transportScore += _scoreTransport(entry.transport);
      foodScore += _scoreFood(entry.food);
      energyScore += _scoreEnergy(entry.energy);
    }

    return {
      'Transport': transportScore,
      'Food': foodScore,
      'Energy': energyScore,
    };
  }

  // 🚗 Transport scoring
  int _scoreTransport(String value) {
    switch (value) {
      case 'Car': return 30;
      case 'Bus': return 15;
      case 'Bike': return 0;
      case 'Train': return 10;          // efficient public transport
      case 'Walking': return 0;         // no emissions
      case 'Electric Car': return 5;    // lower than petrol cars
      default: return 10;
    }
  }

  // 🍽️ Food scoring
  int _scoreFood(String value) {
    switch (value) {
      case 'Meat': return 40;
      case 'Vegetarian': return 20;
      case 'Vegan': return 10;
      case 'Pescatarian': return 25;    // fish-based diet, lower than meat
      case 'Flexitarian': return 30;    // mixed diet, moderate impact
      default: return 15;
    }
  }

  // ⚡ Energy scoring
  int _scoreEnergy(String value) {
    switch (value) {
      case 'High': return 30;
      case 'Medium': return 20;
      case 'Low': return 10;
      case 'Solar': return 2;           // renewable, very low impact
      case 'Wind': return 2;            // renewable, very low impact
      case 'Mixed': return 15;          // partial renewable, moderate impact
      default: return 15;
    }
  }
}