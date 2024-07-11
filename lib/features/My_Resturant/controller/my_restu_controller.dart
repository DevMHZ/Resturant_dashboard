import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:my_resturant_dashboard/core/networking/api_constants.dart';
import 'dart:convert';
import 'package:my_resturant_dashboard/features/My_Resturant/model/my_resturant_model.dart';

class MyResturantMainScreenController extends GetxController {
  var userData = MyResturantData(
    subDomain: '',
    name: '',
    titleName: '',
    phone: '',
    endDate: '',
    profileimg: '',
    mainColor: '',
    password: '',
    mainCategory: [],
    subCategory: [],
    id: '',
  ).obs;

  Future<void> fetchMyResturantData(String subDomain) async {
    final response = await http.get(
      Uri.parse(ApiConstants.getRestaurantDataBySubDomain(subDomain)),
    );

    if (response.statusCode == 200) {
      userData.value =
          MyResturantData.fromJson(jsonDecode(response.body)['data']);
    } else {
      throw Exception('Failed to load user data');
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchMyResturantData(getStoredSubDomain()); // Fetch data when the controller is initialized
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