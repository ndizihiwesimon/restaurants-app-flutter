import 'package:flutter/material.dart';
import 'package:mad_final_project/components/home/my_texts.dart';
import 'package:mad_final_project/models/dish.dart';
import 'package:mad_final_project/themes/colors.dart';

class Body extends StatelessWidget {
  final Dish dish;
  final String restoName;

  const Body({Key? key, required this.dish, required this.restoName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // It provide us total height and width
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: size.height,
            child: Stack(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(
                    top: size.height * 0.35,
                  ),
                  padding: EdgeInsets.only(
                    top: size.height * 0.02,
                    left: 20,
                    right: 20,
                  ),
                  // height: 500,
                  decoration: BoxDecoration(
                    color: textWhiteColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      MyLargeText(
                        text: 'Cooking time',
                        size: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(dish.cookTime),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      MyLargeText(text: "Ingredients", size: 20),
                      Ingredients(dish: dish),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        margin: const EdgeInsets.only(right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MyLargeText(
                              text: "Dish images",
                              size: 20,
                            ),
                            MySmallText(
                              text: "See all",
                              color: primaryTextColor.withOpacity(0.5),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 120,
                        width: double.maxFinite,
                        margin: const EdgeInsets.only(right: 10),
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: dish.pictures.length,
                            itemBuilder: (_, index) {
                              return Container(
                                margin: const EdgeInsets.only(right: 10),
                                child: Column(
                                  children: [
                                    Container(
                                      // margin: const EdgeInsets.only(right: 50),
                                      width: 80,
                                      height: 80,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: textWhiteColor,
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            'http://ndizihiwe.azurewebsites.net'+ dish.pictures[index].image,
                                          ),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                      )
                    ],
                  ),
                ),
                DishTitleWithImage(dish: dish, restoName: restoName,)
              ],
            ),
          )
        ],
      ),
    );
  }
}

class Ingredients extends StatelessWidget {
  const Ingredients({
    Key? key,
    required this.dish,
  }) : super(key: key);

  final Dish dish;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for(var item in dish.ingredients ) Text(item)
        ],
      )
    );
  }
}
// MySmallText(text: dish.name),
class DishTitleWithImage extends StatelessWidget {
  const DishTitleWithImage({
    Key? key,
    required this.dish, required this.restoName,
  }) : super(key: key);

  final Dish dish;
  final String restoName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            restoName,
            style: TextStyle(color: Colors.white),
          ),
          Text(
            dish.name,
            style: Theme.of(context)
                .textTheme
                .headline4!
                .copyWith(color: textWhiteColor, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Row( 
            children: <Widget>[
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(text: "Price\n"),
                    TextSpan(
                      text: "\Rwf ${dish.price}",
                      style: Theme.of(context).textTheme.headline4!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 22),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10 * 2),
              Expanded(
                child: Hero(
                  tag: "${dish.id}",
                  child: Image.network(
                    // product.image,
                   dish.pictures.isNotEmpty
                                    ? 'http://ndizihiwe.azurewebsites.net' +
                                        dish.pictures[0].image
                                    : 'http://ndizihiwe.azurewebsites.net/images/dishes/BBQChicken.png',
                    fit: BoxFit.fill,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
