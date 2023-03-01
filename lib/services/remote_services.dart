import 'dart:convert';

import 'package:glubapp/models/aircrafts.dart';
import 'package:glubapp/models/aircraftsviewmodel.dart';
import 'package:glubapp/view/modifaircraft.dart';
import 'package:http/http.dart' as http;

class RemoteService {
  Future<List<Aircrafts>?> getAll() async {
    var client = http.Client();

    var uri = Uri.parse('http://www.glubappapi.somee.com/api/aircrafts');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return aircraftsFromJson(json);
    }
    return null;
  }

  Future<String> addAircraft(AircraftViewModel aircraft) async {
    var client = http.Client();

    final String result;
    final int auxType;
    aircraft.aircraftType == 'Avion' ? auxType = 1 : auxType = 0;
    var aircraf =
        Aircrafts(plate: aircraft.plate, aircraftType: auxType, isFlying: 0);

    var uri = Uri.parse('http://www.glubappapi.somee.com/api/aircrafts');
    var bodyRequest = jsonEncode(aircraf);
    var response = await client
        .post(uri,
            headers: {'Content-Type': 'application/json'}, body: bodyRequest)
        .then((value) => value.statusCode);
    if (response == 200) {
      result = 'Se agrego correctamente';
      return result;
    } else {
      result = 'Ocurrio un error a la hora de agregar o matricula repetida';
      return result;
    }
  }

  Future<String> putInFlight(String plate) async {
    var client = http.Client();
    var uri = Uri.parse('http://www.glubappapi.somee.com/api/aircrafts/$plate');
    final String result;
    var response = await client.put(
      uri,
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      result = 'Se actualizo correctamente';
      return result;
    } else {
      result = 'Ocurrio un error a la hora de poner en vuelo';
      return response.statusCode.toString();
    }
  }

  Future<String> modifAircraft(
      String oldPlateAir, String newPlate, String type) async {
    var client = http.Client();
    var uri = Uri.parse('http://www.glubappapi.somee.com/api/aircrafts');
    final String result;
    final int auxType;
    type == 'Avion' ? auxType = 1 : auxType = 0;
    var aircraf = Aircrafts(
        plate: newPlate,
        aircraftType: auxType,
        isFlying: 0,
        oldPlate: oldPlateAir);
    final bodyrequest = jsonEncode(aircraf);
    var response = await client.put(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: bodyrequest,
    );
    if (response.statusCode == 200) {
      result = 'Se modifico correctamente';
      return result;
    } else {
      result = 'Ocurrio un error a la hora de poner en vuelo';
      return response.statusCode.toString();
    }
  }
}
