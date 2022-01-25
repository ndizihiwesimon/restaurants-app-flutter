import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:mad_final_project/models/dish.dart';
import 'package:mad_final_project/models/district.dart';
import 'package:mad_final_project/models/restaurant.dart';
import 'package:mad_final_project/models/sector.dart';

class GetDistricts {
  Future<List> fetchDistricts() async {
    final response = await http
        .get(Uri.parse('https://ndizihiwe.azurewebsites.net/districts'));

    List<District> district = [];

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      for (var d in jsonDecode(response.body)) {
        district.add(District.fromJson(d));
      }
      return district;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load district');
    }
  }
}

class GetSectors {
  Future<List> fetchSectors(int dist) async {
    final response = await http
        .get(Uri.parse('https://ndizihiwe.azurewebsites.net/districts/$dist/sectors'));

    List<Sector> sector = [];

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      for (var s in jsonDecode(response.body)) {
        sector.add(Sector.fromJson(s));
      }
      return sector;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load sectors');
    }
  }
}

class GetDistResto {
  Future<List> fetchResto(int dist) async {
    final response = await http.get(
      Uri.parse('https://ndizihiwe.azurewebsites.net/districts/$dist/restaurants'),
      headers: {
        HttpHeaders.authorizationHeader: 'Token d026935e8f4ad13a81658c32858db909eda6dbb1',
      },
    );

    List<Restaurant> resto = [];

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      for (var res in jsonDecode(response.body)) {
        resto.add(Restaurant.fromJson(res));
      }
      return resto;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load restaurants');
    }
  }
}

class GetResto {
  Future<List> fetchResto() async {
    final response = await http.get(
      Uri.parse('https://ndizihiwe.azurewebsites.net/restaurants'),
      headers: {
        HttpHeaders.authorizationHeader: 'Token d026935e8f4ad13a81658c32858db909eda6dbb1',
      },
    );

    List<Restaurant> resto = [];

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      for (var res in jsonDecode(response.body)) {
        resto.add(Restaurant.fromJson(res));
      }
      return resto;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load restaurants');
    }
  }
  Future<List> fetchTopResto() async {
    final response = await http.get(
      Uri.parse('https://ndizihiwe.azurewebsites.net/restaurants?rating=5'),
      headers: {
        HttpHeaders.authorizationHeader: 'Token d026935e8f4ad13a81658c32858db909eda6dbb1',
      },
    );

    List<Restaurant> resto = [];

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      for (var res in jsonDecode(response.body)) {
        resto.add(Restaurant.fromJson(res));
      }
      return resto;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load top rated restaurants');
    }
  }
}


class GetDishes {
  Future<List> fetchDishes(int resto) async {
    final response = await http.get(
      Uri.parse('https://ndizihiwe.azurewebsites.net/restaurants/$resto/dishes'),
      headers: {
        HttpHeaders.authorizationHeader: 'Token d026935e8f4ad13a81658c32858db909eda6dbb1',
      },
    );

    List<Dish> dish = [];

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      for (var r in jsonDecode(response.body)) {
        dish.add(Dish.fromJson(r));
      }
      return dish;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load dishes');
    }
  }
}


// class AuthService {
//   final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
//   final GoogleSignIn _googleSignIn = GoogleSignIn();

//   Stream<String> get onAuthStateChanged =>
//       _firebaseAuth.onAuthStateChanged.map(
//             (FirebaseUser user) => user?.uid,
//       );

//   // GET UID
//   Future<String> getCurrentUID() async {
//     return (await _firebaseAuth.currentUser()).uid;
//   }

//   // GET CURRENT USER
//   Future getCurrentUser() async {
//     return await _firebaseAuth.currentUser();
//   }

//   // Sign Out
//   signOut() {
//     return _firebaseAuth.signOut();
//   }





// }
