import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pinterest_clone/log_in/login_screen.dart';
import 'package:pinterest_clone/widgets/account_check.dart';
import 'package:pinterest_clone/widgets/rectangular_button.dart';
import 'package:pinterest_clone/widgets/rectangular_input_field.dart';

class Credentials extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  late TextEditingController _emailTextController =
      TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
              child: Center(
            child: Image.asset(
              'assets/pc.png',
              width: 200,
            ),
          )),
          SizedBox(
            height: 10,
          ),
          RectangularInputField(
            hintText: 'Digite seu Email',
            incon: Icons.email_rounded,
            obscureText: false,
            textEditingController: _emailTextController,
          ),
          SizedBox(
            height: 30.0 / 2,
          ),
          RectangularButton(
            text: 'Enviar Link',
            press: () async {
              try {
                await _auth.sendPasswordResetEmail(
                  email: _emailTextController.text,
                );

                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => LoginScreen()));
              } catch (error) {
                Fluttertoast.showToast(msg: error.toString());
              }
            },
            colors1: Colors.red,
            colors2: Colors.redAccent,
          ),
          AccountCheck(
            login: false,
            press: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => LoginScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
