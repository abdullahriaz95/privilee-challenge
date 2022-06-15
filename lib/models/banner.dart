import 'dart:convert';

/* 
  This is a model class for Banner.
 */
List<Banner> bannerFromJson(String str) =>
    List<Banner>.from(json.decode(str).map((x) => Banner.fromJson(x)));

String bannerToJson(List<Banner> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Banner {
  Banner({
    required this.image,
    required this.type,
  });

  String image;
  String type;

  factory Banner.fromJson(Map<String, dynamic> json) => Banner(
        image: json["image"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "image": image,
        "type": type,
      };
}
