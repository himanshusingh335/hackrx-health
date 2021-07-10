import 'package:finserv_health/screens/loginScreen.dart';
import 'package:finserv_health/services/oAuth.dart';
import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    FirebaseAuth.instance.currentUser!.reload();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Settings',
        ),
      ),
      body: SettingsList(
        sections: [
          SettingsSection(
            title: 'Account',
            tiles: [
              SettingsTile(
                  title: 'Email',
                  subtitle: FirebaseAuth.instance.currentUser!.email,
                  trailing: Text(checkVerifyEmail()),
                  leading: Icon(Icons.email)),
              SettingsTile(
                title: 'Change Password',
                leading: Icon(Icons.lock),
                onPressed: (context) {
                  passwordReset(context);
                },
                trailing: IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () async {
                    passwordReset(context);
                    await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Password Reset'),
                            content: Text(
                                'An Email has been sent with the link to reset your password'),
                            actions: [
                              TextButton(
                                child: Text("OK"),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              )
                            ],
                          );
                        });
                  },
                ),
              ),
              SettingsTile(
                  title: 'Sign Out',
                  leading: Icon(Icons.logout),
                  onPressed: (context) {
                    signOut(context);
                  }),
              SettingsTile(
                title: 'Delete Account',
                leading: Icon(Icons.delete),
                onPressed: (context) async {
                  await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("DELETE ACCOUNT"),
                          content: Text(
                              'Are you sure you want to delete you Tether account and all of its data ?'),
                          actions: [
                            TextButton(
                              child: Text(
                                "YES",
                                style: new TextStyle(color: Colors.white),
                              ),
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.red),
                              ),
                              onPressed: () {
                                deleteAccount(context);
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginScreen()),
                                    (Route<dynamic> route) => false);
                              },
                            ),
                            TextButton(
                              child: Text(
                                "NO",
                                style: new TextStyle(color: Colors.white),
                              ),
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.blue),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            )
                          ],
                        );
                      });
                },
              ),
            ],
          ),
          CustomSection(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 22, bottom: 8),
                  child: Text(
                    'Version: 1.0.0',
                    style: TextStyle(color: Color(0xFF777777)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String checkVerifyEmail() {
    if (FirebaseAuth.instance.currentUser!.emailVerified == true) {
      return "VERIFIED";
    }
    return "NOT VERIFIED";
  }

  dynamic changePassword() {}
}
