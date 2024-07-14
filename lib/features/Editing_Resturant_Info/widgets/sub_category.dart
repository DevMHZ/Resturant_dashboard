import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_resturant_dashboard/core/helpers/spacing.dart';
import 'package:my_resturant_dashboard/features/Editing_Resturant_Info/model/resturant_model.dart';
import '../controller/editing_info_controller.dart';

Widget buildSubCategoryEditor(BuildContext context) {
  final EditRestaurantInfoController controller =
      Get.put(EditRestaurantInfoController());
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Obx(() => ListView.builder(
            shrinkWrap: true,
            itemCount: controller.restaurant.value.subCategory.length,
            itemBuilder: (context, index) {
              return ListTile(
                title:
                    Text(controller.restaurant.value.subCategory[index].name),
                subtitle: Text(
                    controller.restaurant.value.subCategory[index].description),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () => _editSubCategory(context, index),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => _deleteSubCategory(context, index),
                    ),
                  ],
                ),
              );
            },
          )),
      verticalSpace(8),
      ElevatedButton(
        onPressed: () => _addSubCategory(context),
        child: Text(
          'أضف طبق',
          style: TextStyle(color: Colors.redAccent),
        ),
      ),
    ],
  );
}

void _addSubCategory(BuildContext context) {
  final EditRestaurantInfoController controller =
      Get.put(EditRestaurantInfoController());
  TextEditingController mainCategoryController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('اضافة الطبق'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(hintText: 'ادخل اسم الطبق'),
            ),
            verticalSpace(8),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(hintText: 'ادخل الوصف الخاص بالطبق'),
            ),
            verticalSpace(8),
            TextField(
              controller: priceController,
              decoration: InputDecoration(hintText: 'ادخل السعر الخاص بالطبق'),
            ),
            verticalSpace(8),
            TextField(
              controller: mainCategoryController,
              decoration: InputDecoration(hintText: 'القسم الخاص بالطبق'),
            ),
          ],
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
              String mainCategory = mainCategoryController.text.trim();
              String name = nameController.text.trim();
              String description = descriptionController.text.trim();
              String price = priceController.text.trim();
              if (name.isNotEmpty) {
                SubCategory newSubCategory = SubCategory(
                  id: '668e5a64043fc3a49d0916b3',
                  name: name,
                  description: description,
                  mainCategory: mainCategory,
                  price: price,
                  img: '',
                );
                controller.addSubCategory(newSubCategory);
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

void _editSubCategory(BuildContext context, int index) {
  final EditRestaurantInfoController controller =
      Get.put(EditRestaurantInfoController());
  TextEditingController nameController = TextEditingController(
      text: controller.restaurant.value.subCategory[index].name);
  TextEditingController descriptionController = TextEditingController(
      text: controller.restaurant.value.subCategory[index].description);

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('تعديل الطبق'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(hintText: 'ادخل الاسم'),
            ),
            verticalSpace(8),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(hintText: 'ادخل الوصف'),
            ),
          ],
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
              String name = nameController.text.trim();
              String description = descriptionController.text.trim();
              if (name.isNotEmpty) {
                SubCategory updatedSubCategory = SubCategory(
                  id: controller.restaurant.value.subCategory[index].id,
                  name: name,
                  description: description,
                  mainCategory: controller
                      .restaurant.value.subCategory[index].mainCategory,
                  price: controller.restaurant.value.subCategory[index].price,
                  img: controller.restaurant.value.subCategory[index].img,
                );
                controller.editSubCategory(index, updatedSubCategory);
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

void _deleteSubCategory(BuildContext context, int index) {
  final EditRestaurantInfoController controller =
      Get.put(EditRestaurantInfoController());
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('حذف طبق'),
        content: Text(
            'هل أنت متأكد "${controller.restaurant.value.subCategory[index].name}"?'),
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
              controller.removeSubCategory(index);
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
