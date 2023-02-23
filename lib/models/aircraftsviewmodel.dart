import 'package:glubapp/models/aircrafts.dart';

class AircraftViewModel {
  AircraftViewModel(Aircrafts aircrafts) {
    id = aircrafts.id;
    plate = aircrafts.plate;
    aircrafts.aircraftType == 1
        ? aircraftType = 'Avion'
        : aircraftType = 'Planeador';
    aircrafts.auxIsFlying == false
        ? isFlying = 'En tierra'
        : isFlying = 'En vuelo';
  }

  late int? id;
  late String? plate;
  late String aircraftType;
  late String isFlying;
}
