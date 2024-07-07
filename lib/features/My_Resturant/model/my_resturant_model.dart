class MyResturantData {
  final String subDomain;
   final String id;
  final String name;
  final String titleName;
  final String phone;
  final String endDate;
  final String profileimg;
  final String mainColor;
  final String password;
  final List<String> mainCategory;
  final List<SubCategory> subCategory;

  MyResturantData( {
   required this.id,
    required this.subDomain,
    required this.name,
    required this.titleName,
    required this.phone,
    required this.endDate,
    required this.profileimg,
    required this.mainColor,
    required this.password,
    required this.mainCategory,
    required this.subCategory,
  });

  factory MyResturantData.fromJson(Map<String, dynamic> json) {
    var list = json['subcategory'] as List;
    List<SubCategory> subCategoryList =
        list.map((i) => SubCategory.fromJson(i)).toList();

    return MyResturantData(
      subDomain: json['subDomain'],
      name: json['name'],
      titleName: json['titleName'],
      phone: json['phone'],
      endDate: json['endDate'],
      profileimg: json['profileimg'],
      mainColor: json['mainColor'],
      password: json['password'],
      mainCategory: List<String>.from(json['maincategory']),
      subCategory: subCategoryList, id: json['_id'],
    );
  }
}

class SubCategory {
  final String mainCategory;
  final String name;
  final String price;
  final String img;
  final String description;

  SubCategory({
    required this.mainCategory,
    required this.name,
    required this.price,
    required this.img,
    required this.description,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) {
    return SubCategory(
      mainCategory: json['maincategory'],
      name: json['name'],
      price: json['price'],
      img: json['img'],
      description: json['des'],
    );
  }
}
