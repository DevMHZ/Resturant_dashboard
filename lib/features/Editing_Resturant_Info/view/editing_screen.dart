// views/edit_restaurant_info_view.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_resturant_dashboard/features/Editing_Resturant_Info/controller/editing_info_controller.dart';

class EditRestaurantInfoView extends StatelessWidget {
  final RestaurantController controller = Get.put(RestaurantController());

  EditRestaurantInfoView() {
    var subDomain = getStoredSubDomain();
    controller.fetchRestaurantData(subDomain);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Restaurant Info'),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: TextEditingController(
                    text: controller.restaurant.value.name,
                  ),
                  decoration: InputDecoration(labelText: 'Name'),
                  onChanged: (value) =>
                      controller.restaurant.update((val) => val!.name = value),
                ),
                TextField(
                  controller: TextEditingController(
                    text: controller.restaurant.value.titleName,
                  ),
                  decoration: InputDecoration(labelText: 'Title Name'),
                  onChanged: (value) => controller.restaurant
                      .update((val) => val!.titleName = value),
                ),
                TextField(
                  controller: TextEditingController(
                    text: controller.restaurant.value.phone,
                  ),
                  decoration: InputDecoration(labelText: 'Phone'),
                  onChanged: (value) =>
                      controller.restaurant.update((val) => val!.phone = value),
                ),
                TextField(
                  controller: TextEditingController(
                    text: controller.restaurant.value.profileimg,
                  ),
                  decoration: InputDecoration(labelText: 'Profile Image'),
                  onChanged: (value) => controller.restaurant
                      .update((val) => val!.profileimg = value),
                ),
                TextField(
                  controller: TextEditingController(
                    text: controller.restaurant.value.mainColor,
                  ),
                  decoration: InputDecoration(labelText: 'Main Color'),
                  onChanged: (value) => controller.restaurant
                      .update((val) => val!.mainColor = value),
                ),
                // Fields for main category and subcategory can be added similarly...
                ElevatedButton(
                  onPressed: () async {
                    var id = getStoredId();
                    await controller.updateRestaurantData(
                        id, controller.restaurant.value);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Data updated successfully')),
                    );
                  },
                  child: Text('Update'),
                ),
              ],
            ),
          );
        }
      }),
    );
  }
}
