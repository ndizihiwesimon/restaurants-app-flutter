import 'package:flutter/material.dart';
import 'package:mad_final_project/api/services.dart';
import 'package:mad_final_project/components/home/drawer.dart';
import 'package:mad_final_project/components/home/my_texts.dart';
import 'package:mad_final_project/components/resto/resto_details.dart';
import 'package:mad_final_project/themes/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GetResto restoService = GetResto();
  late Future<List> futureRestos;

  @override
  void initState() {
    super.initState();
    futureRestos = restoService.fetchTopResto();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: textWhiteColor,
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        child: Wrap(
          direction: Axis.horizontal,
          spacing: 8.0, // gap between adjacent chips
          runSpacing: 4.0,
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
              height: 300,
              // margin: const EdgeInsets.only(left: 20),
              child: Column(
                children: [
                  MyLargeText(
                    text: "Top rated (5.0)",
                    size: 20,
                  ),
                  buildTopRated(),
                ],
              ),
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: MyLargeText(
                    text: "Updates",
                    size: 20,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  // height: MediaQuery.of(context).size.height / 3.1,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: primaryColor.withOpacity(0.2),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20),
                      )),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                          child: MyLargeText(
                        text: 'A litte guide',
                        size: 16,
                      )),
                      updatesList(
                          '1. To view home screen content tap ', Icons.apps),
                      updatesList('2. To view list of all restaurants tap ',
                          Icons.restaurant),
                      updatesList('3. To view restaurants by location tap ',
                          Icons.location_on),
                      updatesList('4. To view user profile tap ', Icons.person),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: MySmallText(
                          text:
                              "For now to view dishes you have to tap on restaurant and navigate down and tap on 'View dishes'",
                          size: 15,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ))
          ],
        ),
      ),
    );
  }

  Row updatesList(String text, IconData icon) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(
              left: 20.0, right: 20.0, bottom: 0, top: 10),
          child: MySmallText(
            text: text,
            color: primaryTextColor,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
              left: 10.0, right: 10.0, bottom: 0, top: 10),
          child: Icon(icon),
        ),
      ],
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: MyLargeText(
        text: 'Restaurants App',
        size: 20,
      ),
      backgroundColor: primaryColor,
      elevation: 0,
      leading: IconButton(
        icon: Icon(
          Icons.restaurant,
          color: primaryTextColor,
        ),
        onPressed: () {},
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

  Widget buildTopRated() => Expanded(
        child: FutureBuilder<List>(
          future: futureRestos,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.separated(
                separatorBuilder: (context, index) =>
                    Divider(color: Colors.black),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final info = snapshot.data![index];
                  final int number = index + 1;
                  return ListTile(
                    // leading: Text(number.toString(), style: TextStyle(fontWeight: FontWeight.bold,),),
                    title: Text(
                      snapshot.data![index].name,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      snapshot.data![index].district + ', ' + info.sector,
                      style: TextStyle(color: primaryColor),
                    ),
                    trailing: Wrap(
                      children: List.generate(5, (i) {
                        return Icon(
                          Icons.star,
                          color: i < info.rating ? starColor : primaryTextColor,
                          size: 18,
                        );
                      }),
                    ),
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => RestoDetails(
                          resto: info,
                        ),
                      ),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Center(child: Text('${snapshot.error}'));
            }

            // By default, show a loading spinner.
            return Center(child: CircularProgressIndicator());
          },
        ),
      );
}
