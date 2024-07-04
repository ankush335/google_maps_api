///upadte model with your json data 
// To parse this JSON data, do
//
//     final google = googleFromJson(jsonString);

import 'dart:convert';

Google googleFromJson(String str) => Google.fromJson(json.decode(str));

String googleToJson(Google data) => json.encode(data.toJson());

class Google {
  List<Restaurant> restaurants;
  List<Event> event;

  Google({
    required this.restaurants,
    required this.event,
  });

  factory Google.fromJson(Map<String, dynamic> json) => Google(
    restaurants: List<Restaurant>.from(json["restaurants"].map((x) => Restaurant.fromJson(x))),
    event: List<Event>.from(json["event"].map((x) => Event.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
    "event": List<dynamic>.from(event.map((x) => x.toJson())),
  };
}

class Event {
  int id;
  String title;
  String image;
  String price;
  String latitude;
  String lognitude;
  DateTime endDate;
  DateTime startDate;

  Event({
    required this.id,
    required this.title,
    required this.image,
    required this.price,
    required this.latitude,
    required this.lognitude,
    required this.endDate,
    required this.startDate,
  });

  factory Event.fromJson(Map<String, dynamic> json) => Event(
    id: json["id"],
    title: json["title"],
    image: json["image"],
    price: json["price"],
    latitude: json["latitude"],
    lognitude: json["lognitude"],
    endDate: DateTime.parse(json["end_date"]),
    startDate: DateTime.parse(json["start_date"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "image": image,
    "price": price,
    "latitude": latitude,
    "lognitude": lognitude,
    "end_date": "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
    "start_date": "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
  };
}

class Restaurant {
  int id;
  String? restaurantName;
  List<Category> category;
  String? longitude;
  String? latitude;
  String? image2;
  double rating;
  int totalReviews;

  Restaurant({
    required this.id,
    required this.restaurantName,
    required this.category,
    required this.longitude,
    required this.latitude,
    required this.image2,
    required this.rating,
    required this.totalReviews,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
    id: json["id"],
    restaurantName: json["restaurant_name"],
    category: List<Category>.from(json["category"].map((x) => Category.fromJson(x))),
    longitude: json["longitude"],
    latitude: json["latitude"],
    image2: json["image2"],
    rating: json["rating"]?.toDouble(),
    totalReviews: json["total_reviews"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "restaurant_name": restaurantName,
    "category": List<dynamic>.from(category.map((x) => x.toJson())),
    "longitude": longitude,
    "latitude": latitude,
    "image2": image2,
    "rating": rating,
    "total_reviews": totalReviews,
  };
}

class Category {
  int id;
  Name name;
  CateImages cateImages;

  Category({
    required this.id,
    required this.name,
    required this.cateImages,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    name: nameValues.map[json["name"]]!,
    cateImages: cateImagesValues.map[json["cate_images"]]!,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": nameValues.reverse[name],
    "cate_images": cateImagesValues.reverse[cateImages],
  };
}

enum CateImages {
  MEDIA_CATEGORY_IMAGES_AMERICAN_FILTER_ICON_PNG,
  MEDIA_CATEGORY_IMAGES_ASIAN_FILTER_ICON_PNG,
  MEDIA_CATEGORY_IMAGES_INDIAN_FILTER_ICON_PNG,
  MEDIA_CATEGORY_IMAGES_ITALIAN_FILTER_ICON_PNG,
  MEDIA_CATEGORY_IMAGES_MEXICAN_B_RR_EK2_J_PNG,
  MEDIA_CATEGORY_IMAGES_THAI_X_D_SB8_IE_PNG
}

final cateImagesValues = EnumValues({
  "/media/category_images/American_Filter_Icon.png": CateImages.MEDIA_CATEGORY_IMAGES_AMERICAN_FILTER_ICON_PNG,
  "/media/category_images/Asian_Filter_Icon.png": CateImages.MEDIA_CATEGORY_IMAGES_ASIAN_FILTER_ICON_PNG,
  "/media/category_images/Indian_Filter_Icon.png": CateImages.MEDIA_CATEGORY_IMAGES_INDIAN_FILTER_ICON_PNG,
  "/media/category_images/Italian_Filter_Icon.png": CateImages.MEDIA_CATEGORY_IMAGES_ITALIAN_FILTER_ICON_PNG,
  "/media/category_images/Mexican_bRREk2J.png": CateImages.MEDIA_CATEGORY_IMAGES_MEXICAN_B_RR_EK2_J_PNG,
  "/media/category_images/Thai_xDSb8Ie.png": CateImages.MEDIA_CATEGORY_IMAGES_THAI_X_D_SB8_IE_PNG
});

enum Name {
  AMERICAN,
  ASIAN,
  INDIAN,
  ITALIAN,
  MEXICAN,
  THAI
}

final nameValues = EnumValues({
  "American": Name.AMERICAN,
  "Asian": Name.ASIAN,
  "Indian": Name.INDIAN,
  "Italian": Name.ITALIAN,
  "Mexican": Name.MEXICAN,
  "Thai": Name.THAI
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
