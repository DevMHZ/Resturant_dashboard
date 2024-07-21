import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_resturant_dashboard/core/helpers/spacing.dart';
import '../controller/editing_info_controller.dart';
import '../widgets/card_color_editing.dart';
import '../widgets/main_category.dart';
import '../widgets/main_color_editing.dart';
import '../widgets/resturant_information.dart';
import '../widgets/social_media.dart';

class EditRestaurantInfoView extends StatelessWidget {
  final EditRestaurantInfoController controller =
      Get.put(EditRestaurantInfoController());
  final _formKey = GlobalKey<FormState>();

  Future<void> _pickAndUploadImage(int index) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      PlatformFile file = result.files.first;
      await controller.updateSubCategoryWithImage(index, file);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.scaffoldKey,
      backgroundColor: Colors.grey[200],
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else {
          return _buildUI(context);
        }
      }),
    );
  }

  Widget _buildUI(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(26.0),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 800),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                color: Colors.white,
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        buildHeader(context, 'معلومات المطعم'),
                        verticalSpace(20),
                        buildRestaurantInformation(context),
                        verticalSpace(20),
                        buildHeader(context, 'تعديل الألوان الخاصة بالمطعم'),
                        verticalSpace(10),
                        buildColorPicker(context),
                        verticalSpace(20),
                        buildCardColorPicker(context),
                        verticalSpace(20),
                        buildHeader(
                            context, 'تعديل الأقسام الرئيسية و الأطباق'),
                        verticalSpace(10),
                        buildMainCategoryEditor(context),
                        verticalSpace(20),
                        buildHeader(context, 'تعديل الأطباق'),
                        verticalSpace(10),
                        buildSubCategoryEditor(context),
                        verticalSpace(20),
                        buildHeader(context, 'تعديل حسابات التواصل الاجتماعي'),
                        verticalSpace(10),
                        buildSocialMediaAccountsEditor(context),
                        verticalSpace(20),
                        _buildUpdateButton(context),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildHeader(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleLarge!.copyWith(
            color: Colors.redAccent,
            fontWeight: FontWeight.bold,
          ),
    );
  }

  Widget _buildUpdateButton(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            controller.updateRestaurantData(context);
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.redAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
        ),
        child: Text(
          'تحديث المعلومات',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget buildSubCategoryEditor(BuildContext context) {
    return Column(
      children: List.generate(
        controller.restaurant.value.subCategory.length,
        (index) {
          var subCategory = controller.restaurant.value.subCategory[index];
          return Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            margin: EdgeInsets.symmetric(vertical: 8),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'تعديل ${subCategory.name}',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  verticalSpace(12),
                  TextFormField(
                    initialValue: subCategory.name,
                    decoration: InputDecoration(
                      labelText: 'اسم الصنف',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      subCategory.name = value;
                    },
                  ),
                  verticalSpace(10),
                  TextFormField(
                    initialValue: subCategory.price,
                    decoration: InputDecoration(
                      labelText: 'السعر',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      subCategory.price = value;
                    },
                  ),
                  verticalSpace(10),
                  TextFormField(
                    initialValue: subCategory.description,
                    decoration: InputDecoration(
                      labelText: 'الوصف',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 2,
                    onChanged: (value) {
                      subCategory.description = value;
                    },
                  ),
                  verticalSpace(10),
                  DropdownButtonFormField<String>(
                    value: controller.restaurant.value.mainCategory
                            .contains(subCategory.mainCategory)
                        ? subCategory.mainCategory
                        : null,
                    decoration: InputDecoration(
                      labelText: 'الفئة الرئيسية',
                      border: OutlineInputBorder(),
                    ),
                    items: controller.restaurant.value.mainCategory
                        .map((category) {
                      return DropdownMenuItem(
                        value: category,
                        child: Text(category),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        subCategory.mainCategory = value;
                      }
                    },
                  ),
                  verticalSpace(12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: Icon(Icons.image, color: Colors.blueAccent),
                        onPressed: () => _pickAndUploadImage(index),
                      ),
                      IconButton(
                        icon: Icon(Icons.save, color: Colors.green),
                        onPressed: () {
                          controller.editSubCategory(index, subCategory);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
