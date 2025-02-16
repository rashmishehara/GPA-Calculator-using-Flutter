import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'calculator.dart';

class InputScreen extends StatelessWidget {
  final GPAController controller = Get.put(GPAController());

  InputScreen() {
    //minimumsix rows
    if (controller.courses.isEmpty) {
      for (int i = 0; i < 6; i++) {
        controller.addCourseRow(); //add more courses
      }
    }
  }
  //InputScreen UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text('GPA Calculator', style: TextStyle(color: Colors.white)),
        backgroundColor: Color.fromARGB(255, 0, 46, 110),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //table header
            Table(
              border: TableBorder.all(),
              columnWidths: const {
                0: FlexColumnWidth(3),
                1: FlexColumnWidth(2),
                2: FlexColumnWidth(2),
              },
              children: [
                TableRow(
                  decoration:
                      BoxDecoration(color: Color.fromARGB(255, 189, 214, 250)),
                  children: [
                    _tableHeader("Course Name"),
                    _tableHeader("Credits"),
                    _tableHeader("Grade"),
                  ],
                ),
              ],
            ),
            Expanded(
              child: Obx(() => SingleChildScrollView(
                    child: Table(
                      border: TableBorder.all(),
                      columnWidths: const {
                        0: FlexColumnWidth(3),
                        1: FlexColumnWidth(2),
                        2: FlexColumnWidth(2),
                      },
                      children: [
                        for (var course in controller.courses)
                          TableRow(
                            decoration: BoxDecoration(color: Colors.white),
                            children: [
                              _textField(course.nameController),
                              _textField(course.creditController,
                                  isNumeric: true),
                              _dropdownMenu(
                                  course), // Dropdown for selecting grade
                            ],
                          ),
                      ],
                    ),
                  )),
            ),
            TextButton(
              onPressed:
                  controller.addCourseRow, // Adds a new course row when pressed
              child: Text("+ Add More Courses",
                  style: TextStyle(color: Color.fromARGB(255, 0, 46, 110))),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _actionButton(
                    "Calculate",
                    Color.fromARGB(255, 14, 67, 142),
                    Colors.white,
                    controller.calculateGPA), // Calculate GPA button
                const SizedBox(width: 20),
                _actionButton("Clear", Colors.grey, Colors.white,
                    controller.clearCourses), // Clear courses button
              ],
            ),
          ],
        ),
      ),
    );
  }

  //create table headers for course, credits, and grade
  Widget _tableHeader(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
          child: Text(text, style: TextStyle(fontWeight: FontWeight.bold))),
    );
  }

  //create a text field for course name or credits
  Widget _textField(TextEditingController controller,
      {bool isNumeric = false}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(border: InputBorder.none),
      ),
    );
  }

  //dropdown menu for grade selection
  Widget _dropdownMenu(Course course) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Obx(() => DropdownButton<String>(
            value: course.grade.value,
            items: [
              "-",
              "A+",
              "A",
              "A-",
              "B+",
              "B",
              "B-",
              "C+",
              "C",
              "C-",
              "D+",
              "D",
              "D-",
              "E"
            ]
                .map((grade) =>
                    DropdownMenuItem(value: grade, child: Text(grade)))
                .toList(),
            onChanged: (newGrade) => course.grade.value = newGrade!,
          )),
    );
  }

  //create buttons
  Widget _actionButton(
      String label, Color bgColor, Color textColor, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColor,
        foregroundColor: textColor,
      ),
      child: Text(label),
    );
  }
}
