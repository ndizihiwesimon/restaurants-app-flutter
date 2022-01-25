import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mad_final_project/authentication/flutterfire.dart';
import 'package:mad_final_project/components/auth/already_have_account_check.dart';
import 'package:mad_final_project/components/auth/rounded_button.dart';
import 'package:mad_final_project/components/auth/rounded_input.dart';
import 'package:mad_final_project/components/auth/rounded_password_field.dart';
import 'package:mad_final_project/pages/home.dart';
import 'package:mad_final_project/pages/signup.dart';
import 'package:mad_final_project/themes/colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailField = TextEditingController();
  TextEditingController _passwordField = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: textWhiteColor,
      body: Container(
        width: double.infinity,
        // height: size.height,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: MediaQuery.of(context).size.height /5,),
                Text(
                  'LOGIN',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                SvgPicture.asset(
                  'assets/images/login.svg',
                  height: size.height * 0.25,
                ),
                SizedBox(
                  height: size.height * 0.02,
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
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailField,
                  hintTxt: 'Your Email',
                  onChanged: (value) {},
                ),
                RoundedPasswordField(
                  validator: (value) {
                    RegExp regex = RegExp(r'^.{6,}$');
                    if (value!.isEmpty) {
                      return ("Password is required for login");
                    }
                    if (!regex.hasMatch(value)) {
                      return ("Enter Valid Password(Min. 6 Character)");
                    }
                  },
                  controller: _passwordField,
                  hintText: 'Password',
                  onChanged: (value) {},
                ),
                RoundedButton(
                  text: 'LOGIN',
                  press: () async {
                    if (_formKey.currentState!.validate()) {
                      bool shouldNavigate =
                          await login(_emailField.text, _passwordField.text);
                      if (shouldNavigate) {
                        Fluttertoast.showToast(
                            msg: "You have logged in successfully!");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MainPage(),
                          ),
                        );
                      }
                    }
                  },
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                AlreadyHaveAccountCheck(
                  press: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return SignUpPage();
                    }));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
