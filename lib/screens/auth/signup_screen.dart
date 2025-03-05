import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../home/home_screen.dart';
import 'signin_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _retypePasswordController = TextEditingController();

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  
  _register() async {
    if (_formKey.currentState!.validate()) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('email', "example@example.com"); 
      Get.offAll(() => HomeScreen()); 
      Get.snackbar("Success", "Registration successful",
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green, colorText: Colors.white);
    }
  }


  _signUpWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('email', googleUser.email);
        Get.offAll(() => HomeScreen());  
        Get.snackbar("Google Sign-Up", "Successfully signed up with Google",
            snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green, colorText: Colors.white);
      }
    } catch (error) {
      Get.snackbar("Error", "Google sign-up failed: $error",
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,  
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
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                const Text("Sign Up", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                const SizedBox(height: 30),

                
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.deepOrange), 
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  validator: (value) => value!.length < 6 ? "Password too short" : null,
                ),
                const SizedBox(height: 15),

               
                TextFormField(
                  controller: _retypePasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Retype Password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.deepOrange), 
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  validator: (value) => value != _passwordController.text ? "Passwords do not match" : null,
                ),
                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _register,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepOrange, 
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text("Sign Up", style: TextStyle(color: Colors.white)),
                  ),
                ),
                const SizedBox(height: 20),

               
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _signUpWithGoogle, 
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
                    label: const Text("Sign Up with Google", style: TextStyle(color: Colors.white)),
                  ),
                ),
                const SizedBox(height: 20),

                
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () => Get.to(() => SigninScreen()), 
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: const Text("Already have an account? Sign In"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
