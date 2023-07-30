import 'package:rest_api_beispiel/datamodels/post.dart';
import 'package:http/http.dart' as http;

class HttpService {
  // Funktion zum Umwandeln erhaltener Daten in eine List<Post>
  // das ? hinter List<Post>? <- sagt aus, dass der Rückgabewert auch "null" sein kann
  Future<List<Post>?> getPosts() async {
    var client = http.Client();

    // Umwandeln von String in url
    var url = Uri.parse("https://jsonplaceholder.typicode.com/posts");

    // Variable, in welcher die Antwort des Servers abgelegt werden kann
    var response = await client.get(url);

    // abfrage, ob rückmeldung vom server okay
    if (response.statusCode == 200) {
      // wenn status-code 200 (also "ok")
      // variable für den future-wert response
      var inhalt = response.body;

      // rückgabe des inhalts, formatiert aus json in eine List<Post>
      return postFromJson(inhalt);
    } else {
      // ansonsten: null als Rückgabe
      return null;
    }
  }
}
