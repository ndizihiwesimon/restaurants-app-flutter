import 'package:flutter/material.dart';
import 'package:mad_final_project/api/services.dart';
import 'package:mad_final_project/components/home/my_texts.dart';
import 'package:mad_final_project/components/location/restosnsector.dart';
import 'package:mad_final_project/pages/restaurants.dart';
import 'package:mad_final_project/themes/colors.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({Key? key}) : super(key: key);

  @override
  _AddressPageState createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  GetDistricts distService = GetDistricts();

  late Future<List> futureDists;

  @override
  void initState() {
    super.initState();
    futureDists = distService.fetchDistricts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: textWhiteColor,
      appBar: buildAppBar(),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            buildLocation(),
          ]),
    );
  }

  Widget buildLocation() => Expanded(
        child: FutureBuilder<List>(
          future: futureDists,
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

                    trailing: Icon(Icons.location_on),
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => RestoNsector(
                          dist: info.id,
                          distName: info.name,
                        ),
                        // TODO: Add argument
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

  AppBar buildAppBar() {
    return AppBar(
      title: MyLargeText(
        text: 'Locations',
        size: 20,
      ),
      backgroundColor: primaryColor,
      elevation: 4,
      leading: IconButton(
        icon: Icon(
          Icons.location_on,
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
}
