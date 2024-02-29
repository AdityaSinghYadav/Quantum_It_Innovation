import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  final String id;
  final String title;
  final String description;
  final bool done;
  final Timestamp? dueDate;
  final Timestamp createDate;
   // Make priority non-nullable and provide a default value

  Task(this.title, this.description, this.id, this.done, this.dueDate,
      this.createDate,) ;

  Task.fromSnapshot(DocumentSnapshot snapshot)
      : id = snapshot.id,
        title = snapshot['title'],
        done = snapshot['done'],
        dueDate = snapshot['due'] as Timestamp?, // Cast dueDate to Timestamp?
        createDate = snapshot['create_at'],
        description = snapshot['description'];
        // Use a default value if priority is null

  // Add a method to check if the dueDate is present
  bool hasDueDate() => dueDate != null;
}
