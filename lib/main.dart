import 'package:finserv_health/provider/colors.dart';
import 'package:finserv_health/provider/payment.dart';
import 'package:finserv_health/screens/doctorHome.dart';
import 'package:flutter/material.dart';

import 'package:finserv_health/screens/loginScreen.dart';
import 'package:finserv_health/screens/patientHome.dart';

import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  enableCatcheDatabase();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppColors>(create: (context) => AppColors()),
        ChangeNotifierProvider<Payment>(create: (context) => Payment()),
      ],
      child: MaterialApp(
        title: 'Bajaj Finserv Health',
        theme: ThemeData.from(
            colorScheme: ColorScheme(
                primary: Colors.purple.shade900,
                primaryVariant: Colors.black87,
                secondary: Colors.purple,
                secondaryVariant: Colors.white,
                surface: Colors.white,
                background: Colors.white,
                error: Colors.red,
                onPrimary: Colors.purple,
                onSecondary: Colors.white,
                onSurface: Colors.purple,
                onBackground: Colors.purple,
                onError: Colors.red,
                brightness: Brightness.light)),
        darkTheme: ThemeData.dark(),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, AsyncSnapshot<User?> snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.data == null) {
                return LoginScreen();
              }
              return FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection('users')
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .get(),
                  builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (snapshot.hasData) {
                      String role = snapshot.data!.get('role');
                      if (role == 'Doctor') {
                        return DoctorHomeScreen();
                      } else
                        return PatientHomeScreen();
                    }
                    return Scaffold(
                      body: Container(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    );
                  });
            } else {
              return Scaffold(
                body: Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

void enableCatcheDatabase() {
  //await FirebaseFirestore.instance.enablePersistence(); //web
  FirebaseFirestore.instance.settings =
      Settings(persistenceEnabled: true); //mobile
  FirebaseFirestore.instance.settings =
      Settings(cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);
}
