import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addTodo(String title) async {
    await _db.collection("todos").add({
      "title": title,
      "dateAdded": FieldValue.serverTimestamp(),
    });
  }

  Stream<List<Map<String, dynamic>>> getTodos() {
    return _db
        .collection('todos')
        .orderBy('dateAdded', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => {
                  'id': doc.id,
                  'title': doc['title'],
                  'dateAdded': (doc['dateAdded'] as Timestamp).toDate(),
                })
            .toList());
  }

  Future<void> removeTodo(String id) async {
    await _db.collection("todos").doc(id).delete();
  }
}
