
class Restaurant {
  String id;
  String name;
  String titleName;
  String phone;
  String subDomain;
  String endDate;
  String profileimg;
  String mainColor;
  String password;
  List<String> mainCategory;
  List<SubCategory> subCategory;

  Restaurant({
    required this.id,
    required this.name,
    required this.titleName,
    required this.phone,
    required this.subDomain,
    required this.endDate,
    required this.profileimg,
    required this.mainColor,
    required this.password,
    required this.mainCategory,
    required this.subCategory,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      id: json['_id'],
      name: json['name'],
      titleName: json['titleName'],
      phone: json['phone'],
      subDomain: json['subDomain'],
      endDate: json['endDate'],
      profileimg: json['profileimg'],
      mainColor: json['mainColor'],
      password: json['password'],
      mainCategory: List<String>.from(json['maincategory']),
      subCategory: (json['subcategory'] as List)
          .map((i) => SubCategory.fromJson(i))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'titleName': titleName,
      'phone': phone,
      'subDomain': subDomain,
      'endDate': endDate,
      'profileimg': profileimg,
      'mainColor': mainColor,
      'password': password,
      'maincategory': mainCategory,
      'subcategory': subCategory.map((i) => i.toJson()).toList(),
    };
  }
}

class SubCategory {
  String id;
  String mainCategory;
  String name;
  String price;
  String img;
  String description;

  SubCategory({
    required this.id,
    required this.mainCategory,
    required this.name,
    required this.price,
    required this.img,
    required this.description,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) {
    return SubCategory(
      id: json['_id'],
      mainCategory: json['maincategory'],
      name: json['name'],
      price: json['price'],
      img: json['img'],
      description: json['des'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'maincategory': mainCategory,
      'name': name,
      'price': price,
      'img': img,
      'des': description,
    };
  }
}