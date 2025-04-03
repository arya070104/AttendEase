import 'package:flutter/material.dart';

class TimetableScreen extends StatelessWidget {
  // Sample timetable data (Replace with actual data from Firestore)
  final List<Map<String, String>> timetable = [
    {
      "date": "Mon, Apr 1",
      "subject": "Mathematics",
      "time": "9:00 AM - 10:30 AM",
      "room": "101",
      "teacher": "Mr. Smith"
    },
    {
      "date": "Tue, Apr 2",
      "subject": "Physics",
      "time": "11:00 AM - 12:30 PM",
      "room": "202",
      "teacher": "Dr. Johnson"
    },
    {
      "date": "Wed, Apr 3",
      "subject": "Chemistry",
      "time": "2:00 PM - 3:30 PM",
      "room": "303",
      "teacher": "Mrs. Brown"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Timetable")),
      body: ListView.builder(
        itemCount: timetable.length,
        itemBuilder: (context, index) {
          final entry = timetable[index];
          return Card(
            margin: EdgeInsets.all(10),
            child: ListTile(
              title: Text(entry["subject"] ?? "", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("📅 ${entry["date"]}"),
                  Text("⏰ ${entry["time"]}"),
                  Text("🏫 Room: ${entry["room"]}"),
                  Text("👨‍🏫 Teacher: ${entry["teacher"]}"),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
