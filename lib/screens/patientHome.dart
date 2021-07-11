import 'package:finserv_health/provider/colors.dart';
import 'package:finserv_health/provider/payment.dart';
import 'package:flutter/material.dart';

import 'package:finserv_health/screens/settings.dart';
import 'package:finserv_health/services/oAuth.dart';
import 'package:finserv_health/screens/doctorList.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class PatientHomeScreen extends StatelessWidget {
  const PatientHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseAuth.instance.currentUser!.reload();
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Bajaj Finserv Health',
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
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                Colors.purple.shade900,
                Colors.purple.shade800,
                Colors.purple.shade700,
                Colors.purple.shade400,
                Colors.purple.shade300,
                Colors.purple.shade200
              ])),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Flexible(
                flex: 16,
                fit: FlexFit.tight,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    controller: PageController(viewportFraction: 0.84),
                    children: <Widget>[
                      SizedBox(
                        width: 300,
                        child: Card(
                          clipBehavior: Clip.antiAlias,
                          child: Column(
                            children: [
                              ListTile(
                                leading: Image.asset(
                                  'assets/idea.png',
                                  height: 35,
                                ),
                                title: const Text(
                                  'Did You Know ?',
                                  style: TextStyle(
                                      color: Colors.blue, fontSize: 25),
                                ),
                              ),
                              Image.asset(
                                'assets/expectancy.png',
                                height: 100,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(30, 15, 20, 0),
                                child: Text(
                                    'Between 2000 and 2015, the average global life expectancy increased by five years.',
                                    style: TextStyle(color: Colors.black)),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 300,
                        child: Card(
                          clipBehavior: Clip.antiAlias,
                          child: Column(
                            children: [
                              ListTile(
                                leading: Image.asset(
                                  'assets/cash.png',
                                  height: 35,
                                ),
                                title: const Text(
                                  'Your Health Wallet',
                                  style: TextStyle(
                                      color: Colors.blue, fontSize: 23),
                                ),
                              ),
                              Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 50, 0, 0),
                                  child: Center(
                                    child: Consumer<Payment>(
                                      builder: (context, p, child) {
                                        return Text(
                                          'Rs ' + '${p.amount.toString()}',
                                          style: TextStyle(
                                              color: Colors.green,
                                              fontSize: 50,
                                              fontWeight: FontWeight.bold),
                                        );
                                      },
                                    ),
                                  )),
                            ],
                          ),
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
                  padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                  child: Text(
                    'Find Your Specialist\n ',
                    style:
                        TextStyle(fontSize: 22, color: Colors.purple.shade100),
                  ),
                ),
              ),
              Flexible(
                flex: 25,
                child: Column(
                  children: [
                    Row(
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
                              backgroundColor: Colors.purple.shade100,
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                                child: Image.asset(
                                  'assets/cardio.png',
                                  height: 50,
                                ),
                              ),
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
                                      title: 'Available Dentists')),
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.all(12.0),
                            padding: EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              backgroundColor: Colors.purple.shade100,
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(5, 0, 0, 8),
                                child: Image.asset(
                                  'assets/dentist.png',
                                  height: 55,
                                ),
                              ),
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
                              backgroundColor: Colors.purple.shade100,
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(5, 0, 0, 8),
                                child: Image.asset(
                                  'assets/ent.png',
                                  height: 50,
                                ),
                              ),
                              radius: 40,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DoctorListScreen(
                                        title: 'Available Orthopaedic Surgeons',
                                      )),
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.all(12.0),
                            padding: EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              backgroundColor: Colors.purple.shade100,
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 5, 8),
                                child: Image.asset(
                                  'assets/ortho.png',
                                  height: 50,
                                ),
                              ),
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
                                      title: 'Available  Pediatricians')),
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.all(12.0),
                            padding: EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              backgroundColor: Colors.purple.shade100,
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(5, 0, 0, 8),
                                child: Image.asset(
                                  'assets/pedia.png',
                                  height: 50,
                                ),
                              ),
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
                                      title: 'Available Psychiatrists')),
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.all(12.0),
                            padding: EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              backgroundColor: Colors.purple.shade100,
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 8),
                                child: Image.asset(
                                  'assets/mental.png',
                                  height: 50,
                                ),
                              ),
                              radius: 40,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
