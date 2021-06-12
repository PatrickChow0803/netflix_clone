import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';

class Api {
  static final APIKEY = dotenv.env['APIKEY'];
  static const uri = 'https://api.themoviedb.org/3/movie/';

  static Future<Response> get(String path) async {
    try {
      final request = Request('GET', Uri.parse('$uri/$path?api_key=$APIKEY'));

      final Response response = await Response.fromStream(
        await request.send().timeout(Duration(seconds: 30)),
      );

      return response;
    } catch (e) {
      throw e;
    }
  }
}
