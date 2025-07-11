import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:get_storage/get_storage.dart';
import '../auth/signin_screen.dart';
import '../home/home_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 5), () async {
      final box = GetStorage();
      String? savedEmail = box.read('email');
      if (savedEmail != null) {
        Get.offAll(() => HomeScreen());
      } else {
        Get.offAll(() => SigninScreen());
      }
    });

    return Scaffold(
      backgroundColor: Colors.deepOrange,
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "ZOYO",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontFamily: 'Cursive',
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/images/Animation - 1739357294493.json'),
            const SizedBox(height: 20),
            const Text(
              "Welcome to Zoyo App",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: 'Cursive',
                letterSpacing: 2.0,
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
