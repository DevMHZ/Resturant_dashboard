import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_resturant_dashboard/core/helpers/spacing.dart';

import '../controller/editing_info_controller.dart';

Widget buildMainCategoryEditor(BuildContext context) {
  final EditRestaurantInfoController controller =
      Get.put(EditRestaurantInfoController());
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'الاقسام الرئيسية',
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
            ),
      ),
      verticalSpace(8),
      Obx(() => ListView.builder(
            shrinkWrap: true,
            itemCount: controller.restaurant.value.mainCategory.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(controller.restaurant.value.mainCategory[index]),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () => _editMainCategory(context, index),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => _deleteMainCategory(context, index),
                    ),
                  ],
                ),
              );
            },
          )),
      verticalSpace(8),
      ElevatedButton(
        onPressed: () => _addMainCategory(context),
        child: Text(
          'اضافة قسم رئيسي',
          style: TextStyle(color: Colors.redAccent),
        ),
      ),
    ],
  );
}

void _addMainCategory(BuildContext context) {
  final EditRestaurantInfoController controller =
      Get.put(EditRestaurantInfoController());
  TextEditingController categoryController = TextEditingController();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('اضافة'),
        content: TextField(
          controller: categoryController,
          decoration: InputDecoration(hintText: 'Enter category name'),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('الغاء'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          ElevatedButton(
            child: Text('اضافة'),
            onPressed: () {
              String category = categoryController.text.trim();
              if (category.isNotEmpty) {
                controller.addMainCategory(category);
                Navigator.of(context).pop();
              } else {
                // Show error or validation message if needed
              }
            },
          ),
        ],
      );
    },
  );
}

void _deleteMainCategory(BuildContext context, int index) {
  final EditRestaurantInfoController controller =
      Get.put(EditRestaurantInfoController());
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('حذف قسم رئيسي'),
        content: Text(
            'هل انت متأكد من حذف هذا القسم "${controller.restaurant.value.mainCategory[index]}"?'),
        actions: <Widget>[
          TextButton(
            child: Text('الغاء'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: Text('حذف'),
            onPressed: () {
              controller.removeMainCategory(index);
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

void _editMainCategory(BuildContext context, int index) {
  final EditRestaurantInfoController controller =
      Get.put(EditRestaurantInfoController());
  TextEditingController categoryController = TextEditingController(
      text: controller.restaurant.value.mainCategory[index]);

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('تعديل قسم رئيسي'),
        content: TextField(
          controller: categoryController,
          decoration: InputDecoration(hintText: 'أدخل اسم القسم'),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('الغاء'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          ElevatedButton(
            child: Text('حفظ'),
            onPressed: () {
              String category = categoryController.text.trim();
              if (category.isNotEmpty) {
                controller.editMainCategory(index, category);
                Navigator.of(context).pop();
              } else {
                // Show error or validation message if needed
              }
            },
          ),
        ],
      );
    },
  );
}
