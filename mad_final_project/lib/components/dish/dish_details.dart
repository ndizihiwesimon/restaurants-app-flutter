import 'package:flutter/material.dart';
import 'package:mad_final_project/components/dish/body.dart';
import 'package:mad_final_project/models/dish.dart';
import 'package:mad_final_project/themes/colors.dart';

class DishDetails extends StatelessWidget {
  final Dish dish;
  final String resto;

  
  const DishDetails({ Key? key, required this.dish, required this.resto }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // each product have a color
      backgroundColor: accentColor,
      appBar: buildAppBar(context),
      body: Body(dish: dish, restoName: resto,),
    );
  }



  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: accentColor,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back,
          color: textWhiteColor,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {},
        ),
        IconButton(
          icon:Icon(Icons.tune),
          onPressed: () {},
        ),
        SizedBox(width: 20 / 2)
      ],
    );
  }
}