import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_resturant_dashboard/core/helpers/spacing.dart';

import '../controller/editing_info_controller.dart';

Widget buildRestaurantInformation(BuildContext context) {
  final EditRestaurantInfoController controller =
      Get.put(EditRestaurantInfoController());
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // verticalSpace(16),
      // TextFormField(
      //   initialValue: controller.restaurant.value.name,
      //   onChanged: (value) => controller.updateRestaurantName(value),
      //   decoration: InputDecoration(
      //     labelText: 'اسم المطعم',
      //     border: OutlineInputBorder(),
      //   ),
      //   validator: (value) {
      //     if (value == null || value.isEmpty) {
      //       return 'أدخل اسم المطعم';
      //     }
      //     return null;
      //   },
      // ),
      TextFormField(
        initialValue: controller.restaurant.value.titleName,
        onChanged: (value) => controller.updateRestaurantName(value),
        decoration: InputDecoration(
          labelText: 'اسم المطعم',
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'أدخل اسم المطعم';
          }
          return null;
        },
      ),
      verticalSpace(16),
      TextFormField(
        initialValue: controller.restaurant.value.phone,
        onChanged: (value) => controller.updateRestaurantPhone(value),
        decoration: InputDecoration(
          labelText: 'رقم الهاتف',
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'رجاء ادخل رقم الهاتف الخاص بالمطعم';
          }
          return null;
        },
      ),
      verticalSpace(16),
      // TextFormField(
      //   initialValue: controller.restaurant.value.profileimg,
      //   onChanged: (value) => controller.updateRestaurantProfileImg(value),
      //   decoration: InputDecoration(
      //     labelText: 'Profile Image URL',
      //     border: OutlineInputBorder(),
      //   ),
      //   validator: (value) {
      //     if (value == null || value.isEmpty) {
      //       return 'Please enter a profile image URL';
      //     }
      //     return null;
      //   },
      // ),
    ],
  );
}
