import 'package:flutter/material.dart';

import 'package:finserv_health/screens/settings.dart';
import 'package:finserv_health/services/oAuth.dart';
import 'package:finserv_health/screens/doctorList.dart';

import 'package:firebase_auth/firebase_auth.dart';

class PatientHomeScreen extends StatelessWidget {
  const PatientHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseAuth.instance.currentUser!.reload();
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Bajaj Finserv Health',
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
                  'assets/logo.png',
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
        body: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Flexible(
              flex: 15,
              fit: FlexFit.tight,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  controller: PageController(viewportFraction: 0.84),
                  children: <Widget>[
                    SizedBox(
                      width: 220,
                      child: Card(
                        clipBehavior: Clip.antiAlias,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                'Greyhound divisively hello coldly wonderfully marginally far upon excluding.',
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.6)),
                              ),
                            ),
                            ButtonBar(
                              alignment: MainAxisAlignment.start,
                              children: [
                                FlatButton(
                                  textColor: const Color(0xFF6200EE),
                                  onPressed: () {
                                    // Perform some action
                                  },
                                  child: const Text('ACTION 1'),
                                ),
                                FlatButton(
                                  textColor: const Color(0xFF6200EE),
                                  onPressed: () {
                                    // Perform some action
                                  },
                                  child: const Text('ACTION 2'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 220,
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          return Card(
                            clipBehavior: Clip.antiAlias,
                            child: Stack(
                              alignment: AlignmentDirectional.bottomStart,
                              children: [
                                Image.asset(
                                  'assets/add1.jpg',
                                  width: constraints.maxWidth,
                                  height: constraints.maxHeight,
                                ),
                                ButtonBar(
                                  alignment: MainAxisAlignment.start,
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.share),
                                      onPressed: () {},
                                    )
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      width: 220,
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          return Card(
                            clipBehavior: Clip.antiAlias,
                            child: Stack(
                              alignment: AlignmentDirectional.bottomEnd,
                              children: [
                                Image.asset(
                                  'assets/add2.jpg',
                                  width: constraints.maxWidth,
                                  height: constraints.maxHeight,
                                ),
                                ButtonBar(
                                  alignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.share),
                                      onPressed: () {},
                                    )
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
              flex: 3,
              fit: FlexFit.loose,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Text(
                  'Find Your Specialist\n ',
                  style: TextStyle(fontSize: 22, color: Colors.blue),
                ),
              ),
            ),
            Flexible(
              flex: 25,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DoctorListScreen(
                                  title: 'Available Cardiologists',
                                )),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.all(12.0),
                      padding: EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        child: Text('A'),
                        radius: 40,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                DoctorListScreen(title: 'Available Dentists')),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.all(12.0),
                      padding: EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        child: Text('A'),
                        radius: 40,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DoctorListScreen(
                                title: 'Available ENT specialists')),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.all(12.0),
                      padding: EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        child: Text('A'),
                        radius: 40,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
