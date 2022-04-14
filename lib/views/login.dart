import 'package:climatter/views/signup_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key, required this.yourName, }) : super(key: key);
  final String yourName;
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  TextEditingController emailController =  TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  var email;
  var password;
  var isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade700,
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            //Image.asset('assets/climatter_logo.png',),

            const SizedBox(height: 30.0),
            SizedBox(
              height: 40.0,
              child: TextField(
                controller: emailController,
                onChanged: (value) {
                  email = value;
                },
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.lightBlue.shade700,
                ),
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.only(top: 2.0),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "email",
                  hintStyle: TextStyle(color: Colors.blue),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            TextField(
              controller: passwordController,
              obscureText: true,
              onChanged: (value) {
                password = value;
              },
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.lightBlue.shade700,
              ),
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.only(top: 2.0, ),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                ),
                filled: true,
                fillColor: Colors.white,
                hintText: "password",
                hintStyle: TextStyle(color: Colors.blue),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const SignUp();
                      }));
                    },
                    child: const Text(
                      'Sign up',
                      style: TextStyle(
                          color: Colors.white,
                          decoration: TextDecoration.underline),
                    )),
                const SizedBox(width: 10.0),
                InkWell(
                  onTap: () async {
                    try {
                      final user = await _auth.signInWithEmailAndPassword(email: email, password: password);
                      if (user != null) {
                        // isLoading = true;
                        // isLoading? const Center(
                        //     child:CircularProgressIndicator()):
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>  HomePage(yourNameLastBustop: widget.yourName, emailC:emailController.text, passwordC:passwordController.text),
                            ));
                      }
                    } catch (e) {
                      rethrow;
                    }
                    // emailController.clear();
                   //  passwordController.clear();
                   // emailController.dispose();
                   // passwordController.dispose();
                  },
                  child: const Chip(
                    label: Text(
                      'Log in',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    backgroundColor: Colors.orange,
                  ),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                const Text('forgot password?',
                    style: TextStyle(
                        color: Colors.white,
                        decoration: TextDecoration.underline)),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
