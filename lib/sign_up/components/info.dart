import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:pinterest_clone/home_screen.dart';
import 'package:pinterest_clone/log_in/login_screen.dart';
import 'package:pinterest_clone/widgets/account_check.dart';
import 'package:pinterest_clone/widgets/rectangular_button.dart';
import 'package:pinterest_clone/widgets/rectangular_input_field.dart';

class Credentials extends StatefulWidget {
  @override
  _CredentialsState createState() => _CredentialsState();
}

class _CredentialsState extends State<Credentials> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //
  late TextEditingController _fullNameController =
      TextEditingController(text: '');

  late TextEditingController _emailTextController =
      TextEditingController(text: '');

  late TextEditingController _passTextController =
      TextEditingController(text: '');

  File? imageFile;

  String? imageUrl;

  void _showImageDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Escolha uma Opção'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () {},
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(
                          4.0,
                        ),
                        child: Icon(
                          Icons.camera,
                          color: Colors.red,
                        ),
                      ),
                      Text(
                        'Camera',
                        style: TextStyle(color: Colors.red),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {},
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(
                          4.0,
                        ),
                        child: Icon(
                          Icons.image,
                          color: Colors.red,
                        ),
                      ),
                      Text(
                        'Galeria',
                        style: TextStyle(color: Colors.red),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              _showImageDialog();
            },
            child: Center(
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 60,
                backgroundImage: imageFile == null
                    ? AssetImage('assets/p2.png')
                    : Image.file(imageFile!).image,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          RectangularInputField(
            hintText: 'Digite seu Nome',
            incon: Icons.person,
            obscureText: false,
            textEditingController: _fullNameController,
          ),
          SizedBox(
            height: 10.0 / 2,
          ),
          RectangularInputField(
            hintText: 'Digite seu Email',
            incon: Icons.email_rounded,
            obscureText: false,
            textEditingController: _emailTextController,
          ),
          SizedBox(
            height: 10.0 / 2,
          ),
          RectangularInputField(
            hintText: 'Digite a Senha',
            incon: Icons.lock,
            obscureText: true,
            textEditingController: _passTextController,
          ),
          SizedBox(
            height: 10.0 / 2,
          ),
          SizedBox(
            height: 5,
          ),
          RectangularButton(
            text: 'Criar Conta',
            colors1: Colors.red,
            colors2: Colors.redAccent,
            press: () async {
              if (imageFile == null) {
                Fluttertoast.showToast(msg: 'Por favor Selecione uma Imagem');
                return;
              }
              try {
                final ref = FirebaseStorage.instance
                    .ref()
                    .child('userImages')
                    .child(DateTime.now().toString() + '.jpg');
                await ref.putFile(imageFile!);
                imageUrl = await ref.getDownloadURL();
                await _auth.createUserWithEmailAndPassword(
                  email: _emailTextController.text.trim().toLowerCase(),
                  password: _passTextController.text.trim(),
                );
                final User? user = _auth.currentUser;
                final _uid = user!.uid;
                FirebaseFirestore.instance.collection('users').doc(_uid).set({
                  'id': _uid,
                  'userImage': imageUrl,
                  'name': _fullNameController.text,
                  'email': _emailTextController.text,
                  'createdAt': Timestamp.now(),
                });
                Navigator.canPop(context) ? Navigator.pop(context) : null;
              } catch (error) {
                Fluttertoast.showToast(msg: error.toString());
              }
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => HomeScreen(),
                ),
              );
            },
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
