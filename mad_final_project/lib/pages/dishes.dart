import 'package:flutter/material.dart';
import 'package:mad_final_project/api/services.dart';
import 'package:mad_final_project/components/dish/dish_details.dart';
import 'package:mad_final_project/components/home/my_texts.dart';
import 'package:mad_final_project/models/dish.dart';
import 'package:mad_final_project/themes/colors.dart';

class Dishes extends StatefulWidget {
  final int restoId;
  final String restoName;
  const Dishes({Key? key, required this.restoId, required this.restoName})
      : super(key: key);

  @override
  State<Dishes> createState() => _DishesState();
}

class _DishesState extends State<Dishes> {
  GetDishes dishService = GetDishes();
  late Future<List> futureDishes;
  late int restoId = widget.restoId;

  @override
  void initState() {
    super.initState();
    futureDishes = dishService.fetchDishes(restoId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: textWhiteColor,
      appBar: buildAppBar(),
      body: Column(children: <Widget>[
        buildDishes(),
      ]),
    );
  }

  Widget buildDishes() => Expanded(
        child: FutureBuilder<List>(
          future: futureDishes,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    final info = snapshot.data![index];
                    return InkWell(
                      child: Card(
                        elevation: 4,
                        clipBehavior: Clip.antiAlias,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            AspectRatio(
                              aspectRatio: 16 / 11,
                              child: Image.network(
                                info.pictures.isNotEmpty
                                    ? 'http://ndizihiwe.azurewebsites.net' +
                                        info.pictures[0].image
                                    : 'http://ndizihiwe.azurewebsites.net/images/dishes/BBQChicken.png',
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    16.0, 0.0, 16.0, 8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      info.name,
                                      // style: theme.textTheme.bodyText1,
                                      softWrap: false,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    SizedBox(height: 4.0),
                                    Text(
                                   info.price  + " Rwf" ,
                                      // style: theme.textTheme.caption,
                                      style: TextStyle(
                                          color: primaryColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    // End new code
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => DishDetails(
                            dish: info,
                            resto: widget.restoName,
                          ),
                        ),
                      ),
                    );
                  });
            } else if (snapshot.hasError) {
              return Center(child: Text('${snapshot.error}'));
            }

            // By default, show a loading spinner.
            return Center(child: CircularProgressIndicator());
          },
        ),
      );

  AppBar buildAppBar() {
    return AppBar(
      title: MyLargeText(
        text: widget.restoName,
        size: 18,
      ),
      backgroundColor: primaryColor,
      elevation: 4,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: primaryTextColor,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.search,
            color: primaryTextColor,
          ),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(
            Icons.tune,
            color: primaryTextColor,
          ),
          onPressed: () {},
        ),
        SizedBox(width: 20 / 2)
      ],
    );
  }
}
