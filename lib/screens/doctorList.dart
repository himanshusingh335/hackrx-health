import 'package:finserv_health/models/users.dart';
import 'package:finserv_health/services/database.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

class DoctorListScreen extends StatelessWidget {
  const DoctorListScreen({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          this.title,
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .where('role', isEqualTo: 'Doctor')
            .where('status', isEqualTo: 'online')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }
          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var doc = snapshot.data!.docs[index];
                return Card(
                  child: InkWell(
                    onTap: () async {
                      Users currentUser = await getCurrenUser();
                      FirebaseFirestore.instance.collection('chats').add({
                        'senderid': FirebaseAuth.instance.currentUser!.uid,
                        'senderName': currentUser.name.toString(),
                        'receiverid': doc['userId'],
                      });
                      await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("CONSULTATION APPROVED"),
                              content: Text(
                                  'Consultation fee of Rs80/- has been deducted from your Health Money Wallet\n\n The Doctor will be with you shortly'),
                              actions: [
                                TextButton(
                                  child: Text(
                                    "OK!",
                                    style: new TextStyle(color: Colors.white),
                                  ),
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.blue),
                                  ),
                                  onPressed: () async {
                                    await canLaunch(
                                            'https://meet.google.com/qko-ydce-mep')
                                        ? await launch(
                                            'https://meet.google.com/qko-ydce-mep')
                                        : throw 'Could not launch url';

                                    Navigator.pop(context);
                                  },
                                )
                              ],
                            );
                          });
                    },
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.brown.shade800,
                        child: const Text('Dr'),
                      ),
                      title: Text('${doc['name']}'),
                      subtitle: Text(
                        'Online',
                        style: new TextStyle(color: Colors.green),
                      ),
                      trailing: Icon(
                        Icons.video_call,
                        size: 60,
                        color: Colors.green,
                      ),
                    ),
                  ),
                );
              });
        },
      ),
    );
  }
}
