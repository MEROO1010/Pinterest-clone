import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pinterest_clone/forget_password/forget_password.dart';
import 'package:pinterest_clone/home_screen.dart';
import 'package:pinterest_clone/sign_up/signup_screen.dart';
import 'package:pinterest_clone/widgets/account_check.dart';
import 'package:pinterest_clone/widgets/rectangular_button.dart';
import 'package:pinterest_clone/widgets/rectangular_input_field.dart';

class Credentials extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  late final TextEditingController _emailTextController =
      TextEditingController(text: '');

  late final TextEditingController _passTextController =
      TextEditingController(text: '');

  Credentials({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage('assets/p1.png'),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          RectangularInputField(
            hintText: 'Digite seu Email',
            incon: Icons.email_rounded,
            obscureText: false,
            textEditingController: _emailTextController,
          ),
          const SizedBox(
            height: 30.0 / 2,
          ),
          RectangularInputField(
            hintText: 'Digite sua Senha',
            incon: Icons.lock,
            obscureText: true,
            textEditingController: _passTextController,
          ),
          const SizedBox(
            height: 30.0 / 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const ForgetPasswordScreen()));
                },
                child: const Text(
                  'Esqueceu a Senha ?',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                    fontSize: 17,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          RectangularButton(
            text: 'Entrar',
            press: () async {
              try {
                await _auth.signInWithEmailAndPassword(
                    email: _emailTextController.text.trim().toLowerCase(),
                    password: _passTextController.text.trim());
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (_) => const HomeScreen()));
              } catch (error) {
                Fluttertoast.showToast(msg: error.toString());
              }
            },
            colors1: Colors.red,
            colors2: Colors.redAccent,
          ),
          AccountCheck(
            login: true,
            press: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => const SignUpScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
