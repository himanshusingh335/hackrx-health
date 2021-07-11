import 'package:finserv_health/provider/colors.dart';
import 'package:finserv_health/screens/signupScreen.dart';
import 'package:flutter/material.dart';

import 'package:finserv_health/services/oAuth.dart';
import 'package:finserv_health/components/customTextField.dart';

import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final _formKey;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late bool _isLoading;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
                    textController: _emailController,
                    labelText: 'EMAIL',
                    icon: Icons.email_outlined,
                    isEMail: true,
                    validatorIsEmpty: 'Enter Email Address',
                    validatorError: 'Please enter a valid email address!',
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
                    )),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 30, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(
                              color:
                                  Provider.of<AppColors>(context, listen: false)
                                      .myBlue,
                              fontSize: 15,
                            ),
                          ),
                          onTap: () {
                            forgotPassword(_emailController, context)
                                .catchError((err) {
                              showDialog(
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
                                                MaterialStateProperty.all<
                                                    Color>(Colors.blue),
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
                            });
                          }),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
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
                                onPressed: () async {
                                  if (_formKey.currentState.validate()) {
                                    setState(() {
                                      _isLoading = true;
                                    });
                                    await logIn(
                                      _emailController,
                                      _passwordController,
                                      context,
                                    ).catchError((err) {
                                      showDialog(
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
                                                    Navigator.pop(context);
                                                    setState(() {
                                                      _isLoading = false;
                                                    });
                                                  },
                                                )
                                              ],
                                            );
                                          });
                                    });
                                  }
                                },
                                child: Text(
                                  'LOGIN',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: GestureDetector(
                      child: Text(
                        "New User? Sign Up using Email",
                        style: TextStyle(
                          color: Provider.of<AppColors>(context, listen: false)
                              .myBlue,
                          fontSize: 16,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignupScreen()),
                        );
                      }),
                ),
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
    _emailController.dispose();
    _passwordController.dispose();
  }
}
