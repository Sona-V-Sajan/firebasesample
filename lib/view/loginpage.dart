import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasesample/view/homepage.dart';
import 'package:firebasesample/view/registeration.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final email = TextEditingController();
  final password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Welcome Back",
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
                Text("Enter your credential to login"),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: email,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person_2_rounded),
                        fillColor: Colors.purple.withOpacity(0.1),
                        filled: true,
                        hintText: "username",
                        border: OutlineInputBorder()),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: password,
                    obscureText: true, // Add this line for hiding the password
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.password_rounded),
                        fillColor: Colors.purple.withOpacity(0.1),
                        filled: true,
                        hintText: "password",
                        border: OutlineInputBorder()),
                  ),
                ),
                Container(
                    padding: const EdgeInsets.only(top: 3, left: 3),
                    child: ElevatedButton(
                      onPressed: () async {
                        if (email.text.isEmpty || password.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Please fill in both fields")),
                          );
                          return;
                        }
                        try {
                          final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                              email: email.text,
                              password: password.text
                          );
                          if (credential.user?.uid != null) {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => Homepage()));
                          }
                        }
                        on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("No user found for that email.")),
                            );
                          } else if (e.code == 'wrong-password') {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Wrong password provided for that user.")),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Login failed: ${e.message}")),
                            );
                          }
                        }
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: Colors.purple,
                      ),
                    )),
             Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account? "),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => RegistrationPage()));
                        },
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(color: Colors.purple),
                        ))
                  ],
                ),
              ],
            )));
  }
}
