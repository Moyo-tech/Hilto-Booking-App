import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:hospital_app/screens/doctor/doctormain.dart';
import 'package:hospital_app/main.dart';
import 'package:hospital_app/screens/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:page_transition/page_transition.dart';
import 'package:hospital_app/screens/doctor/doctormain.dart';

class LoginPage extends StatefulWidget {

  
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isObscure3 = true;
  bool visible = false;
  final _formkey = GlobalKey<FormState>();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromRGBO(253, 255, 255, 1),
                      Color.fromRGBO(14, 2, 85, 1),
                    ]),
              ),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 1.0,
              child: Center(
                child: Container(
                  margin: EdgeInsets.all(12),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        Text("Hilto",
                            style: TextStyle(
                              decoration: TextDecoration.none,
                              color: Colors.white,
                              fontSize: 48.0,
                              fontWeight: FontWeight.w800,
                            )),
                        Container(
                          width: 161,
                          height: 40,
                          padding: EdgeInsets.symmetric(vertical: 10.0),
                          decoration: BoxDecoration(
                              color: Color(0xffC10450),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50.0))),
                          child: Text(
                            "medical center",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontStyle: FontStyle.italic,
                              decoration: TextDecoration.none,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Email',
                            enabled: true,
                            contentPadding: const EdgeInsets.only(
                                left: 14.0, bottom: 8.0, top: 8.0),
                            focusedBorder: OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.white),
                              borderRadius: new BorderRadius.circular(10),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: new BorderSide(color: Colors.white),
                              borderRadius: new BorderRadius.circular(10),
                            ),
                          ),
                          validator: (value) {
                            if (value!.length == 0) {
                              return "Email cannot be empty";
                            }
                            if (!RegExp(
                                    "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                .hasMatch(value)) {
                              return ("Please enter a valid email");
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) {
                            emailController.text = value!;
                          },
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: passwordController,
                          obscureText: _isObscure3,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                                icon: Icon(_isObscure3
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                                onPressed: () {
                                  setState(() {
                                    _isObscure3 = !_isObscure3;
                                  });
                                }),
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Password',
                            enabled: true,
                            contentPadding: const EdgeInsets.only(
                                left: 14.0, bottom: 8.0, top: 15.0),
                            focusedBorder: OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.white),
                              borderRadius: new BorderRadius.circular(10),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: new BorderSide(color: Colors.white),
                              borderRadius: new BorderRadius.circular(10),
                            ),
                          ),
                          validator: (value) {
                            RegExp regex = new RegExp(r'^.{6,}$');
                            if (value!.isEmpty) {
                              return "Password cannot be empty";
                            }
                            if (!regex.hasMatch(value)) {
                              return ("please enter valid password min. 6 character");
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) {
                            passwordController.text = value!;
                          },
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Align(
                            alignment: Alignment.centerRight,
                            child: MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
                              elevation: 5.0,
                              height: 40,
                              onPressed: () {
                                setState(() {
                                  visible = true;
                                });
                                signIn(emailController.text,
                                    passwordController.text);
                              },
                              child: Text(
                                "Login",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Color.fromRGBO(4, 2, 85, 1),
                                ),
                              ),
                              color: Colors.white,
                            )),
                        SizedBox(
                          height: 10,
                        ),
                        Visibility(
                            maintainSize: true,
                            maintainAnimation: true,
                            maintainState: true,
                            visible: visible,
                            child: Container(
                                child: CircularProgressIndicator(
                              color: Colors.white,
                            ))),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: RichText(
                            text: TextSpan(
                              text: 'Dont have an account yet? ',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                              children: <TextSpan>[
                                TextSpan(
                                    text: 'Sign Up',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xffC12604),
                                        decoration: TextDecoration.underline),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.push(
                                          context,
                                          PageTransition(
                                              type: PageTransitionType
                                                  .rightToLeftWithFade,
                                              duration:
                                                  Duration(milliseconds: 400),
                                              child: Register()),
                                        );
                                        // Function to execute when "Sign Up" is clicked
                                      }),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void route() {
    User? user = FirebaseAuth.instance.currentUser;
    var kk = FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        if (documentSnapshot.get('role') == "Doctor") {
          Navigator.pushReplacement(
            context,
            PageTransition(
                type: PageTransitionType.bottomToTop,
                duration: Duration(milliseconds: 600),
                child: DoctorPage(title: 'Doctor Page')),
          );
        } else {
          Navigator.pushReplacement(
            context,
            PageTransition(
                type: PageTransitionType.bottomToTop,
                duration: Duration(milliseconds: 600),
                child: MyHomePage(title: 'Home Page')),
          );
        }
      } else {
        print('Document does not exist on the database');
      }
    });
  }

  void signIn(String email, String password) async {
    if (_formkey.currentState!.validate()) {
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        route();
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('No user found for that email.'),
            ),
          );
        } else if (e.code == 'wrong-password') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Wrong password provided for that user.'),
            ),
          );
        }
      }
    }
  }
}
