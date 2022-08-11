// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:restappintern/Screens/loginscreen.dart';
import 'package:restappintern/main.dart';
import 'package:velocity_x/velocity_x.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    // TODO: implement initState
    checkUser();
    super.initState();
  }

  bool ch = false;
  checkUser() {
    var b = FirebaseAuth.instance.currentUser;
    if (b == null) {
     setState(() {
        ch = true;
     });
    } else {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: ((context) {
        return MainPage();
      })));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        // ignore: sort_child_properties_last
        children: [
          "India's #1 Satsang".text.xl2.make(),
          "Streaming App".text.xl2.make(),
          10.heightBox,
          ch?Container(
            width: 60,
            height: 30,
            child: "Next".text.xl.makeCentered().onInkTap(() {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return LoginScreen();
              }));
            }),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Color.fromARGB(255, 111, 83, 251),
            ),
          ):CircularProgressIndicator()
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
    );
  }
}
