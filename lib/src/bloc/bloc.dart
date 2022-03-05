import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/src/api/exceptions.dart';
import 'package:movies_app/src/api/services.dart';
import 'package:movies_app/src/bloc/events.dart';
import 'package:movies_app/src/bloc/states.dart';
import 'package:movies_app/src/models/get_movies_response.dart';

class MovieBloc extends Bloc<MovieEvents, MovieStates> {
  final MovieRepo? movieRepo;
  List<GetMovies>? moviesList;

  MovieBloc({this.moviesList, this.movieRepo}) : super(MovieInitialState());
  @override
  Stream<MovieStates> mapEventsToState(MovieEvents event) async* {
    switch(event) {
      case MovieEvents.fetchMovies :
        yield MovieLoadingState();
        try {
          moviesList = await movieRepo!.getMovies();
          print("Fetched Movies List");
          print(moviesList);
          yield MovieLoadedState(
            moviesList: moviesList
          );
        } on SocketException {
          yield MovieErrorState(error: "No internet");
        } on HttpException {
          yield MovieErrorState(
            error:'No Service Found',
          );
        } on FormatException {
          yield MovieErrorState(
            error: 'Invalid Response format',
          );
        } catch (e) {
          yield MovieErrorState(
            error: 'Unknown Error',
          );
        }
        break;
    }
  }

}