import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_resturant_dashboard/core/helpers/spacing.dart';
import '../controller/editing_info_controller.dart';

Widget buildSocialMediaAccountsEditor(BuildContext context) {
  final EditRestaurantInfoController controller =
      Get.put(EditRestaurantInfoController());
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'حسابات السوشل ميديا',
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
            ),
      ),
      verticalSpace(8),
      TextFormField(
        initialValue: controller.restaurant.value.socialMediaAccounts
            .join(', '), // Convert list to comma-separated string
        onChanged: (value) {
          List<String> accounts = value
              .split(',')
              .map((e) => e.trim())
              .toList(); // Split string into list of accounts
          controller.updateRestaurantSocialMediaAccounts(accounts);
        },
        decoration: InputDecoration(
          labelText: 'Social Media Accounts (بين كل رابط فاصلة)',
          border: OutlineInputBorder(),
        ),
      ),
    ],
  );
}
