import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  final User? user = FirebaseAuth.instance.currentUser;

  Future<void> addTodo(String title) async {
    if (user == null) return;
    await _db.collection("all-todos").doc(user!.uid).collection("todos").add({
      "title": title,
      "dateAdded": FieldValue.serverTimestamp(),
    });
  }

  Future<void> editTodo(String newTitle, String id) async {
    if (user == null) return;
    await _db
        .collection("all-todos")
        .doc(user!.uid)
        .collection("todos")
        .doc(id)
        .update({
      "title": newTitle,
      "dateAdded": FieldValue.serverTimestamp(),
    });
  }

  Stream<List<Map<String, dynamic>>> getTodos() {
    if (user == null) return const Stream.empty();
    return _db
        .collection("all-todos")
        .doc(user!.uid)
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
    if (user == null) return;

    await _db
        .collection("all-todos")
        .doc(user!.uid)
        .collection("todos")
        .doc(id)
        .delete();
  }
}
