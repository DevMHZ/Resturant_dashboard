import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_resturant_dashboard/features/editing_password_screen/controller/editing_pass_controller.dart';

class ChangePasswordScreen extends StatelessWidget {
  final ChangePasswordController controller =
      Get.put(ChangePasswordController());
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'New Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            Obx(() => controller.isLoading.value
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () {
                      controller.changePassword(_passwordController.text);
                    },
                    child: Text('Change Password'),
                  )),
          ],
        ),
      ),
    );
  }
}
