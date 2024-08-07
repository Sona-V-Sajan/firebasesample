import 'package:firebasesample/view/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  // final uname = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  // final cpassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Sign up",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Create your account",
                  style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                ),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: TextFormField(
                //     controller: uname,
                //     decoration: InputDecoration(
                //         prefixIcon: Icon(Icons.person_2_rounded),
                //         fillColor: Colors.purple.withOpacity(0.1),
                //         filled: true,
                //         hintText: "username",
                //         border: OutlineInputBorder()),
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: email,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.mail_lock_rounded),
                        fillColor: Colors.purple.withOpacity(0.1),
                        filled: true,
                        hintText: "email",
                        border: OutlineInputBorder()),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: password,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.password_rounded),
                        fillColor: Colors.purple.withOpacity(0.1),
                        filled: true,
                        hintText: "password",
                        border: OutlineInputBorder()),
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: TextFormField(
                //     controller: cpassword,
                //     decoration: InputDecoration(
                //         prefixIcon: Icon(Icons.password),
                //         fillColor: Colors.purple.withOpacity(0.1),
                //         filled: true,
                //         hintText: "confirm password",
                //         border: OutlineInputBorder()),
                //   ),
                // ),
                Container(
                    padding: const EdgeInsets.all(50),
                    child: ElevatedButton(
                      onPressed: () async {
                        try {
                          final credential = await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                            email: email.text,
                            password: password.text,
                          );
                          print(credential.user?.uid);
                          if (credential.user?.uid != null) {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => LoginPage()));
                          }
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'weak-password') {
                            print('The password provided is too weak.');
                          } else if (e.code == 'email-already-in-use') {
                            print('The account already exists for that email.');
                          }
                        } catch (e) {
                          print(e);
                        }
                      },
                      child: const Text(
                        "Sign up",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                        // padding: const EdgeInsets.all(30),
                        backgroundColor: Colors.purple,
                      ),
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account? "),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => LoginPage()));
                        },
                        child: const Text(
                          "Login",
                          style: TextStyle(color: Colors.purple),
                        ))
                  ],
                ),
              ],
            )));
  }
}
