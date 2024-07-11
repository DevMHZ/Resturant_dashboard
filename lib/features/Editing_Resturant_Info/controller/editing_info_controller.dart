import 'dart:convert';
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

  void addSubCategory(SubCategory subCategory) {
    restaurant.update((val) {
      val!.subCategory.add(subCategory);
    });
  }

  void editSubCategory(int index, SubCategory subCategory) {
    restaurant.update((val) {
      val!.subCategory[index] = subCategory;
    });
  }

  void removeSubCategory(int index) {
    restaurant.update((val) {
      val!.subCategory.removeAt(index);
    });
  }

  void pickColor(BuildContext context) {
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

  void updateRestaurantSocialMediaAccounts(List<String> accounts) {
    restaurant.update((val) {
      val!.socialMediaAccounts = accounts;
    });
  }

  String getStoredSubDomain() {
    var box = Hive.box('loginBox');
    return box.get('subDomain') ?? '';
  }

  String getStoredId() {
    var box = Hive.box('loginBox');
    return box.get('id') ?? '';
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

  void updateRestaurantData(BuildContext context) {
    final updatedData =
        restaurant.value; // Assuming restaurant.value has the latest data
    final id = getStoredId();
    isLoading.value = true;
    print('Updating restaurant data...');
    http
        .put(Uri.parse(ApiConstants.updateRestaurantData(id)),
            headers: {
              'Content-Type': 'application/json',
            },
            body: json.encode(updatedData.toJson()))
        .then((response) {
      if (response.statusCode == 200) {
        print('Restaurant data updated successfully.');
        restaurant.value =
            Restaurant.fromJson(jsonDecode(response.body)['data']);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Data updated successfully')));

        // Notify MyResturantMainScreenController to refetch data
        final MyResturantMainScreenController myResturantController =
            Get.find();
        myResturantController.fetchMyResturantData(getStoredSubDomain());
      } else {
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

  void updateRestaurantMainColor(String color) {
    restaurant.update((val) {
      val!.mainColor = color;
    });
  }

  void updateRestaurantName(String name) {
    restaurant.update((val) {
      val!.name = name;
    });
  }

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

  void updateRestaurantProfileImg(String profileImg) {
    restaurant.update((val) {
      val!.profileimg = profileImg;
    });
  }
}
