import 'package:flutter/material.dart';
import 'package:punglo/utility/my_style.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
// Field

// Method

  Widget nameForm() {
    return Container(
      width: 250.0,
      child: TextField(
        decoration: InputDecoration(hintText: 'Name'),
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
      onPressed: () {},
    );
  }

  Widget btnAlbum() {
    return IconButton(
      icon: Icon(
        Icons.add_photo_alternate,
        size: 50.0,
        color: MyStyle().primaryColor,
      ),
      onPressed: () {},
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
      child: Image.asset('images/anonypic.png'),
    );
  }

  Widget btnRegister() {
    return IconButton(
      icon: Icon(Icons.cloud_upload),
      onPressed: () {},
      tooltip: 'Upload to Firebase',
    );
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
        ],
      ),
    );
  }
}
