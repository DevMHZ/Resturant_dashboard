import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_resturant_dashboard/core/helpers/spacing.dart';
import 'package:my_resturant_dashboard/features/Editing_Resturant_Info/model/resturant_model.dart';
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
  final _addSubCategoryFormKey = GlobalKey<FormState>();

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
            children: [
              Card(
                color: Colors.white,
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                        buildHeader(context, 'إضافة صنف جديد'),
                        verticalSpace(10),
                        buildAddSubCategoryForm(context),
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
    return FloatingActionButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          controller.updateRestaurantData(context);
        }
      },
      backgroundColor: Colors.redAccent,
      child: Icon(Icons.save),
    );
  }

  Widget buildSubCategoryEditor(BuildContext context) {
    return Column(
      children: List.generate(
        controller.restaurant.value.subCategory.length,
        (index) {
          var subCategory = controller.restaurant.value.subCategory[index];
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'تعديل ${subCategory.name}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  verticalSpace(10),
                  TextFormField(
                    initialValue: subCategory.name,
                    decoration: InputDecoration(labelText: 'اسم الصنف'),
                    onChanged: (value) {
                      subCategory.name = value;
                    },
                  ),
                  TextFormField(
                    initialValue: subCategory.price,
                    decoration: InputDecoration(labelText: 'السعر'),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      subCategory.price = value;
                    },
                  ),
                  TextFormField(
                    initialValue: subCategory.description,
                    decoration: InputDecoration(labelText: 'الوصف'),
                    onChanged: (value) {
                      subCategory.description = value;
                    },
                  ),
                  DropdownButtonFormField<String>(
                    value: controller.restaurant.value.mainCategory
                            .contains(subCategory.mainCategory)
                        ? subCategory.mainCategory
                        : null, // Handle default/null value
                    decoration: InputDecoration(labelText: 'الفئة الرئيسية'),
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
                  verticalSpace(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: Icon(Icons.image),
                        onPressed: () => _pickAndUploadImage(index),
                      ),
                      IconButton(
                        icon: Icon(Icons.save),
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

  Widget buildAddSubCategoryForm(BuildContext context) {
    final _nameController = TextEditingController();
    final _priceController = TextEditingController();
    final _descriptionController = TextEditingController();
    final _selectedMainCategory = ValueNotifier<String?>(null);
    final _imagePath = ValueNotifier<String>('');
    final _idController =
        TextEditingController(); // Or generate the ID as needed

    Future<void> _pickAndUploadImage() async {
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result != null) {
        PlatformFile file = result.files.first;
        try {
          String imageUrl =
              await controller.uploadImage(file); // Adjust method call
          _imagePath.value = imageUrl;
        } catch (e) {
          print('Error uploading image: $e');
          // Handle error (show message to user, etc.)
        }
      }
    }

    return Form(
      key: _addSubCategoryFormKey,
      child: Card(
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
                'إضافة صنف جديد',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              verticalSpace(12),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'اسم الصنف',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'الاسم مطلوب';
                  }
                  return null;
                },
              ),
              verticalSpace(10),
              TextFormField(
                controller: _priceController,
                decoration: InputDecoration(
                  labelText: 'السعر',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'السعر مطلوب';
                  }
                  return null;
                },
              ),
              verticalSpace(10),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'الوصف',
                  border: OutlineInputBorder(),
                ),
                maxLines: 2,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'الوصف مطلوب';
                  }
                  return null;
                },
              ),
              verticalSpace(10),
              DropdownButtonFormField<String>(
                value: _selectedMainCategory.value,
                decoration: InputDecoration(
                  labelText: 'الفئة الرئيسية',
                  border: OutlineInputBorder(),
                ),
                items: controller.restaurant.value.mainCategory.map((category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    _selectedMainCategory.value = value;
                  }
                },
                validator: (value) {
                  if (value == null) {
                    return 'الفئة الرئيسية مطلوبة';
                  }
                  return null;
                },
              ),
              verticalSpace(10),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: _pickAndUploadImage,
                    child: Text('اختيار صورة'),
                  ),
                  SizedBox(width: 10),
                  ValueListenableBuilder<String>(
                    valueListenable: _imagePath,
                    builder: (context, path, child) {
                      return Text(path.isEmpty
                          ? 'لم يتم اختيار صورة'
                          : 'تم اختيار صورة: $path');
                    },
                  ),
                ],
              ),
              verticalSpace(10),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () {
                    if (_addSubCategoryFormKey.currentState!.validate()) {
                      var newSubCategory = SubCategory(
                        id: "668e5a64043fc3a49d0916b4",
                        name: _nameController.text,
                        price: _priceController.text,
                        description: _descriptionController.text,
                        mainCategory: _selectedMainCategory.value!,
                        img: _imagePath.value,
                      );
                      controller.addSubCategory(newSubCategory);
                      _nameController.clear();
                      _priceController.clear();
                      _descriptionController.clear();
                      _selectedMainCategory.value = null;
                      _imagePath.value = '';
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  ),
                  child: Text(
                    'إضافة صنف',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
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

  Future<void> _pickAndUploadImage(int index) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      PlatformFile file = result.files.first;
      await controller.updateSubCategoryWithImage(index, file);
    }
  }
}
