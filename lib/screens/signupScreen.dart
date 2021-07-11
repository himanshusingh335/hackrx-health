import 'dart:ui';
import 'package:flutter/material.dart';

import 'package:finserv_health/components/customTextField.dart';
import 'package:finserv_health/provider/colors.dart';
import 'package:finserv_health/services/oAuth.dart';
import 'package:finserv_health/screens/loginScreen.dart';

import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  late final List<String> _listOfRoles;
  late String _roleDropDownValue;
  late final _formKey;
  late final TextEditingController _emailController;
  late final TextEditingController _nameController;
  late final TextEditingController _passwordController;
  late bool _isLoading;

  @override
  void initState() {
    super.initState();
    _listOfRoles = ['Doctor', 'Patient'];
    _roleDropDownValue = "Patient";
    _formKey = GlobalKey<FormState>();
    _emailController = TextEditingController();
    _nameController = TextEditingController();
    _passwordController = TextEditingController();
    _isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 50, 10, 50),
                  child: Center(
                    child: Image.asset(
                      'assets/logo.png',
                      height: 70,
                    ),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: CustomTextField(
                      labelText: 'NAME',
                      textController: _nameController,
                      icon: Icons.account_circle_outlined,
                      validatorIsEmpty: 'Please Enter Your Name',
                      validatorError: '',
                    )),
                Padding(
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: CustomTextField(
                      labelText: 'EMAIL',
                      isEMail: true,
                      textController: _emailController,
                      icon: Icons.email_outlined,
                      validatorError: 'Please enter a valid email address!',
                      validatorIsEmpty: 'Enter Email Address',
                    )),
                Padding(
                  padding: EdgeInsets.fromLTRB(25, 20, 25, 0),
                  child: Card(
                    elevation: 0,
                    child: DropdownButtonFormField(
                      value: _roleDropDownValue,
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: Provider.of<AppColors>(context, listen: false)
                            .myRed,
                      ),
                      elevation: 5,
                      style: TextStyle(
                        color: Provider.of<AppColors>(context, listen: false)
                            .myBlue,
                      ),
                      decoration: InputDecoration(
                        labelText: 'ROLE',
                        labelStyle: TextStyle(
                            color:
                                Provider.of<AppColors>(context, listen: false)
                                    .myBlue,
                            fontWeight: FontWeight.bold),
                        prefixIcon: Icon(Icons.person,
                            color:
                                Provider.of<AppColors>(context, listen: false)
                                    .myRed),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Theme.of(context).cardColor),
                        ),
                      ),
                      items: _listOfRoles.map((String value) {
                        return new DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _roleDropDownValue = newValue!;
                        });
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: CustomTextField(
                    textController: _passwordController,
                    labelText: 'PASSWORD',
                    icon: Icons.lock_outline,
                    isPassword: true,
                    validatorIsEmpty: '',
                    validatorError: '',
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(25, 15, 25, 0),
                  child: _isLoading == true
                      ? CircularProgressIndicator()
                      : Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Provider.of<AppColors>(context,
                                                    listen: false)
                                                .myRed),
                                  ),
                                  child: Text(
                                    'CREATE ACCOUNT',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  onPressed: () async {
                                    if (_formKey.currentState.validate()) {
                                      setState(() {
                                        _isLoading = true;
                                      });
                                      signUp(
                                              _emailController,
                                              _passwordController,
                                              _nameController,
                                              _roleDropDownValue,
                                              context)
                                          .catchError((err) async {
                                        await showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Text("ERROR"),
                                                content: Text(err.message),
                                                actions: [
                                                  TextButton(
                                                    child: Text(
                                                      "OK",
                                                      style: new TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                    style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all<Color>(
                                                                  Colors.blue),
                                                    ),
                                                    onPressed: () {
                                                      Navigator.pushAndRemoveUntil(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  LoginScreen()),
                                                          (Route<dynamic>
                                                                  route) =>
                                                              false);

                                                      setState(() {
                                                        _isLoading = false;
                                                      });
                                                    },
                                                  )
                                                ],
                                              );
                                            });
                                      });
                                      await showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text('EMAIL VERIFICATION'),
                                              content: Text(
                                                  'An Email has been sent with the link to verify your email address'),
                                              actions: [
                                                TextButton(
                                                  child: Text(
                                                    "OK",
                                                    style: new TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 20.0,
                                                        color: Colors.white),
                                                  ),
                                                  style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all<Color>(
                                                                Colors.blue),
                                                  ),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                    setState(() {
                                                      _isLoading = false;
                                                    });
                                                  },
                                                )
                                              ],
                                            );
                                          });
                                      Navigator.pop(context);
                                    }
                                  }),
                            ),
                          ],
                        ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: GestureDetector(
                    child: Text(
                      'Already have an account? Go back',
                      style: TextStyle(
                          color: Provider.of<AppColors>(context).myBlue,
                          fontSize: 16),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }
}
