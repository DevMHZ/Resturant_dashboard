import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:my_resturant_dashboard/core/networking/api_constants.dart';
import 'package:my_resturant_dashboard/features/Editing_Resturant_Info/model/resturant_model.dart';
import 'package:http/http.dart' as http;

import '../../My_Resturant/controller/my_restu_controller.dart';

class EditRestaurantInfoController extends GetxController {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  RxBool isLoading = false.obs;
  Rx<Restaurant> restaurant = Restaurant(
    id: '',
    name: '',
    titleName: '',
    phone: '',
    subDomain: '',
    endDate: '',
    profileimg: '',
    mainColor: '',
    password: '',
    mainCategory: [],
    subCategory: [],
    socialMediaAccounts: [],
    backgroundColor: '',
    cardColor: '',
    primaryColor: '',
  ).obs;

  EditRestaurantInfoController() {
    var subDomain = getStoredSubDomain();
    fetchRestaurantData(subDomain);
  }
//Main Categories

  void addMainCategory(String category) {
    restaurant.update((val) {
      val!.mainCategory.add(category);
    });
  }

  void editMainCategory(int index, String category) {
    restaurant.update((val) {
      val!.mainCategory[index] = category;
    });
  }

  void removeMainCategory(int index) {
    restaurant.update((val) {
      val!.mainCategory.removeAt(index);
    });
  }

//Sub Categories
  // void addSubCategory(SubCategory subCategory) {
  //   restaurant.update((val) {
  //     val!.subCategory.add(subCategory);
  //   });
  // }

  void removeSubCategory(int index) {
    restaurant.update((val) {
      val!.subCategory.removeAt(index);
    });
  }
//Colors

  void pickMainColor(BuildContext context) {
    Color currentColor = restaurant.value.mainColor.isNotEmpty
        ? getColorFromHex(restaurant.value.mainColor)
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
                updateRestaurantMainColor(color.value.toRadixString(16));
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

//Social media
  void updateRestaurantSocialMediaAccounts(List<String> accounts) {
    restaurant.update((val) {
      val!.socialMediaAccounts = accounts;
    });
  }

//Colors Modif
  void updateRestaurantMainColor(String color) {
    restaurant.update((val) {
      val!.mainColor = color;
    });
  }

  void updateRestaurantCardColor(String color) {
    restaurant.update((val) {
      val!.cardColor = color;
    });
  }

  Color getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor; // Adding alpha value if missing
    }
    return Color(int.parse(hexColor, radix: 16));
  }

  bool useWhiteForeground(Color color) {
    return color.computeLuminance() > 0.5;
  }

// Fetch Data before and after Editing
  void fetchRestaurantData(String subDomain) async {
    isLoading.value = true;
    final response = await http.get(
      Uri.parse(ApiConstants.getRestaurantDataBySubDomain(subDomain)),
    );

    if (response.statusCode == 200) {
      restaurant.value = Restaurant.fromJson(jsonDecode(response.body)['data']);
    } else {
      throw Exception('Failed to load user data');
    }
    isLoading.value = false;
  }

//Updating Data main Function
  void updateRestaurantData(BuildContext context) {
    final updatedData = restaurant.value;
    final id = getStoredId();
    isLoading.value = true;

    http
        .put(
      Uri.parse(ApiConstants.updateRestaurantData(id)),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(updatedData.toJson()),
    )
        .then((response) {
      if (response.statusCode == 200) {
        print('Restaurant data updated successfully.');
        restaurant.value =
            Restaurant.fromJson(jsonDecode(response.body)['data']);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Data updated successfully')));

        final MyResturantMainScreenController myResturantController =
            Get.find();
        myResturantController.fetchMyResturantData(getStoredSubDomain());
      } else {
        print('Failed to update restaurant data: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception(
            'Failed to update restaurant data: ${response.statusCode}');
      }
    }).catchError((e) {
      print('Update restaurant data error: $e');
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Failed to update data')));
    }).whenComplete(() {
      isLoading.value = false;
    });
  }

//Resturant Name (Used for Login)
  void updateRestaurantName(String name) {
    restaurant.update((val) {
      val!.name = name;
    });
  }
//Resturant Name (Used for Res Info for User)

  void updateRestaurantTitleName(String titleName) {
    restaurant.update((val) {
      val!.titleName = titleName;
    });
  }

  void updateRestaurantPhone(String phone) {
    restaurant.update((val) {
      val!.phone = phone;
    });
  }

  void editSubCategory(int index, SubCategory updatedSubCategory) {
    print('Updating subcategory at index: $index');
    print('New subcategory details: ${updatedSubCategory.toJson()}');
    restaurant.update((val) {
      if (val != null && index >= 0 && index < val.subCategory.length) {
        val.subCategory[index] = updatedSubCategory;
      }
    });
  }

  void addSubCategory(SubCategory subCategory) {
    restaurant.update((val) {
      val!.subCategory.add(subCategory);
    });
  }

  Future<String> uploadImage(PlatformFile file) async {
    print('Starting image upload...'); // Debugging point
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(
          'https://instinctive-fish-utahceratops.glitch.me/api/v1/upload'),
    );
    request.files.add(http.MultipartFile.fromBytes('image', file.bytes!,
        filename: file.name));
    print('Sending request to server...'); // Debugging point
    var response = await request.send();
    print(
        'Response received with status code: ${response.statusCode}'); // Debugging point
    if (response.statusCode == 200) {
      var responseData = await response.stream.bytesToString();
      print('Response data: $responseData'); // Debugging point
      return responseData.trim();
    } else {
      var responseData = await response.stream.bytesToString();
      print('Server error response data: $responseData'); // Debugging point
      throw Exception('Failed to upload image: ${response.statusCode}');
    }
  }

  Future<void> updateSubCategoryWithImage(int index, PlatformFile file) async {
    try {
      print('Uploading image for subcategory index: $index'); // Debugging point
      String imageUrl = await uploadImage(file);

      print(
          'Image uploaded successfully. Image URL: $imageUrl'); // Debugging point

      // Fetch the current subcategory
      var updatedSubCategory = restaurant.value.subCategory[index];
      // Update the image URL
      updatedSubCategory.img = imageUrl;

      print('Updating subcategory with new image URL...'); // Debugging point
      // Call the editSubCategory method to update it
      editSubCategory(index, updatedSubCategory);
      print(
          'Current restaurant subcategories: ${restaurant.value.subCategory.map((sc) => sc.toJson()).toList()}');

      print('Subcategory updated successfully'); // Debugging point
    } catch (e) {
      print('Error uploading image: $e'); // Debugging point
    }
  }

  String getStoredSubDomain() {
    var box = Hive.box('loginBox');
    return box.get('subDomain') ?? '';
  }

  String getStoredId() {
    var box = Hive.box('loginBox');
    return box.get('id') ?? '';
  }
}
