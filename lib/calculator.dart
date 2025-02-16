import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'output.dart';

class GPAController extends GetxController {
  var courses = <Course>[].obs;
  var gpa = 0.0.obs;

  GPAController() {
    _initializeCourses();
  }

  void _initializeCourses() {
    if (courses.isEmpty) {
      for (int i = 0; i < 6; i++) {
        addCourseRow();
      }
    }
  }

  void addCourseRow() {
    courses.add(Course());
    update();
  }

  void clearCourses() {
    courses.clear();
    _initializeCourses();
    update();
  }

  //calculate the GPA
  void calculateGPA() {
    double totalGradePoints = 0;
    int totalCredits = 0;

    for (var course in courses) {
      int credit = int.tryParse(course.creditController.text) ?? 0;
      double gradePoint = _convertGradeToPoint(course.grade.value);
      totalGradePoints += credit * gradePoint;
      totalCredits += credit;
    }

    gpa.value = totalCredits == 0 ? 0 : (totalGradePoints / totalCredits);
    Get.to(() => ResultScreen()); //navigate to the result screen
  }

  //convert the grade to GPA point
  double _convertGradeToPoint(String grade) {
    switch (grade) {
      case 'A+':
        return 4.0;
      case 'A':
        return 4.0;
      case 'A-':
        return 3.7;
      case 'B+':
        return 3.3;
      case 'B':
        return 3.0;
      case 'B-':
        return 2.7;
      case 'C+':
        return 2.3;
      case 'C':
        return 2.0;
      case 'C-':
        return 1.7;
      case 'D+':
        return 1.3;
      case 'D':
        return 1.0;
      case 'D-':
        return 0.7;
      case 'E':
        return 0.0;
      default:
        return 0.0;
    }
  }
}

class Course {
  TextEditingController nameController = TextEditingController();
  TextEditingController creditController = TextEditingController();
  RxString grade = '-'.obs;
}
