import 'package:climatter/views/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
   const SignUp({Key? key}) : super(key: key);
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final _auth =  FirebaseAuth.instance;
  var email;
  var password;
  TextEditingController nameController = TextEditingController();



  // @override
  // void initState() async{
  //   await Firebase.initializeApp().whenComplete(() => setState((){}),);
  //   super.initState();
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade700,
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            //Image.asset('assets/climatter_logo.png',),
            SizedBox(
              height: 40.0,
              child: TextField(
                controller: nameController,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.lightBlue.shade700),
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.only(top: 2.0),
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'name',
                  hintStyle: TextStyle(color: Colors.blue),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30.0),
            SizedBox(
              height: 40.0,
              child: TextField(
                onChanged: (value){
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
              obscureText: true,
              onChanged: (value){
                password = value;
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
                hintText: "password",
                hintStyle: TextStyle(color: Colors.blue),
              ),
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () async{
                    try{
                   final newUser = await _auth.createUserWithEmailAndPassword(email: email, password: password);
                      if (newUser != null) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>  LogIn(yourName:nameController.text),
                            ));
                      }
                    }catch(e){
                     rethrow;
                   }
                  },
                  child: const Chip(
                    label: Text(
                      'Sign up',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    backgroundColor: Colors.orange,
                  ),
                ),
                const SizedBox(width: 20.0),
                 InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> LogIn(yourName:nameController.text,)));
                  },
                    child: Text('login', style: TextStyle(color: Colors.white, decoration: TextDecoration.underline),)),
              ],
            )
          ]),
        ),
      ),
    );
  }
}
