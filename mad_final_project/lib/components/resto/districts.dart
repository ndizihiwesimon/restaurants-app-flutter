import 'package:flutter/material.dart';
import 'package:mad_final_project/api/services.dart';
import 'package:mad_final_project/components/home/my_texts.dart';
import 'package:mad_final_project/themes/colors.dart';

class DistrictTab extends StatefulWidget {
  const DistrictTab({Key? key}) : super(key: key);

  @override
  _DistrictTabState createState() => _DistrictTabState();
}

class _DistrictTabState extends State<DistrictTab> with SingleTickerProviderStateMixin {
  GetDistricts distService = GetDistricts();

  late Future<List> futureDists;
  late TabController controller;

  @override
  void initState() {
    super.initState();
    futureDists = distService.fetchDistricts();
    controller = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: MyLargeText(
        text: 'Restaurants',
        size: 20,
      ),
      backgroundColor: textWhiteColor,
      elevation: 0,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
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
      bottom:  TabBar(
              controller: controller,
              isScrollable: true,
              tabs: [
                Tab(text: 'One',),
                Tab(text: 'Two',),
              ],
            )
    );
  }
}
