import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:punglo/utility/my_style.dart';
import 'package:punglo/utility/normal_dialog.dart';
import 'package:punglo/widget/my_service.dart';
import 'package:punglo/widget/register.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
// Field
  bool status = true;
  String user, password;
// Method
  @override
  void initState() {
    super.initState();
    checkStatus();
  }

  Future<void> checkStatus() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser firebaseUser = await auth.currentUser();
    if (firebaseUser != null) {
      routeToMyService();
    } else {
      setState(() {
        status = false;
      });
    }
  }

  void routeToMyService() {
    MaterialPageRoute route =
        MaterialPageRoute(builder: (BuildContext buildContext) {
      return MyService();
    });
    Navigator.of(context).pushAndRemoveUntil(route, (Route<dynamic> route) {
      return false;
    });
  }

  Widget showProcess() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

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
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
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

          MaterialPageRoute route =
              MaterialPageRoute(builder: (BuildContext buildContext) {
            return Register();
          });
          Navigator.of(context).push(route);
        },
      ),
    );
  }

  Widget btnSignIn() {
    return Expanded(
      child: RaisedButton(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        color: MyStyle().darkColor,
        child: Text(
          'Sign In',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        onPressed: () {
          if (user == null ||
              user.isEmpty ||
              password == null ||
              password.isEmpty) {
            normalDialog(context, 'Have Space', 'Please Fill Every Blank');
          } else {
            checkAuthen();
          }
        },
      ),
    );
  }

  Future<void> checkAuthen() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth
        .signInWithEmailAndPassword(email: user, password: password)
        .then((response) {
          routeToMyService();
        })
        .catchError((error) {
      String title = error.code;
      String message = error.message;
      normalDialog(context, title, message);
    });
  }

  Widget userForm() {
    return Container(
      padding: EdgeInsets.only(bottom: 10.0),
      width: 250.0,
      child: Container(
        height: 40.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: Colors.white30,
        ),
        child: TextField(
          onChanged: (value) => user = value.trim(),
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.email,
              color: MyStyle().darkColor,
            ),
            contentPadding: EdgeInsets.only(left: 20.0, top: 8.0),
            border: InputBorder.none,
            hintText: 'Username',
          ),
        ),
      ),
    );
  }

  Widget pwdForm() {
    return Container(
      padding: EdgeInsets.only(bottom: 10.0),
      width: 250.0,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white30,
          borderRadius: BorderRadius.circular(15.0),
        ),
        height: 40.0,
        child: TextField(
          onChanged: (value) => password = value.trim(),
          obscureText: true,
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(left: 20.0, top: 8.0),
            prefixIcon: Icon(
              Icons.lock,
              color: MyStyle().darkColor,
            ),
            hintText: 'Password',
          ),
        ),
      ),
    );
  }

  Widget showLogo() {
    return Container(
      padding: EdgeInsets.only(bottom: 10.0),
      height: 120.0,
      width: 120.0,
      child: Image.asset('images/pclogo.png'),
    );
  }

  Widget showAppName() {
    return Container(
      padding: EdgeInsets.only(bottom: 10.0),
      child: Text(
        'Pun GLO',
        style: TextStyle(
          color: MyStyle().darkColor,
          fontSize: 40.0,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: status ? showProcess() : mainContent(),
    );
  }

  Container mainContent() {
    return Container(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: <Color>[Colors.white, MyStyle().primaryColor],
          radius: 1.5,
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
    );
  }
}
