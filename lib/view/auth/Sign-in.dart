import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tehjumbofirebase/Widget/Button.dart';
import 'package:tehjumbofirebase/Widget/CustomFormField.dart';
import 'package:tehjumbofirebase/shared/theme.dart';
import 'package:tehjumbofirebase/view/AdminPage.dart';
import 'package:tehjumbofirebase/view/Homepage.dart';
import 'package:tehjumbofirebase/view/auth/Sign-up.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _signIn() async {
    try {
      String email = _emailController.text.trim();
      String password = _passwordController.text.trim();

      if (email == 'admin' && password == 'admin') {
        // Langsung navigasi ke halaman AddProduct
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AdminPage()),
        );
        return;
      }

      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      if (user != null) {
        // Navigate to the Homepage
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Homepage()),
        );
      }
    } catch (e) {
      print('Gagal sign in: $e');
      // Tampilkan pesan kesalahan
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
              Text('Sign In', style: titleStyle),
              Text('Temukan es teh jumbo pilihan anda!', style: subtitleStyle),
            ],
          ),
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(top: 70, left: 25, right: 25),
        child: Column(
          children: [
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
              title: 'Sign In',
              onPressed: _signIn,
            ),
            SizedBox(
              height: 18,
            ),
            CustomTextButton(title: 'Lupa Pasword'),
            SizedBox(
              height: 18,
            ),
            Text(
              '- Or Continue With -',
              style: GoogleFonts.poppins(color: grey, fontSize: 12),
            ),
            SizedBox(
              height: 18,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomIconBtn(
                  img: 'assets/logo/google_logo.png',
                  title: 'Google',
                  width: 105,
                  onPressed: () {
                    // Handle Google Sign-In
                  },
                ),
                SizedBox(
                  width: 18,
                ),
                CustomIconBtn(
                  img: 'assets/logo/facebook_logo.png',
                  title: 'Facebook',
                  width: 115,
                  onPressed: () {
                    // Handle Facebook Sign-In
                  },
                ),
              ],
            ),
            SizedBox(
              height: 18,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Create an account',
                  style: textStyle,
                ),
                SizedBox(
                  width: 4,
                ),
                CustomTextButton(
                  title: 'Sign Up',
                  fontSize: 14,
                  showUnderline: false,
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => SignUp()));
                  },
                )
              ],
            ),
          ],
        ),
      )),
    );
  }
}
