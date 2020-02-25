import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tasker/common/firebaseApi.dart';
import 'package:tasker/models/project.dart';
import 'package:tasker/models/user.dart';

class DatabaseRepository {
  FirebaseApi _usersApi = FirebaseApi.users();
  FirebaseApi _projectsApi = FirebaseApi.users();
  FirebaseApi _tasksApi = FirebaseApi.users();
  final Firestore firestore;

  DatabaseRepository({Firestore firestore})
      : firestore = firestore ?? Firestore.instance;

  Future<DocumentSnapshot> getTasksByUser(String userId) async {
    var tasks = firestore.collection('users').document(userId);
    print(tasks);
    return tasks.get();
  }

  Future<List<Project>> getUsersProjects(String id) async {
    var doc = await _usersApi.getDocumentById(id);
    List list = doc.data['projectList'];
    print(list);
    print('123123123123123');
    return list;
  }
}
