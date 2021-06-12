import 'package:http/http.dart';

class Api {
  static const uri = 'https://api.themoviedb.org/3/';

  static Future<Response> get(String path) async {
    try {
      final request = Request('GET', Uri.parse('$uri/$path'));

      final Response response = await Response.fromStream(
        await request.send().timeout(Duration(seconds: 30)),
      );

      return response;
    } catch (e) {
      throw e;
    }
  }
}
