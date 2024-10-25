import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class BMIMeasurement extends ChangeNotifier {
  String _bmiResult = '';
  String _bmiCategory = '';

  String get bmiResult => _bmiResult;
  String get bmiCategory => _bmiCategory;

  void calculateBMI(double height, double weight) {
    if (height > 0 && weight > 0) {
      _bmiResult = (weight / ((height / 100) * (height / 100))).toStringAsFixed(2);
      _bmiCategory = _getBMICategory(_bmiResult);
      notifyListeners();
    }
  }

  void clear() {
    _bmiResult = '';
    _bmiCategory = '';
    notifyListeners();
  }

  String _getBMICategory(String bmi) {
    double bmiValue = double.tryParse(bmi) ?? 0;
    if (bmiValue < 18.5) return "Underweight";
    if (bmiValue < 24.9) return "Normal weight";
    if (bmiValue < 29.9) return "Overweight";
    return "Obesity";
  }
}

final bmiProvider = ChangeNotifierProvider<BMIMeasurement>((ref) {
  return BMIMeasurement();
});
