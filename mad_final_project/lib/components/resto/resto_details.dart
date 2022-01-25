import 'package:flutter/material.dart';
import 'package:mad_final_project/components/home/my_button.dart';
import 'package:mad_final_project/components/home/my_texts.dart';
import 'package:mad_final_project/components/resto/app_button.dart';
import 'package:mad_final_project/models/restaurant.dart';
import 'package:mad_final_project/pages/dishes.dart';
import 'package:mad_final_project/themes/colors.dart';

class RestoDetails extends StatelessWidget {
  final Restaurant resto;
  const RestoDetails({ Key? key, required this.resto }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final gottenStars = resto.rating;
    return Scaffold(
      backgroundColor: textWhiteColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 1.2,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    right: 0,
                    child: Container(
                      width: double.maxFinite,
                      height: 350,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/cover.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 20,
                    top: 50,
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.arrow_back),
                          color: textWhiteColor,
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    top: 300,
                    child: Container(
                      padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 2.3,
                      decoration: BoxDecoration(
                          color: textWhiteColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25),
                          )),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              MyLargeText(text: resto.name),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: primaryColor.withOpacity(0.8),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              MySmallText(
                                text: resto.district+', '+resto.sector,
                                color: secondaryTextColor,
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              Wrap(
                                children: List.generate(5, (index) {
                                  return Icon(Icons.star,
                                      color: index < gottenStars
                                          ? starColor
                                          : secondaryTextColor);
                                }),
                              ),
                              MySmallText(
                                text: " ($gottenStars.0)",
                                color: secondaryTextColor,
                              )
                            ],
                          ),
                          SizedBox(height: 25),
                          MyLargeText(
                            text: "Owner",
                            color: primaryTextColor.withOpacity(0.8),
                            size: 20,
                          ),
                          SizedBox(height: 5),
                          MySmallText(
                            text: "This is the owner of restaurant",
                            color: secondaryTextColor,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.person,
                                color: primaryColor.withOpacity(0.8),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              MySmallText(
                                text: " "+resto.owner,
                                color: primaryTextColor,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 600,
                    left: 20,
                    right: 20,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppButton(
                          size: 60,
                          color: secondaryTextColor,
                          bcolor: textWhiteColor,
                          borderColor: secondaryTextColor,
                          isIcon: true,
                          icon: Icons.favorite_border,
                        ),
                        SizedBox(width: 20,),
                        MyButton(width: MediaQuery.of(context).size.width /1.5, text: 'View dishes', press: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => Dishes(restoId: resto.id, restoName: resto.name,),
                            ),
                          ),)
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}