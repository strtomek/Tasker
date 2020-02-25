import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserRepository {
  final FirebaseAuth _firebaseAuth;

  UserRepository({FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  Future<void> signInWithCredentials(String email, String password) {
    return _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<String> getUserId() async {
    var user = await _firebaseAuth.currentUser();
    return user.uid;
  }

  Future<void> signUpWithCredentials(String email, String password) {
    return _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> signOut() async {
    return Future.wait([
      _firebaseAuth.signOut(),
    ]);
  }

  Future<bool> isSignedIn() async {
    final currentUser = await _firebaseAuth.currentUser();
    return currentUser != null;
  }

  Future<String> getUser() async {
    return (await _firebaseAuth.currentUser()).email;
  }

  Future<void> signUp(
      String email, String password, String firstName, String lastName) async {
    return _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then(
          (onValue) => {
            addUserToDatabase(onValue.user.uid, firstName, lastName),
          },
        )
        .catchError(
          (onError) => {
            print(onError),
          },
        );
  }

  Future<void> addUserToDatabase(
      String userId, String firstName, String lastName) {
    return Firestore.instance.collection("users").document(userId).setData({
      'firstName': firstName,
      'lastName': lastName,
    });
  }
}
