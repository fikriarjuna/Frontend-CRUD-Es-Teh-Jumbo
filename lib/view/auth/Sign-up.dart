import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tehjumbofirebase/Widget/Addphoto.dart';
import 'package:tehjumbofirebase/Widget/Button.dart';
import 'package:tehjumbofirebase/Widget/CustomFormField.dart';
import 'package:tehjumbofirebase/shared/theme.dart';
import 'package:tehjumbofirebase/view/auth/Address.dart';
import 'package:tehjumbofirebase/view/auth/Sign-in.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _signUp() async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      User? user = userCredential.user;
      if (user != null) {
        // Update the display name
        await user.updateProfile(displayName: _nameController.text);
        await user.reload(); // Refresh user data
        user = _auth.currentUser; // Get updated user data
        // Navigate to the AddressPage
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AddressPage()),
        );
      }
    } catch (e) {
      print('Failed to sign up: $e');
      // Show error message
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text(e.toString()),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        title: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Sign Up', style: titleStyle),
              Text('Daftar dan Pesan', style: subtitleStyle),
            ],
          ),
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(top: 70, left: 25, right: 25),
        child: Column(
          children: [
            AddPhotoWidget(
              onTap: () {},
              backgroundImage: 'assets/images/bg_photo.png',
            ),
            CustomFormField(
              title: 'Nama Lengkap',
              labelText: 'Masukan Nama Lengkap Anda',
              controller: _nameController,
            ),
            SizedBox(
              height: 18,
            ),
            CustomFormField(
              title: 'Email Address',
              labelText: 'Masukan email anda',
              controller: _emailController,
            ),
            SizedBox(
              height: 18,
            ),
            CustomFormField(
              title: 'Password',
              labelText: 'Masukan password anda',
              controller: _passwordController,
              obscureText: true,
            ),
            SizedBox(
              height: 18,
            ),
            CustomFillButton(
              title: 'Continue',
              onPressed: _signUp,
            ),
            SizedBox(
              height: 18,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'I Already Have an Account',
                  style: textStyle,
                ),
                SizedBox(
                  width: 4,
                ),
                CustomTextButton(
                  title: 'Sign In',
                  fontSize: 14,
                  showUnderline: false,
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => SignIn()));
                  },
                ),
              ],
            ),
          ],
        ),
      )),
    );
  }
}
