import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_resturant_dashboard/features/My_Resturant/controller/my_restu_controller.dart';
import 'package:my_resturant_dashboard/features/My_Resturant/widgets/info_widget.dart';

class MyResturantMainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MyResturantMainScreenController userController =
        Get.put(MyResturantMainScreenController());

    return Scaffold(
      body: Obx(() {
        if (userController.userData.value.subDomain == '') {
          return Center(child: CircularProgressIndicator());
        } else {
          return SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'معلومات المطعم',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                SizedBox(height: 16),
                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        InfoRow(
                            label: 'Sub Domain',
                            value: userController.userData.value.subDomain),
                        InfoRow(
                            label: 'الاسم',
                            value: userController.userData.value.name),
                        InfoRow(
                            label: 'الاسم التايتل',
                            value: userController.userData.value.titleName),
                        InfoRow(
                            label: 'الرقم',
                            value: userController.userData.value.phone),
                        InfoRow(
                            label: 'تاريخ انتهاء صلاحية الاشتراك',
                            value: userController.userData.value.endDate),
                        InfoRow(
                            label: 'صورة المطعم',
                            value: userController.userData.value.profileimg),
                        InfoRow(
                            label: 'اللون الرئيسي',
                            value: userController.userData.value.mainColor),
                        InfoRow(
                            label: 'Main category',
                            value: userController.userData.value.mainCategory
                                .join(", ")),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Subcategories',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                SizedBox(height: 16),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: userController.userData.value.subCategory.length,
                  itemBuilder: (context, index) {
                    var subCategory =
                        userController.userData.value.subCategory[index];
                    return Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            InfoRow(
                                label: 'القسم الرئيسي',
                                value: subCategory.mainCategory),
                            InfoRow(label: 'الاسم', value: subCategory.name),
                            InfoRow(label: 'السعر', value: subCategory.price),
                            InfoRow(label: 'صورة', value: subCategory.img),
                            InfoRow(
                                label: 'الوصف', value: subCategory.description),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        }
      }),
    );
  }
}
