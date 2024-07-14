import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_resturant_dashboard/Features/My_Resturant/controller/my_restu_controller.dart';
import 'package:my_resturant_dashboard/core/helpers/spacing.dart';
import 'package:my_resturant_dashboard/features/My_Resturant/widgets/build_card.dart';
import '../widgets/info_widget.dart';

class MyResturantMainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MyResturantMainScreenController userController =
        Get.put(MyResturantMainScreenController());

    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Obx(() {
        if (userController.userData.value.subDomain == '') {
          return Center(child: CircularProgressIndicator());
        } else {
          return SingleChildScrollView(
            padding: EdgeInsets.all(22.0),
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 1200),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    buildHeader(context, 'معلومات المطعم'),
                    verticalSpace(16),
                    buildRestaurantInfoCard(context, userController),
                    verticalSpace(16),
                    buildHeader(context, 'الأطباق'),
                    verticalSpace(16),
                    buildDishesList(context, userController),
                  ],
                ),
              ),
            ),
          );
        }
      }),
    );
  }

  Widget buildHeader(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.headlineMedium!.copyWith(
            color: Colors.redAccent,
            fontWeight: FontWeight.bold,
          ),
    );
  }

  Widget buildRestaurantInfoCard(
      BuildContext context, MyResturantMainScreenController userController) {
    return buildCard(
      context,
      children: [
        InfoRow(
          label: 'Sub Domain',
          value: userController.userData.value.subDomain,
          icon: Icons.language,
        ),
        InfoRow(
          label: 'الاسم',
          value: userController.userData.value.titleName,
          icon: Icons.label,
        ),
        InfoRow(
          label: 'الرقم',
          value: userController.userData.value.phone,
          icon: Icons.phone,
        ),
        InfoRow(
          label: 'تاريخ انتهاء صلاحية الاشتراك',
          value: userController.userData.value.endDate,
          icon: Icons.calendar_today,
        ),
        InfoRow(
          label: 'صورة المطعم',
          value: userController.userData.value.profileimg,
          icon: Icons.image,
        ),
        InfoRow(
          label: 'اللون الرئيسي',
          value: userController.userData.value.mainColor,
          icon: Icons.color_lens,
        ),
        InfoRow(
          label: 'الاقسام الرئيسية',
          value: userController.userData.value.mainCategory.join(", "),
          icon: Icons.restaurant_menu,
        ),
      ],
    );
  }

  Widget buildDishesList(
      BuildContext context, MyResturantMainScreenController userController) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: userController.userData.value.subCategory.length,
      itemBuilder: (context, index) {
        var subCategory = userController.userData.value.subCategory[index];
        return buildDishCard(context, subCategory);
      },
    );
  }

  Widget buildDishCard(BuildContext context, var subCategory) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              subCategory.name,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            verticalSpace(8),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('السعر: ${subCategory.price}',
                          style: TextStyle(fontSize: 16)),
                      verticalSpace(4),
                      Text('القسم الرئيسي: ${subCategory.mainCategory}',
                          style: TextStyle(fontSize: 16)),
                      verticalSpace(4),
                      Text('الوصف: ${subCategory.description}',
                          style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ),
                verticalSpace(8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    subCategory.img,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
