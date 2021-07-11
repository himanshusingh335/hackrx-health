import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> logIn(
  TextEditingController email,
  TextEditingController password,
  BuildContext context,
) async {
  await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email.text.trim(), password: password.text);
  FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .update({'status': 'online'});
}

Future<void> signUp(
  TextEditingController email,
  TextEditingController password,
  TextEditingController name,
  String role,
  BuildContext context,
) async {
  await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email.text.trim(), password: password.text);

  sendEmailVerification();

  await FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .set({
    "userId": FirebaseAuth.instance.currentUser!.uid,
    "name": name.text.trim(),
    "email": email.text.trim(),
    "role": role,
    "status": 'offline'
  });
}

Future<void> sendEmailVerification() async {
  await FirebaseAuth.instance.currentUser!.sendEmailVerification();
}

Future<void> passwordReset(BuildContext context) async {
  await FirebaseAuth.instance.sendPasswordResetEmail(
    email: FirebaseAuth.instance.currentUser!.email!,
  );
}

Future<void> forgotPassword(
  TextEditingController email,
  BuildContext context,
) async {
  await FirebaseAuth.instance.sendPasswordResetEmail(
    email: email.text.trim(),
  );
}

Future<void> deleteAccount(BuildContext context) async {
  try {
    await FirebaseAuth.instance.currentUser!.delete();
  } on FirebaseAuthException catch (e) {
    if (e.code == 'requires-recent-login') {
      await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("REQUIRES-RECENT-LOGIN"),
              content: Text(
                  'The user must reauthenticate before this operation can be executed.'),
              actions: [
                TextButton(
                  child: Text(
                    "SIGNOUT",
                    style: new TextStyle(color: Colors.white),
                  ),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.red),
                  ),
                  onPressed: () {
                    signOut(context);
                  },
                ),
              ],
            );
          });
    }
  }
}

Future<void> signOut(BuildContext context) async {
  FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .update({'status': 'offline'});
  FirebaseAuth auth = FirebaseAuth.instance;
  await auth.signOut();
}
