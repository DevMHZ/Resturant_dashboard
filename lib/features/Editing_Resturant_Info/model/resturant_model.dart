class Restaurant {
  String id;
  String name;
  String titleName;
  String phone;
  String subDomain;
  String endDate;
  String profileimg;
  String mainColor;
  String backgroundColor; // New field
  String cardColor; // New field
  String primaryColor; // New field
  String password;
  List<String> mainCategory;
  List<SubCategory> subCategory;
  List<String> socialMediaAccounts;

  Restaurant({
    required this.id,
    required this.name,
    required this.titleName,
    required this.phone,
    required this.subDomain,
    required this.endDate,
    required this.profileimg,
    required this.mainColor,
    required this.backgroundColor, // Include new fields in constructor
    required this.cardColor,
    required this.primaryColor,
    required this.password,
    required this.mainCategory,
    required this.subCategory,
    required this.socialMediaAccounts,
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
      backgroundColor: json['background_color'], // Parse new fields
      cardColor: json['card_color'],
      primaryColor: json['primery_color'], // Correct typo if needed
      password: json['password'],
      mainCategory: List<String>.from(json['maincategory']),
      subCategory: (json['subcategory'] as List)
          .map((i) => SubCategory.fromJson(i))
          .toList(),
      socialMediaAccounts: List<String>.from(json['social_media_account']),
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
      'background_color': backgroundColor, // Serialize new fields
      'card_color': cardColor,
      'primery_color': primaryColor, // Correct typo if needed
      'password': password,
      'maincategory': mainCategory,
      'subcategory': subCategory.map((i) => i.toJson()).toList(),
      'social_media_account': socialMediaAccounts,
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
