import 'package:movies_app/src/models/get_movies_response.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

abstract class MovieRepo {
  Future<List<GetMovies>> getMovies();
}

class MovieServices implements MovieRepo {

  static const baseUrl = "api.tvmaze.com";
  static const String _GET_DATA = "/shows";

  @override
  Future<List<GetMovies>> getMovies() async {
    // TODO: implement getMovies
    // final response = await http.get(Uri.parse("http://api.tvmaze.com/shows"));
    // print("Movies data");
    // print(response);
    // List<GetMovies> moviesList = getMoviesFromJson(response.body);
    // print("Movies List");
    // print(moviesList);
    // return moviesList;

    Uri uri = Uri.https(baseUrl, _GET_DATA);
    Response response = await http.get(uri);
    List<GetMovies> moviesData = getMoviesFromJson(response.body);
    return moviesData;
  }
}

