import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseApi {
  final Firestore _db = Firestore.instance;

  CollectionReference ref;

  FirebaseApi.users() {
    ref = _db.collection('users');
  }

  FirebaseApi.projects() {
    ref = _db.collection('projects');
  }

  FirebaseApi.tasks() {
    ref = _db.collection('tasks');
  }

  Future<QuerySnapshot> getDataCollection() {
    return ref.getDocuments();
  }

  Stream<QuerySnapshot> streamDataCollection() {
    return ref.snapshots();
  }

  Future<DocumentSnapshot> getDocumentById(String id) {
    return ref.document(id).get();
  }

  Future<void> removeDocument(String id) {
    return ref.document(id).delete();
  }

  Future<DocumentReference> addDocument(Map data) {
    return ref.add(data);
  }

  Future<void> updateDocument(Map data, String id) {
    return ref.document(id).updateData(data);
  }
}
