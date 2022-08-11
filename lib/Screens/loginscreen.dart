// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:restappintern/Screens/otpscreen.dart';
import 'package:restappintern/backendcalls/backend.dart';
import 'package:restappintern/main.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String number = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Column(
            // ignore: sort_child_properties_last
            children: [
              "India's #1 Satsang".text.xl2.make(),
              "Streaming App".text.xl2.make(),
              20.heightBox,
              Row(
                children: [
                  "Insert your Mobile number".text.xl.make(),
                ],
              ).py12(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  "+91".text.xl4.make().pOnly(left: 4, right: 16),
                  Flexible(
                      child: Container(
                    height: 40,
                    child: TextFormField(
                      onChanged: ((value) {
                        this.number = value;
                      }),
                      decoration: const InputDecoration(
                          label: Text("mobile no."),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.greenAccent, width: 1.0),
                          )),
                    ),
                  ))
                ],
              ).py8().pOnly(bottom: 60),
              Container(
                width: 120,
                height: 50,
                child: "Get OTP ".text.color(Colors.white).xl.makeCentered(),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Color.fromARGB(255, 111, 83, 251),
                ),
              ).onInkTap(() async {
                if (number.isEmptyOrNull) {
                  Fluttertoast.showToast(msg: "Please Enter Number");
                  return;
                }
                 Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return OtpScreen(number);
                    }));
              }),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ).px24(),
        ),
      ),
    );
  }
}
