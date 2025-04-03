import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  final List<Map<String, String>> timetable = const [
    {
      'date': 'March 29, 2025',
      'subject': 'Mathematics',
      'timing': '10:00 AM - 11:00 AM',
      'room': '101',
      'teacher': 'Mr. Smith'
    },
    {
      'date': 'March 29, 2025',
      'subject': 'Physics',
      'timing': '11:15 AM - 12:15 PM',
      'room': '202',
      'teacher': 'Dr. Johnson'
    },
    {
      'date': 'March 29, 2025',
      'subject': 'Chemistry',
      'timing': '1:00 PM - 2:00 PM',
      'room': '303',
      'teacher': 'Mrs. Williams'
    },
    {
      'date': 'March 29, 2025',
      'subject': 'Computer Science',
      'timing': '2:15 PM - 3:15 PM',
      'room': '404',
      'teacher': 'Mr. Brown'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Timetable Schedule"),
        backgroundColor: const Color(0xFF075E54), // WhatsApp Green
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: timetable.length,
          itemBuilder: (context, index) {
            final entry = timetable[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              elevation: 3,
              child: ListTile(
                title: Text(
                  "${entry['subject']} (${entry['timing']})",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  "Room: ${entry['room']}  |  Teacher: ${entry['teacher']}",
                ),
                leading: CircleAvatar(
                  backgroundColor: Colors.teal,
                  child: Text(entry['subject']![0]), // First letter of subject
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
