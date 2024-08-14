import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:tehjumbofirebase/Widget/Addphoto.dart';
import 'package:tehjumbofirebase/Widget/BottomNavBar.dart';
import 'package:tehjumbofirebase/Widget/Button.dart';
import 'package:tehjumbofirebase/shared/theme.dart';
import 'package:tehjumbofirebase/view/EditProfile.dart';
import 'package:tehjumbofirebase/view/Homepage.dart';
import 'package:tehjumbofirebase/view/Myaddress.dart';
import 'package:tehjumbofirebase/view/NotifPages/OrderEmpty.dart';
import 'package:tehjumbofirebase/view/auth/Sign-in.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _currentIndex = 2;
  int _selectedPageIndex = 0;

  User? user;

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
  }

  Future<void> _logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => SignIn()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Column(
          children: [
            Align(
                alignment: Alignment.center,
                child: Container(
                  margin: EdgeInsets.only(top: 35),
                  child: Column(
                    children: [
                      AddPhotoWidget(
                        onTap: () {},
                        //() async {
                        //   final image = await ImagePicker.pickImage(source: ImageSource.gallery);
                        //   if (image != null) {
                        //     // Process the selected image (e.g., display it)
                        //   }
                        // },
                        backgroundImage: 'assets/images/bg_photo.png',
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                        user?.displayName ?? 'Nama tidak tersedia',
                        style: profileStyle,
                      ),
                      Text(
                        user?.email ?? 'Email tidak tersedia',
                        style: subtitleStyle,
                      ),
                    ],
                  ),
                )),
            Padding(
              padding: EdgeInsets.only(top: 40, left: 16),
              child: Row(
                children: [
                  CustomTextButton(
                    title: 'Account',
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    showUnderline: false,
                    onPressed: () {
                      setState(() {
                        _selectedPageIndex = 0;
                      });
                    },
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  CustomTextButton(
                    title: 'FoodMarket',
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    showUnderline: false,
                    onPressed: () {
                      setState(() {
                        _selectedPageIndex = 1;
                      });
                    },
                  ),
                ],
              ),
            ),
            IndexedStack(
              index: _selectedPageIndex,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Edit Profile', style: profileTextStyle),
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EditProfile()),
                                );
                              },
                              icon: Icon(Icons.arrow_forward_ios, color: black),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('My Address', style: profileTextStyle),
                            IconButton(
                              onPressed: () {
                                 Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyAddressPage()),
                                );
                              },
                              icon: Icon(Icons.arrow_forward_ios, color: black),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Security', style: profileTextStyle),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.arrow_forward_ios, color: black),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Payment', style: profileTextStyle),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.arrow_forward_ios, color: black),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Log Out', style: profileTextStyle),
                            IconButton(
                              onPressed: _logout,
                              icon: Icon(Icons.logout, color: red),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Rate App', style: profileTextStyle),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.arrow_forward_ios, color: black),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Help Center', style: profileTextStyle),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.arrow_forward_ios, color: black),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Privacy & Policy', style: profileTextStyle),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.arrow_forward_ios, color: black),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Terms & Conditions', style: profileTextStyle),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.arrow_forward_ios, color: black),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          switch (index) {
            case 0:
              // Navigasi ke halaman Home
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Homepage()),
              );
              break;
            case 1:
              // Navigasi ke halaman order
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => OrderEmpty()),
              );
              break;
            case 2:
              break;
            default:
              break;
          }
        },
      ),
    );
  }
}
