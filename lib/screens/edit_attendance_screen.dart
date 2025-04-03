import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditAttendanceScreen extends StatefulWidget {
  @override
  _EditAttendanceScreenState createState() => _EditAttendanceScreenState();
}

class _EditAttendanceScreenState extends State<EditAttendanceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit Attendance")),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('attendance').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());

          var attendanceDocs = snapshot.data!.docs;

          return ListView.builder(
            itemCount: attendanceDocs.length,
            itemBuilder: (context, index) {
              var data = attendanceDocs[index].data() as Map<String, dynamic>;
              String docId = attendanceDocs[index].id;
              String rollNumber = data['rollNumber'];
              String status = data['status'];

              return ListTile(
                title: Text("Roll No: $rollNumber"),
                subtitle: Text("Status: $status"),
                trailing: DropdownButton<String>(
                  value: status,
                  items: ["Present", "Absent"]
                      .map((status) => DropdownMenuItem(value: status, child: Text(status)))
                      .toList(),
                  onChanged: (newStatus) {
                    FirebaseFirestore.instance
                        .collection('attendance')
                        .doc(docId)
                        .update({'status': newStatus});
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
