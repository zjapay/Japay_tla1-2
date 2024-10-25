import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/bmi_model.dart';
import '../widgets/custom_button.dart';

class BMICalculatorScreen extends ConsumerWidget { // Change to ConsumerWidget
  const BMICalculatorScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) { // Use WidgetRef in build method
    final _heightController = TextEditingController();
    final _weightController = TextEditingController();

    void _calculateBMI() {
      final bmiModel = ref.read(bmiProvider); // Use ref to access provider
      final height = double.tryParse(_heightController.text) ?? 0;
      final weight = double.tryParse(_weightController.text) ?? 0;

      if (height > 0 && weight > 0) {
        bmiModel.calculateBMI(height, weight);
      } else {
        bmiModel.clear(); // Reset if input is invalid
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("BMI Calculator"),
        centerTitle: true,
        backgroundColor: Colors.orange[300],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.orange[100]!, Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: _heightController,
                  decoration: InputDecoration(
                    labelText: "Height (cm)",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _weightController,
                  decoration: InputDecoration(
                    labelText: "Weight (kg)",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 20),
                CustomButton(
                  text: "Calculate BMI",
                  onPressed: _calculateBMI, // No need to pass context
                ),
                const SizedBox(height: 20),
                Consumer(
                  builder: (context, ref, child) {
                    final bmiModel = ref.watch(bmiProvider);
                    if (bmiModel.bmiResult.isNotEmpty) {
                      return Column(
                        children: [
                          Text(
                            bmiModel.bmiResult,
                            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            bmiModel.bmiCategory,
                            style: const TextStyle(fontSize: 20, color: Colors.black54),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      );
                    }
                    return Container(); // Empty container if no result
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
