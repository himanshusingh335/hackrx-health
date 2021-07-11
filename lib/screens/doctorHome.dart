import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finserv_health/screens/settings.dart';
import 'package:finserv_health/services/oAuth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DoctorHomeScreen extends StatefulWidget {
  const DoctorHomeScreen({Key? key}) : super(key: key);

  @override
  _DoctorHomeScreenState createState() => _DoctorHomeScreenState();
}

class _DoctorHomeScreenState extends State<DoctorHomeScreen>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed)
      FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({'status': 'online'});
    else
      FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({'status': 'offline'});
  }

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Consultation Requests',
            style: TextStyle(),
          ),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(),
                child: Image.asset(
                  'assets/logo.jpg',
                  height: 130,
                ),
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Settings'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SettingsScreen()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.logout),
                title: Text('Sign out'),
                onTap: () async {
                  signOut(context);
                },
              ),
            ],
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('chats')
              .where(
                'receiverid',
                isEqualTo: FirebaseAuth.instance.currentUser!.uid.toString(),
              )
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var doc = snapshot.data!.docs[index];
                    return Card(
                      child: InkWell(
                        onTap: () async {
                          await canLaunch(
                                  'https://meet.google.com/qko-ydce-mep')
                              ? await launch(
                                  'https://meet.google.com/qko-ydce-mep')
                              : throw 'Could not launch url';
                          FirebaseFirestore.instance
                              .collection('chats')
                              .doc(doc.id)
                              .delete();
                        },
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.brown.shade800,
                            child: const Text('P'),
                          ),
                          title: Text('${doc['senderName']}'),
                          subtitle: Text('You have a new Request !!'),
                          trailing: Icon(Icons.more_vert),
                          isThreeLine: true,
                        ),
                      ),
                    );
                  });
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
