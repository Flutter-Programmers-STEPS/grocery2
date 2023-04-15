import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../authentication/email_password_auth.dart';
import '../authentication/google_auth.dart';
import '../home/home_page.dart';
import '../profile/profile_page.dart';
import '../register/register.dart';
import '../validations/validator.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();

  bool _isProcessing = false;

  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();

    User? user = FirebaseAuth.instance.currentUser;

    // if (user != null) {
    //   Navigator.of(context).pushReplacement(
    //     MaterialPageRoute(
    //       builder: (context) => ProfilePage(
    //         user: user,
    //       ),
    //     ),
    //   );
    // }

    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusEmail.unfocus();
        _focusPassword.unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Grocery'),
        ),
        body: FutureBuilder(
          future: _initializeFirebase(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/onboarding_3.jpg",
                      height: 300.0,

                    ),
                    Form(
                      key: _formKey,
                      child: Card(
                        elevation: 10,
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(12),
                              child: TextFormField(
                                controller: _emailTextController,
                                focusNode: _focusEmail,
                                validator: (value) => Validator.validateEmail(
                                  email: value,
                                ),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(20))
                                  ),

                                  hintText: "Email",
                                  errorBorder: UnderlineInputBorder(

                                    borderRadius: BorderRadius.circular(6.0),
                                    borderSide: BorderSide(
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 8.0),
                            Padding(
                              padding: const EdgeInsets.all(12),
                              child: TextFormField(
                                
                                controller: _passwordTextController,
                                focusNode: _focusPassword,
                                obscureText: true,
                                validator: (value) => Validator.validatePassword(
                                  password: value,
                                ),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(20))
                                  ),
                                  hintText: "Password",
                                  errorBorder: UnderlineInputBorder(
                                    borderRadius: BorderRadius.circular(6.0),
                                    borderSide: BorderSide(
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 24.0),
                            _isProcessing
                                ? CircularProgressIndicator()
                                : Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(

                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context).size.width,
                                          height: 40,
                                          child: ElevatedButton(
                                              onPressed: () async {
                                                _focusEmail.unfocus();
                                                _focusPassword.unfocus();

                                                if (_formKey.currentState!
                                                    .validate()) {
                                                  setState(() {
                                                    _isProcessing = true;
                                                  });

                                                  User? user = await FireAuth
                                                      .signInUsingEmailPassword(
                                                    email: _emailTextController.text,
                                                    password:
                                                        _passwordTextController.text,
                                                  );

                                                  setState(() {
                                                    _isProcessing = false;
                                                  });

                                                  if (user != null) {
                                                    Navigator.of(context)
                                                        .pushReplacement(
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            ProfilePage(user: user),
                                                      ),
                                                    );
                                                  }
                                                }
                                              },
                                              child: Text(
                                                'Sign In',
                                                style: TextStyle(color: Colors.white),
                                              ),
                                            ),
                                        ),

                                        SizedBox(width: 24.0),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SizedBox(
                                              width: MediaQuery.of(context).size.width,
                                              height: 40,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [

                                                  TextButton(
                                                    style: ButtonStyle(),
                                                    onPressed: () {

                                                      signInWithGoogle().then((result) {

                                                        if (result != null) {
                                                          Navigator.of(context).push(
                                                            MaterialPageRoute(
                                                              builder: (context) {

                                                                return HomePage();
                                                              },
                                                            ),
                                                          );
                                                        }
                                                      });

                                                    },
                                                    child:  Text('Google Sign In',style: TextStyle(color: Colors.black),),
                                                  ),
                                                ],
                                              ),
                                            ),

                                          ),
                                        
                                      Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: TextButton(
                                              onPressed: () {
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        RegisterPage(),
                                                  ),
                                                );
                                              },
                                              child: Text(
                                                'Register',
                                                style: TextStyle(color: Colors.black),
                                              ),
                                            ),
                                      ),

                                      ],
                                    ),
                                )
                          ],
                        ),
                      ),
                    ),

                  ],
                ),
              );
            }

            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
