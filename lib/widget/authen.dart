import 'package:flutter/material.dart';
import 'package:punglo/utility/my_style.dart';
import 'package:punglo/widget/register.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
// Field

// Method

  Widget mySizeBox() {
    return SizedBox(
      width: 20.0,
    );
  }

  Widget showButtton() {
    return Container(
      width: 250.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          btnSignIn(),
          mySizeBox(),
          btnSignUp(),
        ],
      ),
    );
  }

  Widget btnSignUp() {
    return Expanded(
      child: OutlineButton(
        borderSide: BorderSide(
          color: MyStyle().darkColor,
        ),
        child: Text(
          'Sign Up',
          style: TextStyle(
            color: MyStyle().darkColor,
          ),
        ),
        onPressed: () {
          print('You Click Sign Up');

          MaterialPageRoute route = MaterialPageRoute(builder: (BuildContext buildContext){ return Register();});
          Navigator.of(context).push(route);

        },
      ),
    );
  }

  Widget btnSignIn() {
    return Expanded(
      child: RaisedButton(
        color: MyStyle().darkColor,
        child: Text(
          'Sign In',
          style: TextStyle(
            color: MyStyle().primaryColor,
          ),
        ),
        onPressed: () {},
      ),
    );
  }

  Widget userForm() {
    return Container(
      width: 250.0,
      child: TextField(
        decoration: InputDecoration(hintText: 'Username'),
      ),
    );
  }

  Widget pwdForm() {
    return Container(
      width: 250.0,
      child: TextField(
        obscureText: true,
        decoration: InputDecoration(hintText: 'Password'),
      ),
    );
  }

  Widget showLogo() {
    return Container(
      height: 120.0,
      width: 120.0,
      child: Image.asset('images/pclogo.png'),
    );
  }

  Widget showAppName() {
    return Text(
      'Pun GLO',
      style: TextStyle(
        color: MyStyle().darkColor,
        fontSize: 40.0,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: <Color>[
              Colors.white,
              MyStyle().primaryColor],radius: 1.5,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              showLogo(),
              showAppName(),
              userForm(),
              pwdForm(),
              showButtton(),
            ],
          ),
        ),
      ),
    );
  }
}
