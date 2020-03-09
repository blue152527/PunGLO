import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:punglo/utility/my_style.dart';
import 'package:punglo/widget/authen.dart';

class MyService extends StatefulWidget {
  @override
  _MyServiceState createState() => _MyServiceState();
}

class _MyServiceState extends State<MyService> {
  //Field

  //Method
  Widget menuSignOut() {
    return ListTile(
      onTap: () {
        processSignOut();
      },
      subtitle: Text('Sign Out and Back to Authentication'),
      title: Text('Sign Out'),
      leading: Icon(
        Icons.exit_to_app,
        size: 36.0,
      ),
    );
  }

  Future<void> processSignOut() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut().then((response) {
      MaterialPageRoute route = MaterialPageRoute(builder: (value) => Authen());
      Navigator.of(context).pushAndRemoveUntil(route, (route) => false);
    });
  }

  Widget showHeader() {
    return UserAccountsDrawerHeader(
        accountName: Text('Name Login'), accountEmail: Text('Email Login'));
  }

  Widget showDrawer() {
    return Drawer(
      child: ListView(
        children: <Widget>[showHeader(), menuSignOut()],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: showDrawer(),
      appBar: AppBar(
        title: Text('My Service'),
        backgroundColor: MyStyle().primaryColor,
      ),
    );
  }
}
