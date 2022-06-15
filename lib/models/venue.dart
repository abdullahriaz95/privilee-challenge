import 'dart:convert';

/* 
  This is a model class for Venue.
 */

List<Venue> venueFromJson(String str) =>
    List<Venue>.from(json.decode(str).map((x) => Venue.fromJson(x)));

String venueToJson(List<Venue> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Venue {
  Venue({
    required this.type,
    required this.name,
    required this.shortName,
    required this.locationName,
    required this.emirate,
    required this.images,
  });

  String type;
  String name;
  String shortName;
  String locationName;
  String emirate;
  List<String> images;

  factory Venue.fromJson(Map<String, dynamic> json) => Venue(
        type: json["type"],
        name: json["name"],
        shortName: json["short_name"],
        locationName: json["location_name"],
        emirate: json["emirate"],
        images: List<String>.from(json["images"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "name": name,
        "short_name": shortName,
        "location_name": locationName,
        "emirate": emirate,
        "images": List<dynamic>.from(images.map((x) => x)),
      };
}
