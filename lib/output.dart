import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'calculator.dart';

class ResultScreen extends StatelessWidget {
  ResultScreen({super.key});

  final GPAController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    double gpa = controller.gpa.value; //get the GPA value from the controller
    String guideline = _getGpaGuideline(gpa); //get the GPA guideline

    return Scaffold(
      appBar: AppBar(
        title: const Text('GPA Result', style: TextStyle(color: Colors.white)),
        backgroundColor: Color.fromARGB(255, 0, 46, 110),
        iconTheme: const IconThemeData(color: Colors.white),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Your GPA: ${gpa.toStringAsFixed(2)}', //display the GPA value
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 0, 46, 110),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                guideline, //gisplay the guideline
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18, color: Colors.black87),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () =>
                  Get.back(), //navigate back to the previous screen
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 14, 67, 142),
                foregroundColor: Colors.white,
              ),
              child: const Text("Go Back"),
            ),
          ],
        ),
      ),
    );
  }

  //return a guideline message based on the GPA value
  String _getGpaGuideline(double gpa) {
    if (gpa >= 3.5) {
      return "Excellent work! Keep maintaining your performance.";
    } else if (gpa >= 3.0) {
      return "Good job! Aim for higher grades in future courses.";
    } else if (gpa >= 2.5) {
      return "You're doing well, but consider improving in weak areas.";
    } else if (gpa >= 2.0) {
      return "You're passing, but try to focus on better study habits.";
    } else {
      return "Consider seeking help from tutors or improving your study plan.";
    }
  }
}
