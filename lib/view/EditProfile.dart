import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tehjumbofirebase/Widget/Addphoto.dart';
import 'package:tehjumbofirebase/Widget/Button.dart';
import 'package:tehjumbofirebase/Widget/CustomFormField.dart';
import 'package:tehjumbofirebase/shared/theme.dart';
import 'package:tehjumbofirebase/view/Profile.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _auth = FirebaseAuth.instance;
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadCurrentUserInfo();
  }

  Future<void> _loadCurrentUserInfo() async {
    User? user = _auth.currentUser;
    if (user != null) {
      _nameController.text = user.displayName ?? '';
      _emailController.text = user.email ?? '';
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _saveProfile() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        if (_nameController.text.isNotEmpty) {
          await user.updateDisplayName(_nameController.text);
        }
        if (_emailController.text.isNotEmpty &&
            _emailController.text != user.email) {
          await user.updateEmail(_emailController.text);
        }
        if (_passwordController.text.isNotEmpty) {
          await user.updatePassword(_passwordController.text);
        }
        // Refresh user data
        await user.reload();
        user = _auth.currentUser;
      }
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ProfilePage()),
      );
    } catch (e) {
      print(e);
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
        leading: BackBtn(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Edit Profile', style: titleStyle),
              Text('Edit Your Identity', style: subtitleStyle),
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
              controller: _nameController,
              title: 'Full Name',
              labelText: 'Enter your full name',
            ),
            SizedBox(height: 18),
            CustomFormField(
              controller: _emailController,
              title: 'Email Address',
              labelText: 'Enter your email address',
            ),
            SizedBox(height: 18),
            CustomFormField(
              controller: _passwordController,
              title: 'Password',
              labelText: 'Enter your password',
              obscureText: true,
            ),
            SizedBox(height: 18),
            CustomFillButton(
              title: 'Save',
              onPressed: _saveProfile,
            ),
          ],
        ),
      )),
    );
  }
}
