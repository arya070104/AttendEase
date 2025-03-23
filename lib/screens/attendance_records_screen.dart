import 'package:flutter/material.dart';

class AttendanceRecordsScreen extends StatelessWidget {
  final List<Map<String, String>> attendanceData = [
    {"student_id": "22CSU414", "timestamp": "2025-03-21 10:00 AM"},
    {"student_id": "22CSU415", "timestamp": "2025-03-21 10:05 AM"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Attendance Records")),
      body: ListView.builder(
        itemCount: attendanceData.length,
        itemBuilder: (context, index) {
          var record = attendanceData[index];
          return ListTile(
            title: Text("Student ID: ${record['student_id']}"),
            subtitle: Text("Time: ${record['timestamp']}"),
          );
        },
      ),
    );
  }
}
