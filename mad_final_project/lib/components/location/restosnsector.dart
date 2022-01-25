import 'package:flutter/material.dart';
import 'package:mad_final_project/api/services.dart';
import 'package:mad_final_project/components/home/my_texts.dart';
import 'package:mad_final_project/components/resto/resto_details.dart';
import 'package:mad_final_project/themes/colors.dart';

class RestoNsector extends StatefulWidget {
  final int dist;
  final String distName;
  const RestoNsector({Key? key, required this.dist, required this.distName})
      : super(key: key);

  @override
  _RestoNsectorState createState() => _RestoNsectorState();
}

class _RestoNsectorState extends State<RestoNsector> {
  GetDistResto restoService = GetDistResto();
  GetSectors sectService = GetSectors();

  late Future<List> futureSectors;
  late Future<List> futureRestos;

  @override
  void initState() {
    super.initState();
    futureSectors = sectService.fetchSectors(widget.dist);
    futureRestos = restoService.fetchResto(widget.dist);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: textWhiteColor,
      appBar: buildAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
            height: MediaQuery.of(context).size.height / 2.3,
            // margin: const EdgeInsets.only(left: 20),
            child: Column(
              children: [
                MyLargeText(
                  text: "Restaurants",
                  size: 20,
                ),
                buildDistRestos(),
              ],
            ),
          ),
          Expanded(
              child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: MyLargeText(
                  text: "Sectors",
                  size: 20,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: MediaQuery.of(context).size.height / 2.9,
                width: MediaQuery.of(context).size.width,
                child: Column(
              children: [
                buildDistSectors(),
              ],
            ),
              )
            ],
          ))
        ],
      ),
    );
  }


  AppBar buildAppBar() {
    return AppBar(
      title: MyLargeText(
        text: widget.distName,
        size: 20,
      ),
      backgroundColor: primaryColor,
      elevation: 0,
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

  Widget buildDistRestos() => Expanded(
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



  Widget buildDistSectors() => Expanded(
        child: FutureBuilder<List>(
          future: futureSectors,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.separated(
                separatorBuilder: (context, index) =>
                    Divider(color: Colors.black),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final info = snapshot.data![index];
                  return ListTile(
                    // leading: Text(number.toString(), style: TextStyle(fontWeight: FontWeight.bold,),),
                    title: Text(
                      snapshot.data![index].name,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                 trailing: Icon(Icons.map, color: primaryColor,),
                    onTap: () {}
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
