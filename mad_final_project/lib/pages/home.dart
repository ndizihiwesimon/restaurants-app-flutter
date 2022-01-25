import 'package:flutter/material.dart';
import 'package:mad_final_project/pages/address.dart';
import 'package:mad_final_project/components/home/home_page.dart';
import 'package:mad_final_project/components/home/profile_page.dart';
import 'package:mad_final_project/pages/restaurants.dart';
import 'package:mad_final_project/themes/colors.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List pages = [HomePage(), Restaurants(), AddressPage(), ProfilePage()];
  int currentIndex = 0;
  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: textWhiteColor,
      body: pages[currentIndex],
      bottomNavigationBar: bottomNavBar(),
    );
  }

  BottomNavigationBar bottomNavBar() {
    return BottomNavigationBar(
        selectedFontSize: 0,
        unselectedFontSize: 0,
        type: BottomNavigationBarType.fixed,
        backgroundColor: textWhiteColor,
        onTap: onTap,
        currentIndex: currentIndex,
        selectedItemColor: primaryColor,
        unselectedItemColor: primaryColor.withOpacity(0.5),
        showUnselectedLabels: false,
        showSelectedLabels: false,
        elevation: 0,
        items: [
          BottomNavigationBarItem(
            title: Text("Home"),
            icon: Icon(Icons.apps),
          ),
          BottomNavigationBarItem(
            title: Text("Restaurants"),
            icon: Icon(Icons.restaurant),
          ),
          BottomNavigationBarItem(
            title: Text("Address"),
            icon: Icon(Icons.location_on),
          ),
          BottomNavigationBarItem(
            title: Text("Profile"),
            icon: Icon(Icons.person),
          ),
        ]);
  }


}
