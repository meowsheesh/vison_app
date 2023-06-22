import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:textocr/services/auth.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  String errorMessage = '';

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  Future<void> signInWithEmailAndPassword() async {
    try {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return Dialog(
              backgroundColor: Colors.transparent,
                  surfaceTintColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  elevation: 0,
                  child: Center(child: CircularProgressIndicator(
                    color: Colors.pinkAccent,
                  )),
            );
          },
        );
        await Auth().signInWithEmailAndPassword(
          email: _controllerEmail.text,
          password: _controllerPassword.text,
        );
        Navigator.pop(context);
      Navigator.pushReplacementNamed(context, '/home');
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Wrong email/pass')));
      print(e);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff101010),
      appBar: AppBar(
        backgroundColor: Color(0xff101010),
        title: Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 8),
          child: Text(
            'Log in',
            style: TextStyle(
                color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     Padding(
            //       padding: const EdgeInsets.only(left: 22.0),
            //       child: Text(
            //         'Log in with one of the following options',
            //         style: TextStyle(color: Colors.grey),
            //       ),
            //     ),
            //     SizedBox(height: 12,),
            //     Padding(
            //       padding: const EdgeInsets.symmetric(horizontal: 12.0),
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //         children: [
            //           Card(
            //             shape: RoundedRectangleBorder(
            //               side: BorderSide(
            //                 color: Colors.grey.shade800,
            //                 width: 1
            //               ),
            //               borderRadius: BorderRadius.circular(14.0), //<-- SEE HERE
            //             ),
            //             color: Color(0xff171717),
            //             child: Padding(
            //               padding: const EdgeInsets.symmetric(
            //                   vertical: 16.0, horizontal: 70),
            //               child: Icon(Icons.account_circle),
            //             ),
            //           ),
            //           Card(
            //             shape: RoundedRectangleBorder(
            //               side: BorderSide(
            //                   color: Colors.grey.shade800,
            //                   width: 1
            //               ),
            //               borderRadius: BorderRadius.circular(14.0), //<-- SEE HERE
            //             ),
            //             color: Color(0xff171717),
            //             child: Padding(
            //               padding: const EdgeInsets.symmetric(
            //                   vertical: 16.0, horizontal: 70),
            //               child: Icon(Icons.account_circle),
            //             ),
            //           ),
            //         ],
            //       ),
            //     )
            //   ],
            // ),
            Padding(
              padding: const EdgeInsets.only(left: 24.0, right: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 4, bottom: 8.0),
                    child: Text('Email'),
                  ),
                  TextFormField(
                    controller: _controllerEmail,
                    cursorColor: Colors.pinkAccent,
                    decoration: InputDecoration(
                      hintText: 'email@email.com',
                      hintStyle: TextStyle(color: Colors.grey.shade800),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(width: 1, color: Colors.grey)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: Colors.pinkAccent)),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 4, bottom: 8.0),
                    child: Text('Password'),
                  ),
                  TextFormField(
                    controller: _controllerPassword,
                    obscureText: true,
                    cursorColor: Colors.pinkAccent,
                    decoration: InputDecoration(
                      hintText: '********',
                      hintStyle: TextStyle(color: Colors.grey.shade800),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(width: 1, color: Colors.grey)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: Colors.pinkAccent)),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Column(
              children: [
                GestureDetector(
                  onTap: () => signInWithEmailAndPassword(),
                  child: Container(
                    width: MediaQuery.of(context).size.width -
                        50, // Make the button full-width
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.purple,
                          Colors.pinkAccent,
                        ], // Gradient pink colors
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(
                          16), // Customize the button's border radius
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 18.0),
                      child: Center(
                        child: Text(
                          'Log in',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Dont have an account?',
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    RichText(text: TextSpan(text: 'Sign up')),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
