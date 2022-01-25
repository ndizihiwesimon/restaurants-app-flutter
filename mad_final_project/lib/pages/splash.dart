import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:mad_final_project/components/home/my_button.dart';
import 'package:mad_final_project/components/home/my_texts.dart';
import 'package:mad_final_project/pages/login.dart';
import 'package:mad_final_project/themes/colors.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  List images = ['lunch.png', 'sharing.png', 'ideas.png'];
  List texts = ['On a date?', 'With friends?', 'Where?'];
  List smtxts = [
    "Choose where you can have a beakfast, lunch or dinner with someone you love. anytime, anywhere!",
    "Do not be hungry with your friends, check where you can order something to eat",
    "Wondering which best, near and top rated restaurant? relax we solved that for you!"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: splashBackgroundColor,
      body: PageView.builder(
          scrollDirection: Axis.vertical,
          itemCount: images.length,
          itemBuilder: (_, index) {
            return Container(
              width: double.maxFinite,
              height: double.maxFinite,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'assets/images/' + images[index],
                  ),
                  alignment: Alignment.bottomCenter,
                  fit: BoxFit.fitWidth,
                ),
              ),
              child: Container(
                margin: const EdgeInsets.only(top: 150, left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyLargeText(text: texts[index]),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: 250,
                          child: MySmallText(
                            text: smtxts[index],
                            color: secondaryTextColor,
                            size: 14,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        MyButton(
                          short: true,
                          width: 180,
                          height: 50,
                          text: 'Get Started',
                          press: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return LoginPage();
                            }));
                          },
                        )
                      ],
                    ),
                    Column(
                      children: List.generate(3, (indexDots) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 2),
                          width: 6,
                          height: index == indexDots ? 25 : 8,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: index == indexDots
                                  ? darkColor
                                  : darkColor.withOpacity(0.3)),
                        );
                      }),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
