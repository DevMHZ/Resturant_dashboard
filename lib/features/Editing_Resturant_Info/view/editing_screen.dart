import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_resturant_dashboard/features/Editing_Resturant_Info/controller/editing_info_controller.dart';
import 'package:my_resturant_dashboard/features/Editing_Resturant_Info/model/resturant_model.dart';

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
                    _buildTextFields(context),
                    SizedBox(height: 20),
                    _buildColorPicker(context),
                    SizedBox(height: 20),
                    _buildMainCategoryEditor(context),
                    SizedBox(height: 20),
                    _buildSubCategoryEditor(context),
                    SizedBox(height: 20),
                    _buildUpdateButton(context),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMainCategoryEditor(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Main Categories',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        SizedBox(height: 8),
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
        SizedBox(height: 8),
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
          style: Theme.of(context).textTheme.titleLarge,
        ),
        SizedBox(height: 8),
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
        SizedBox(height: 8),
        ElevatedButton(
          onPressed: () => _addSubCategory(context),
          child: Text('Add Sub Category'),
        ),
      ],
    );
  }

  Widget _buildTextFields(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Restaurant Information',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        SizedBox(height: 16),
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
        SizedBox(height: 16),
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
        SizedBox(height: 16),
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
        SizedBox(height: 16),
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
        SizedBox(height: 16),
        Text(
          'Main Color',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        SizedBox(height: 8),
        InkWell(
          onTap: () => controller.pickColor(context),
          child: Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              color: controller.restaurant.value.mainColor.isNotEmpty
                  ? controller
                      .getColorFromHex(controller.restaurant.value.mainColor)
                  : Colors.white,
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.center,
            child: Text(
              'Pick a color',
              style: TextStyle(
                color: controller.restaurant.value.mainColor.isNotEmpty
                    ? controller.useWhiteForeground(controller.getColorFromHex(
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

  Widget _buildUpdateButton(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            controller.updateRestaurantData(
              context, // Correctly passing the BuildContext
            );
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
              SizedBox(height: 8),
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
                    id: '', // Generate or assign a unique ID
                    mainCategory: '', // Assign appropriate main category
                    name: name,
                    price: '0', // Default price or value
                    img: '', // Default image URL or empty
                    description: description, // Default description or empty
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
              SizedBox(height: 8),
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
                    mainCategory: controller
                        .restaurant.value.subCategory[index].mainCategory,
                    name: name,
                    price: controller.restaurant.value.subCategory[index].price,
                    img: controller.restaurant.value.subCategory[index].img,
                    description: description,
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
}
