import 'package:equatable/equatable.dart';
import 'package:movies_app/src/models/get_movies_response.dart';

class MovieStates extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class MovieInitialState extends MovieStates {}

class MovieLoadingState extends MovieStates {}

class MovieLoadedState extends MovieStates {
  List<GetMovies>? moviesList;
  MovieLoadedState({this.moviesList});
}

class MovieErrorState extends MovieStates {
  String? error;
  MovieErrorState({this.error});
}
