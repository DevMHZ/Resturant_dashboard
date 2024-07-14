import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:my_resturant_dashboard/core/helpers/spacing.dart';

import '../controller/editing_info_controller.dart';

Widget buildColorPicker(BuildContext context) {
  final EditRestaurantInfoController controller =
      Get.put(EditRestaurantInfoController());

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      verticalSpace(16),
      Text(
        'اللون الرئيسي',
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
            'اختر لون',
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

Color getColorFromHex(String hexColor) {
  hexColor = hexColor.replaceAll("#", "");
  if (hexColor.length == 6) {
    hexColor = "FF" + hexColor; // Add alpha channel if missing
  }
  return Color(int.parse(hexColor, radix: 16));
}

void _pickColor(BuildContext context) {
  final EditRestaurantInfoController controller =
      Get.put(EditRestaurantInfoController());
  Color currentColor = controller.restaurant.value.mainColor.isNotEmpty
      ? getColorFromHex(controller.restaurant.value.mainColor)
      : Colors.white;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('اختر لون'),
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
            child: Text('تأكيد'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
