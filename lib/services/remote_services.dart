import 'dart:convert';

import 'package:glubapp/models/aircrafts.dart';
import 'package:glubapp/models/aircraftsviewmodel.dart';
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
      return response.toString();
    }
  }
}
