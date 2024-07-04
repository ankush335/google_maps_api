

import 'dart:convert';

Search searchFromJson(String str) => Search.fromJson(json.decode(str));

String searchToJson(Search data) => json.encode(data.toJson());

class Search {
  List<SearchDatum> searchData;

  Search({
    required this.searchData,
  });

  factory Search.fromJson(Map<String, dynamic> json) => Search(
    searchData: List<SearchDatum>.from(json["search_data"].map((x) => SearchDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "search_data": List<dynamic>.from(searchData.map((x) => x.toJson())),
  };
}

class SearchDatum {
  int id;
  String name;
  List<dynamic> image;
  List<Category> category;
  String? price;
  Type type;

  SearchDatum({
    required this.id,
    required this.name,
    required this.image,
    required this.category,
    required this.price,
    required this.type,
  });

  factory SearchDatum.fromJson(Map<String, dynamic> json) => SearchDatum(
    id: json["id"],
    name: json["name"],
    image: List<dynamic>.from(json["image"].map((x) => x)),
    category: List<Category>.from(json["category"].map((x) => Category.fromJson(x))),
    price: json["price"],
    type: typeValues.map[json["type"]]!,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": List<dynamic>.from(image.map((x) => x)),
    "category": List<dynamic>.from(category.map((x) => x.toJson())),
    "price": price,
    "type": typeValues.reverse[type],
  };
}

class Category {
  int id;
  String name;
  String cateImages;

  Category({
    required this.id,
    required this.name,
    required this.cateImages,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    name: json['name'] ,
    cateImages: json["cate_images"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "cate_images": cateImages,
  };
}

class ImageClass {
  String recipeImages;
  String? recipeImages2;

  ImageClass({
    required this.recipeImages,
    required this.recipeImages2,
  });

  factory ImageClass.fromJson(Map<String, dynamic> json) => ImageClass(
    recipeImages: json["recipe_images"],
    recipeImages2: json["recipe_images2"],
  );

  Map<String, dynamic> toJson() => {
    "recipe_images": recipeImages,
    "recipe_images2": recipeImages2,
  };
}

enum Type {
  EVENT,
  RECIPE,
  RESTAURANT
}

final typeValues = EnumValues({
  "event": Type.EVENT,
  "recipe": Type.RECIPE,
  "restaurant": Type.RESTAURANT
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
