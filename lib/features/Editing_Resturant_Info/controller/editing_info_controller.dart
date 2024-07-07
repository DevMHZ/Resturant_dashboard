// controllers/restaurant_controller.dart

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:my_resturant_dashboard/core/networking/api_constants.dart';
import 'package:my_resturant_dashboard/Features/Editing_Resturant_Info/model/resturant_model.dart';

class RestaurantController extends GetxController {
  var isLoading = false.obs;
  Rx<Restaurant> restaurant = Restaurant(
    id: '',
    name: '',
    titleName: '',
    phone: '',
    subDomain: '',
    endDate: '',
    profileimg: '',
    mainColor: '',
    password: '',
    mainCategory: [],
    subCategory: [],
  ).obs;

  Future<void> fetchRestaurantData(String subDomain) async {
    isLoading.value = true;
    final response = await http.get(
      Uri.parse(ApiConstants.getRestaurantDataBySubDomain(subDomain)),
    );

    if (response.statusCode == 200) {
      restaurant.value = Restaurant.fromJson(jsonDecode(response.body)['data']);
    } else {
      throw Exception('Failed to load restaurant data');
    }
    isLoading.value = false;
  }

  Future<void> updateRestaurantData(String id, Restaurant updatedData) async {
    isLoading.value = true;
    final response = await http.put(
      Uri.parse(ApiConstants.updateRestaurantData(id)),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(updatedData.toJson()),
    );

    if (response.statusCode == 200) {
      restaurant.value = Restaurant.fromJson(jsonDecode(response.body)['data']);
    } else {
      throw Exception('Failed to update restaurant data');
    }
    isLoading.value = false;
  }
}

String getStoredSubDomain() {
  var box = Hive.box('loginBox');
  return box.get('subDomain') ?? '';
}

String getStoredId() {
  var box = Hive.box('loginBox');
  return box.get('id') ?? '';
}
