import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../screens/home/home_screen.dart';

class AuthController extends GetxController {
  final box = GetStorage();
  final GoogleSignIn googleSignIn = GoogleSignIn();
  var isLoading = false.obs;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final retypePasswordController = TextEditingController();

  Future<void> signIn() async {
    if (emailController.text.isEmpty || passwordController.text.length < 6) {
      return;
    }
    isLoading(true);
    await box.write('email', emailController.text);
    isLoading(false);
    Get.offAll(() => HomeScreen());
    Get.snackbar("Success", "Sign In successful",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white);
  }

  Future<void> signInWithGoogle() async {
    try {
      isLoading(true);
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser != null) {
        await box.write('email', googleUser.email);
        isLoading(false);
        Get.offAll(() => HomeScreen());
        Get.snackbar("Google Sign-In", "Successfully signed in with Google",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white);
      } else {
        isLoading(false);
      }
    } catch (error) {
      isLoading(false);
      Get.snackbar("Error", "Google sign-in failed: $error",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

  Future<void> register() async {
    if (emailController.text.isEmpty ||
        passwordController.text.length < 6 ||
        passwordController.text != retypePasswordController.text) {
      return;
    }
    isLoading(true);
    await box.write('email', emailController.text);
    isLoading(false);
    Get.offAll(() => HomeScreen());
    Get.snackbar("Success", "Registration successful",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white);
  }

  Future<void> signUpWithGoogle() async {
    try {
      isLoading(true);
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser != null) {
        await box.write('email', googleUser.email);
        isLoading(false);
        Get.offAll(() => HomeScreen());
        Get.snackbar("Google Sign-Up", "Successfully signed up with Google",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white);
      } else {
        isLoading(false);
      }
    } catch (error) {
      isLoading(false);
      Get.snackbar("Error", "Google sign-up failed: $error",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

  void signOut() async {
    await box.remove('email');
    Get.offAllNamed('/signin');
  }
}
