import 'package:glubapp/models/aircrafts.dart';
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
  }
}
