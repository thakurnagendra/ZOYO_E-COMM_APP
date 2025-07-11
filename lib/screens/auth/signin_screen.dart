import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/services.dart';
import '../home/home_screen.dart';
import 'package:get_storage/get_storage.dart';
import '../../controllers/auth_controller.dart';
import 'signup_screen.dart';

class SigninScreen extends StatelessWidget {
  SigninScreen({super.key});
  final AuthController authController = Get.put(AuthController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool? exitApp = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Exit'),
            content: const Text('Do you want to close the app?'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Get.back(result: false);
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  Get.back(result: true);
                },
                child: const Text('Yes'),
              ),
            ],
          ),
        );
        if (exitApp == true) {
          SystemNavigator.pop();
          return true;
        } else {
          return false;
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
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
          automaticallyImplyLeading: false,
        ),
        body: Obx(() => SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    const Text("Sign In",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 30),
                    TextFormField(
                      controller: authController.emailController,
                      decoration: InputDecoration(
                        labelText: "Email",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.deepOrange),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      validator: (value) =>
                          value!.isEmpty ? "Enter email" : null,
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      controller: authController.passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.deepOrange),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      validator: (value) =>
                          value!.length < 6 ? "Password too short" : null,
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: authController.isLoading.value
                            ? null
                            : () {
                                if (_formKey.currentState!.validate()) {
                                  authController.signIn();
                                }
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepOrange,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: authController.isLoading.value
                            ? const CircularProgressIndicator(
                                color: Colors.white)
                            : const Text("Sign In",
                                style: TextStyle(color: Colors.white)),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: authController.isLoading.value
                            ? null
                            : authController.signInWithGoogle,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue.shade700,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        icon: ClipOval(
                          child: Image.asset(
                            'assets/images/google.jpg',
                            width: 24,
                            height: 24,
                            fit: BoxFit.cover,
                          ),
                        ),
                        label: const Text("Sign In with Google",
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        onPressed: () => Get.to(() => SignupScreen()),
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                        ),
                        child: const Text("Don't have an account? Sign Up"),
                      ),
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
