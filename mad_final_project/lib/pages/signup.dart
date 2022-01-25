import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mad_final_project/authentication/flutterfire.dart';
import 'package:mad_final_project/components/auth/already_have_account_check.dart';
import 'package:mad_final_project/components/auth/or_divider.dart';
import 'package:mad_final_project/components/auth/rounded_button.dart';
import 'package:mad_final_project/components/auth/rounded_input.dart';
import 'package:mad_final_project/components/auth/rounded_password_field.dart';
import 'package:mad_final_project/components/auth/social_icon.dart';
import 'package:mad_final_project/pages/home.dart';
import 'package:mad_final_project/pages/login.dart';
import 'package:mad_final_project/themes/colors.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController _emailField = TextEditingController();
  TextEditingController _userNameField = TextEditingController();
  TextEditingController _passwordField = TextEditingController();
  TextEditingController _confirmPasswordField = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // _formKey.currentState!.validate();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: textWhiteColor,
      body: Container(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: size.height * 0.15,
                ),
                Text(
                  "SIGNUP",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: size.height * 0.02),
                SvgPicture.asset(
                  "assets/images/signup.svg",
                  height: size.height * 0.15,
                ),
                RoundedInputField(
                  validator: (value) {
                    RegExp regex = RegExp(r'^.{3,}$');
                    if (value!.isEmpty) {
                      return ("Username cannot be Empty");
                    }
                    if (!regex.hasMatch(value)) {
                      return ("Enter Valid name(Min. 3 Character)");
                    }
                    return null;
                  },
                  keyboardType: TextInputType.name,
                  controller: _userNameField,
                  hintTxt: "Username",
                  onChanged: (value) {},
                ),
                RoundedInputField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return ("Please Enter Your Email");
                    }
                    // reg expression for email validation
                    if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                        .hasMatch(value)) {
                      return ("Please Enter a valid email");
                    }
                    return null;
                  },
                  ikon: Icons.mail,
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailField,
                  hintTxt: "Your Email",
                  onChanged: (value) {},
                ),
                RoundedPasswordField(
                  controller: _passwordField,
                  validator: (value) {
                    RegExp regex = RegExp(r'^.{6,}$');
                    if (value!.isEmpty) {
                      return ("Password is required for login");
                    }
                    if (!regex.hasMatch(value)) {
                      return ("Enter Valid Password(Min. 6 Character)");
                    }
                  },
                  hintText: 'Enter Password',
                  onChanged: (value) {},
                ),
                RoundedPasswordField(
                  validator: (value) {
                    if (value!.isEmpty) return 'Please confirm password';
                    if (value != _passwordField.text)
                      return 'Password not match';
                    return null;
                  },
                  controller: _confirmPasswordField,
                  hintText: 'Confirm Password',
                  onChanged: (value) {},
                ),
                RoundedButton(
                  text: "SIGNUP",
                  press: () async {
                    if (_formKey.currentState!.validate()) {
                      bool shouldNavigate =
                          await register(_emailField.text, _passwordField.text);
                      if (shouldNavigate) {
                        postDetailsToFirestore(_userNameField.text);
                        Fluttertoast.showToast(
                            msg: "Account created successfully!");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginPage(),
                          ),
                        );
                      } else {
                        Fluttertoast.showToast(
                            msg: "Unable to sign up, please enter valid data");
                      }
                    }
                  },
                ),
                SizedBox(height: size.height * 0.02),
                AlreadyHaveAccountCheck(
                  login: false,
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return LoginPage();
                        },
                      ),
                    );
                  },
                ),
                OrDivider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SocialIcon(
                      iconSrc: "assets/icons/google.svg",
                      press: () {
                        final provider = Provider.of<GoogleSignInProvider>(
                            context,
                            listen: false);
                        provider.googleLogin();
                        // provider.googleLogin();
                      },
                    ),
                    SocialIcon(
                      iconSrc: "assets/icons/github.svg",
                      press: () {},
                    ),
                    SocialIcon(
                      iconSrc: "assets/icons/twitter.svg",
                      press: () {},
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
