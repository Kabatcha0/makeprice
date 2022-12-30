import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:makeprice/layout/layout.dart';
import 'package:makeprice/modules/onboarding.dart';
import 'package:makeprice/shared/local.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  bool? onBoarding = CacheHelper.getBool(key: "onBoard");

  @override
  void initState() {
    print(onBoarding);
    Timer(const Duration(seconds: 4), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        if (onBoarding == true) {
          return Layout();
        } else {
          return const OnBoarding();
        }
      }));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Colors.red, Colors.black])),
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/unnamed.png",
              height: 120,
              width: 120,
            ),
            const SizedBox(
              height: 8,
            ),
            const SpinKitThreeBounce(
              color: Colors.white,
              size: 30,
              duration: Duration(seconds: 4),
            )
          ],
        ),
      )),
    );
  }
}
