import 'dart:convert';

List<Aircrafts> aircraftsFromJson(String str) =>
    List<Aircrafts>.from(json.decode(str).map((x) => Aircrafts.fromJson(x)));

String aircraftsToJson(List<Aircrafts> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Aircrafts {
  Aircrafts({
    this.id,
    required this.plate,
    required this.aircraftType,
    this.isFlying,
    this.auxIsFlying,
    this.latitude,
    this.longitude,
    this.oldPlate,
  });

  int? id;
  String? plate;
  int aircraftType;
  int? isFlying;
  bool? auxIsFlying;
  int? latitude;
  int? longitude;
  String? oldPlate;

  factory Aircrafts.fromJson(Map<String, dynamic> json) => Aircrafts(
      id: json["id"],
      plate: json["plate"],
      aircraftType: json["aircraftType"],
      auxIsFlying: json["isFlying"],
      latitude: json["latitude"],
      longitude: json["longitude"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "Newplate": plate,
        "aircraftType": aircraftType,
        "isFlying": isFlying,
        "latitude": latitude,
        "longitude": longitude,
        "Plate": oldPlate
      };
}
