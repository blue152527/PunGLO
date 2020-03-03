import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:punglo/utility/my_style.dart';
import 'package:punglo/utility/normal_dialog.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
// Field
  File file;
  String name, email, password;

// Methody

  Widget emailForm() {
    Color color = Colors.green;
    return Container(
      padding: EdgeInsets.only(
        left: 50.0,
        right: 50.0,
      ),
      child: TextField(keyboardType: TextInputType.emailAddress,
        onChanged: (String string) {
          email = string.trim();
        },
        decoration: InputDecoration(
            enabledBorder:
                UnderlineInputBorder(borderSide: BorderSide(color: color)),
            icon: Icon(
              Icons.email,
              size: 36.0,
              color: color,
            ),
            labelText: 'E-Mail Address :',
            labelStyle: TextStyle(color: color),
            helperText: 'Type Your email in Blank',
            helperStyle: TextStyle(color: Colors.grey),
            hintText: 'eg. mail@glo.or.th'),
      ),
    );
  }

  Widget passwordForm() {
    Color color = Colors.orange;
    return Container(
      padding: EdgeInsets.only(
        left: 50.0,
        right: 50.0,
      ),
      child: TextField(
        obscureText: true,
        onChanged: (String string) {
          password = string.trim();
        },
        decoration: InputDecoration(
            enabledBorder:
                UnderlineInputBorder(borderSide: BorderSide(color: color)),
            icon: Icon(
              Icons.lock,
              size: 36.0,
              color: color,
            ),
            labelText: 'Password :',
            labelStyle: TextStyle(color: color),
            helperText: 'Type Your Password in Blank',
            helperStyle: TextStyle(color: Colors.grey),
            hintText: 'character mustbe a-z and 0-9'),
      ),
    );
  }

  Widget nameForm() {
    Color color = Colors.purple;
    return Container(
      padding: EdgeInsets.only(
        left: 50.0,
        right: 50.0,
      ),
      child: TextField(
        onChanged: (String string) {
          name = string.trim();
        },
        decoration: InputDecoration(
            enabledBorder:
                UnderlineInputBorder(borderSide: BorderSide(color: color)),
            icon: Icon(
              Icons.face,
              size: 36.0,
              color: color,
            ),
            labelText: 'Display Name :',
            labelStyle: TextStyle(color: color),
            helperText: 'Type Your Name in Blank',
            helperStyle: TextStyle(color: Colors.grey),
            hintText: 'eg.Sam'),
      ),
    );
  }

  Widget btnCamera() {
    return IconButton(
      icon: Icon(
        Icons.add_a_photo,
        size: 50.0,
        color: MyStyle().darkColor,
      ),
      onPressed: () {
        chooseImageThread(ImageSource.camera);
      },
    );
  }

  Future<void> chooseImageThread(ImageSource imageSource) async {
    try {
      var object = await ImagePicker.pickImage(
        source: imageSource,
        maxWidth: 800.0,
        maxHeight: 800.0,
      );

      setState(() {
        file = object;
      });
    } catch (e) {}
  }

  Widget btnAlbum() {
    return IconButton(
      icon: Icon(
        Icons.add_photo_alternate,
        size: 50.0,
        color: MyStyle().primaryColor,
      ),
      onPressed: () {
        chooseImageThread(ImageSource.gallery);
      },
    );
  }

  Widget showButtton() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          btnCamera(),
          btnAlbum(),
        ],
      ),
    );
  }

  Widget showAnonyPic() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      width: MediaQuery.of(context).size.width,
      child:
          file == null ? Image.asset('images/anonypic.png') : Image.file(file),
    );
  }

  Widget btnRegister() {
    return IconButton(
      icon: Icon(Icons.cloud_upload),
      onPressed: () {
        if (file == null) {
          normalDialog(
              context, 'Non Choose Avater', 'Please Tap Camera or Gallery');
        } else if (name == null ||
            name.isEmpty ||
            email == null ||
            email.isEmpty ||
            password == null ||
            password.isEmpty) {
          normalDialog(context, 'Have Space', 'Please Fill Every Blank');
        } else {
          registerFirebase();
        }
      },
      tooltip: 'Upload to Firebase',
    );
  }

  Future<void> registerFirebase() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    await firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((response) {
          print('Register Success');
        }).catchError((error) {
          String title = error.code;
          String message = error.message;
          normalDialog(context, title, message);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[btnRegister()],
        title: Text('Register'),
        backgroundColor: MyStyle().darkColor,
      ),
      body: ListView(
        children: <Widget>[
          showAnonyPic(),
          showButtton(),
          nameForm(),
          emailForm(),
          passwordForm(),
        ],
      ),
    );
  }
}
