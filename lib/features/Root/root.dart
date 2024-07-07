import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:my_resturant_dashboard/features/Login/View/login_screen.dart';
import 'package:my_resturant_dashboard/features/Home/ui/home_screen.dart';
import 'package:my_resturant_dashboard/features/My_Resturant/controller/my_restu_controller.dart';

class Root extends StatelessWidget {
  const Root({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _checkLoginStatus(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else {
          if (snapshot.data == true) {
            return DashboardHomeScreen();
          } else {
            return LoginView();
          }
        }
      },
    );
  }

  Future<bool> _checkLoginStatus() async {
    var box = await Hive.openBox('loginBox');
    String? subDomain = box.get('subDomain');
    String? id = box.get('id');

    if (subDomain != null && id != null) {
      print("THE ID IS $id");
      print("THE SUB DOMAIN IS $subDomain");
      Get.put(MyResturantMainScreenController())
          .fetchMyResturantData(subDomain);
      return true;
    }
    return false;
  }

  String _getStoredId() {
    var box = Hive.box('loginBox');
    return box.get('id') ?? '';
  }
}
