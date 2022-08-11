// ignore_for_file: sort_child_properties_last

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pinput/pinput.dart';
import 'package:restappintern/main.dart';
import 'package:velocity_x/velocity_x.dart';

class OtpScreen extends StatefulWidget {
  final number;

  OtpScreen(this.number, {Key? key}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String otp = "";

  String verid = "";
  @override
  void initState() {
    // TODO: implement initState
    sendCode();
    super.initState();
  }

  sendCode() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+91 ${widget.number}',
      verificationCompleted: (PhoneAuthCredential credential) {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) {
          return MainPage();
        }));
      },
      verificationFailed: (FirebaseAuthException e) {
        Fluttertoast.showToast(msg: e.message.toString());
      },
      codeSent: (String verificationId, int? resendToken) {
        this.verid = verificationId;
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        log(verificationId.toString());
      },
    );
  }

  verifyOtp() async {
    try {
      await FirebaseAuth.instance.signInWithCredential(
          PhoneAuthProvider.credential(verificationId: verid, smsCode: otp));
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) {
        return MainPage();
      }));
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.message.toString());
      // TODO
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            "Please Enter the OTP received in your".text.xl.make().py12()
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            "Mobile no. +91 ${this.widget.number}"
                .text
                .xl
                .make()
                .pOnly(bottom: 60)
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width - 32,
              child: Pinput(
                length: 6,
                onCompleted: (value) {
                  this.otp = value;
                },
              ),
            ).px4(),
          ],
        ).pOnly(bottom: 24),
        Container(
          width: 120,
          height: 50,
          child: "Verify "
              .text
              .color(Colors.white)
              .xl
              .makeCentered()
              .onInkTap(() async {
            if (otp.isEmptyOrNull || otp.length < 6) {
              Fluttertoast.showToast(msg: "Please Enter Valid OTP");
              return;
            }
            verifyOtp();
          }),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Color.fromARGB(255, 111, 83, 251),
          ),
        ),
        "Resend Code "
            .text
            .underline
            .italic
            .lg
            .makeCentered()
            .onInkTap(() async {
          sendCode();
        }),
      ],
    ));
  }
}
