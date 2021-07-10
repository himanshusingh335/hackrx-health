import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finserv_health/models/users.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<Users> getCurrenUser() async {
  late Users currentUser;
  var futureUser = await FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .get();
  currentUser = Users(
      id: futureUser['userId'],
      name: futureUser['name'],
      role: futureUser['role'],
      mail: futureUser['email']);
  return currentUser;
}
