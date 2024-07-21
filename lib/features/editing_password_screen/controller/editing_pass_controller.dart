import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

class ChangePasswordController extends GetxController {
  var isLoading = false.obs;

  String getStoredId() {
    var box = Hive.box('loginBox');
    return box.get('id') ?? '';
  }

  Future<void> changePassword(String newPassword) async {
    try {
      print("Debug: Starting changePassword method");
      isLoading.value = true;

      // Get the stored id from Hive
      final String id = getStoredId();
      if (id.isEmpty) {
        print("Debug: No ID found in Hive box");
        Get.snackbar('Error', 'ID not found');
        return;
      }
      print("Debug: Retrieved id from Hive box: $id");

      final String url =
          'https://instinctive-fish-utahceratops.glitch.me/api/v1/Main/password/$id';
      print("Debug: Constructed URL: $url");

      final response = await http.put(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: '{"password": "$newPassword"}',
      );

      print(
          "Debug: Received response with status code: ${response.statusCode}");

      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Password changed successfully');
        print("Debug: Password changed successfully");
      } else {
        Get.snackbar('Error', 'Failed to change password');
        print("Debug: Failed to change password");
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
      print("Debug: An error occurred: $e");
    } finally {
      isLoading.value = false;
      print("Debug: isLoading set to false");
    }
  }
}
