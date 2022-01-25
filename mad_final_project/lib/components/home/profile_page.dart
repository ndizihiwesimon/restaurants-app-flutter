// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mad_final_project/components/auth/rounded_display.dart';
import 'package:mad_final_project/models/user.dart';
import 'package:mad_final_project/pages/home.dart';
import 'package:mad_final_project/pages/login.dart';
import 'package:mad_final_project/themes/colors.dart';
class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loginuser = UserModel();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loginuser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: textWhiteColor,
    appBar: AppBar(
      elevation: 0,
      backgroundColor: primaryColor,
      leading: IconButton(
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => MainPage())),
        icon: const Icon(
          Icons.arrow_back,
          color: primaryTextColor,
          size: 20,
        ),
      ),
      title: const Text(
        'User Profile',
        style: TextStyle(color: primaryTextColor),
      ),
      centerTitle: true,
    ),
    body: Column(
      children: <Widget>[
        const SizedBox(
          height: 20,
        ),
        const SizedBox(
          height: 115,
          width: 115,
          child: CircleAvatar(
            backgroundImage: AssetImage("assets/images/avatar.png"),
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        ProfileText(
          icon: Icons.person,
          text: "${loginuser.userName}",
          press: () {},
        ),
        ProfileText(
          icon: Icons.email_outlined,
          text: "${loginuser.email}",
          press: () {},
        ),
        
        ActionChip(
            backgroundColor: primaryColor,
            avatar: const CircleAvatar(
              child: Icon(Icons.logout, color: primaryColor,size: 20,),
              backgroundColor: primaryColor,
            ),
            padding: const EdgeInsets.fromLTRB(150, 15, 150, 15),
            label: Text('Logout',style: TextStyle(fontWeight: FontWeight.bold),),
            onPressed: () {
              logout(context);
            })
      ],
    ),
  );
  }

  // Future logout method
  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginPage()));
  }
}
