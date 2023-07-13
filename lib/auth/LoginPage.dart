import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:flutter/material.dart';
import 'package:medicineshop/helper/SharedPrefernce.dart';
import 'package:medicineshop/helper/internetConnectivity.dart';
import 'package:medicineshop/auth/signup.dart';
import 'package:medicineshop/services/auth.dart';

import '../Screens/Homepage.dart';

class LoginIn extends StatefulWidget {
  const LoginIn({super.key});

  @override
  State<LoginIn> createState() => _LoginInState();
}

class _LoginInState extends State<LoginIn> {
  bool _isloading = false;
  AuthService _authService = new AuthService();
  String validateEmail(String email) {
    if (email.isEmpty) {
      return 'Please enter your email';
    }
    if (!email.contains('@') || !email.contains('.')) {
      return 'Please enter a valid email';
    }
    return '';
  }

  final _formField = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void dispose() {
      super.dispose();
      _emailController.dispose();
      _passwordController.dispose();
    }

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/picon.png',
                    width: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Text(
                      "Adhicine",
                      style: TextStyle(color: Colors.blue, fontSize: 20),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 60),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 50,
                        ),
                      ),
                    ),
                  ),
                  !_isloading
                      ? Form(
                          key: _formField,
                          child: Column(
                            children: [
                              TextFormField(
                                controller: _emailController,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.alternate_email,
                                    color: Colors.green,
                                  ),
                                  hintText: "Enter your Email",
                                ),
                                validator: (value) {
                                  RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                          .hasMatch(value!)
                                      ? null
                                      : "Please enter a valid email";
                                },
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                obscureText: true,
                                controller: _passwordController,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.lock_open,
                                    color: Colors.green,
                                  ),
                                  suffixIcon: Icon(Icons.remove_red_eye),
                                  hintText: "Enter Password",
                                ),
                                validator: (value) {
                                  if (value!.length < 8) {
                                    return "PassWord must be At Least 6 characters";
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ],
                          ),
                        )
                      : CircularProgressIndicator(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 50),
                    child: GestureDetector(
                      onTap: () async {
                        await Helper().checkInternetConnectivity(context);
                        if (_formField.currentState!.validate()) {
                          try {
                            UserCredential? userCredential =
                                await _authService.signInWithEmailAndPassword(
                                    email: _emailController.text,
                                    password: _passwordController.text);
                            if (userCredential?.user != null) {
                              await LocalData.SaveUserLoggedInStatus(true);
                              await LocalData.SaveUserEmail(
                                  _emailController.text);
                              Get.offAll(() => HomePage());
                            }
                          } catch (e) {
                            print(e.toString());
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(e.toString()),
                                duration: Duration(seconds: 3),
                              ),
                            );
                          }
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Text(
                          "Sign In",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: Colors.grey,
                          thickness: 1.0,
                          indent: 5.0,
                          endIndent: 10.0,
                        ),
                      ),
                      Text(
                        "OR",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12.0,
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: Colors.grey,
                          thickness: 1.0,
                          indent: 5.0,
                          endIndent: 20.0,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: Colors.grey)),
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              'assets/google.png',
                              width: 30,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () async {
                                await Helper()
                                    .checkInternetConnectivity(context);

                                User? user =
                                    await _authService.signInWithGoogle();
                                if (user != null) {
                                  await LocalData.SaveUserLoggedInStatus(true);
                                  await LocalData.SaveUserEmail(
                                      _emailController.text);
                                  await LocalData.SaveUserphotoStatus(
                                      user.photoURL.toString());
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomePage()),
                                  );
                                }
                              },
                              child: Text(
                                "Continue with google",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("New to Adhicine?"),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUp()));
                          },
                          child: Text(
                            "Sign Up",
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
