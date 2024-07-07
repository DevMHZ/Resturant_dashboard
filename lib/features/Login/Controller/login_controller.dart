import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:my_resturant_dashboard/core/networking/api_constants.dart';
import 'package:my_resturant_dashboard/Features/My_Resturant/controller/my_restu_controller.dart';
import '../../../core/routing/routes.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;
  var nameController = TextEditingController();
  var passwordController = TextEditingController();

  void login(BuildContext context) async {
    isLoading.value = true;

    final url = ApiConstants.login;
    final headers = {'Content-Type': 'application/json'};

    final body = jsonEncode({
      'name': nameController.text,
      'password': passwordController.text,
    });

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: body,
      );

      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body)['data'];
        String subDomain = jsonData['subDomain'];
        String id = jsonData['_id'];

        // Store ID and subDomain in Hive
        var box = Hive.box('loginBox');
        await box.put('id', id);
        await box.put('subDomain', subDomain);
        print("=------------------------------------- $id");

        Get.put(MyResturantMainScreenController()).fetchMyResturantData(subDomain);
        // Get.put(UpdateResturantInfoController()).updateData(id);

        // Handle success
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Login successful')));
        Navigator.pushReplacementNamed(context, Routes.homeScreen);
      } else {
        // Handle error
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Login failed')));
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text(response.body),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
        print('Login failed: ${response.body}');
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('An error occurred')));
      print('An error occurred: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
