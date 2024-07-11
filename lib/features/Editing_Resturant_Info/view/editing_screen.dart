import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:my_resturant_dashboard/core/helpers/spacing.dart';
import 'package:my_resturant_dashboard/features/Editing_Resturant_Info/model/resturant_model.dart';

import '../controller/editing_info_controller.dart';

class EditRestaurantInfoView extends StatelessWidget {
  final EditRestaurantInfoController controller =
      Get.put(EditRestaurantInfoController());
  final _formKey = GlobalKey<FormState>();

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
        child: Container(
          width:
              MediaQuery.of(context).size.width > 600 ? 600 : double.infinity,
          child: Card(
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
                    _buildRestaurantInformation(context),
                    verticalSpace(20),
                    _buildColorPicker(context),
                    verticalSpace(20),
                    _buildMainCategoryEditor(context),
                    verticalSpace(20),
                    _buildSubCategoryEditor(context),
                    verticalSpace(20),
                    _buildSocialMediaAccountsEditor(context),
                    verticalSpace(20),
                    _buildUpdateButton(context),
                    verticalSpace(20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRestaurantInformation(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Restaurant Information',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
              ),
        ),
        verticalSpace(16),
        TextFormField(
          initialValue: controller.restaurant.value.name,
          onChanged: (value) => controller.updateRestaurantName(value),
          decoration: InputDecoration(
            labelText: 'Restaurant Name',
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a restaurant name';
            }
            return null;
          },
        ),
        verticalSpace(16),
        TextFormField(
          initialValue: controller.restaurant.value.titleName,
          onChanged: (value) => controller.updateRestaurantTitleName(value),
          decoration: InputDecoration(
            labelText: 'Title Name',
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a title name';
            }
            return null;
          },
        ),
        verticalSpace(16),
        TextFormField(
          initialValue: controller.restaurant.value.phone,
          onChanged: (value) => controller.updateRestaurantPhone(value),
          decoration: InputDecoration(
            labelText: 'Phone Number',
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a phone number';
            }
            return null;
          },
        ),
        verticalSpace(16),
        TextFormField(
          initialValue: controller.restaurant.value.profileimg,
          onChanged: (value) => controller.updateRestaurantProfileImg(value),
          decoration: InputDecoration(
            labelText: 'Profile Image URL',
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a profile image URL';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildColorPicker(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        verticalSpace(16),
        Text(
          'Background Color',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
              ),
        ),
        verticalSpace(8),
        InkWell(
          onTap: () => _pickColor(context),
          child: Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              color: controller.restaurant.value.mainColor.isNotEmpty
                  ? getColorFromHex(controller.restaurant.value.mainColor)
                  : Colors.white,
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.center,
            child: Text(
              'Pick a color',
              style: TextStyle(
                color: controller.restaurant.value.mainColor.isNotEmpty
                    ? useWhiteForeground(getColorFromHex(
                            controller.restaurant.value.mainColor))
                        ? Colors.white
                        : Colors.black
                    : Colors.black,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _pickColor(BuildContext context) {
    Color currentColor = controller.restaurant.value.mainColor.isNotEmpty
        ? getColorFromHex(controller.restaurant.value.mainColor)
        : Colors.white;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Pick a color'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: currentColor,
              onColorChanged: (color) {
                controller
                    .updateRestaurantMainColor(color.value.toRadixString(16));
              },
              colorPickerWidth: 300.0,
              pickerAreaHeightPercent: 0.7,
              enableAlpha: false,
              displayThumbColor: true,
              showLabel: true,
              paletteType: PaletteType.hsv,
              pickerAreaBorderRadius: const BorderRadius.only(
                topLeft: const Radius.circular(2.0),
                topRight: const Radius.circular(2.0),
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Done'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildMainCategoryEditor(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Main Categories',
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
          child: Text('Add Main Category'),
        ),
      ],
    );
  }

  Widget _buildSubCategoryEditor(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Sub Categories',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
              ),
        ),
        verticalSpace(8),
        Obx(() => ListView.builder(
              shrinkWrap: true,
              itemCount: controller.restaurant.value.subCategory.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title:
                      Text(controller.restaurant.value.subCategory[index].name),
                  subtitle: Text(controller
                      .restaurant.value.subCategory[index].description),
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
          child: Text('Add Sub Category'),
        ),
      ],
    );
  }

  Widget _buildSocialMediaAccountsEditor(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Social Media Accounts',
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
            labelText: 'Social Media Accounts (comma-separated)',
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }

  Widget _buildUpdateButton(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            controller.updateRestaurantData(context);
          }
        },
        child: Text('Update Restaurant Data'),
      ),
    );
  }

  void _addMainCategory(BuildContext context) {
    TextEditingController categoryController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Main Category'),
          content: TextField(
            controller: categoryController,
            decoration: InputDecoration(hintText: 'Enter category name'),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text('Add'),
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

  void _editMainCategory(BuildContext context, int index) {
    TextEditingController categoryController = TextEditingController(
        text: controller.restaurant.value.mainCategory[index]);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Main Category'),
          content: TextField(
            controller: categoryController,
            decoration: InputDecoration(hintText: 'Enter category name'),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text('Save'),
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

  void _deleteMainCategory(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Main Category'),
          content: Text(
              'Are you sure you want to delete "${controller.restaurant.value.mainCategory[index]}"?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: Text('Delete'),
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

  void _addSubCategory(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Sub Category'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(hintText: 'Enter name'),
              ),
              verticalSpace(8),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(hintText: 'Enter description'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text('Add'),
              onPressed: () {
                String name = nameController.text.trim();
                String description = descriptionController.text.trim();
                if (name.isNotEmpty) {
                  SubCategory newSubCategory = SubCategory(
                    id: '',
                    name: name,
                    description: description,
                    mainCategory: '',
                    price: '',
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
    TextEditingController nameController = TextEditingController(
        text: controller.restaurant.value.subCategory[index].name);
    TextEditingController descriptionController = TextEditingController(
        text: controller.restaurant.value.subCategory[index].description);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Sub Category'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(hintText: 'Enter name'),
              ),
              verticalSpace(8),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(hintText: 'Enter description'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text('Save'),
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
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Sub Category'),
          content: Text(
              'Are you sure you want to delete "${controller.restaurant.value.subCategory[index].name}"?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: Text('Delete'),
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

  Color getColorFromHex(String hexColor) {
    hexColor = hexColor.replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor; // Add alpha channel if missing
    }
    return Color(int.parse(hexColor, radix: 16));
  }
}
