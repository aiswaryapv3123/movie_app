import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/src/bloc/bloc.dart';
import 'package:movies_app/src/bloc/events.dart';
import 'package:movies_app/src/bloc/states.dart';
import 'package:movies_app/src/models/get_movies_response.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:movies_app/src/utils/constants.dart';
import 'package:movies_app/src/utils/utils.dart';
import 'package:movies_app/src/widgets/home_page_cards.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<GetMovies> actionMovies = [];
  List<GetMovies> comedyMovies = [];
  List<GetMovies> dramaMovies = [];
  List<GetMovies> adventureMovies = [];
  Future<List<GetMovies>>? futureMovies;
  List<String> categories = ["Action", "Drama", "Comedy", "Adventure"];
  List<List<GetMovies>> moviesByCategories = [];
  bool loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _loadData();
    futureMovies = getMovies();
  }
  // _loadData() async {
  //   context.read<MovieBloc>().add(MovieEvents.fetchMovies);
  // }

  static const baseUrl = "api.tvmaze.com";
  static const String _GET_DATA = "/shows";

  Future<List<GetMovies>> getMovies() async {
    // TODO: implement getMovies
    Uri uri = Uri.https(baseUrl, _GET_DATA);
    Response response = await http.get(uri);
    // print("Movies response");
    // print(response);
    List<GetMovies> moviesData = getMoviesFromJson(response.body);
    // print("Movies List");
    // print(moviesData);
    for (int i = 0; i < moviesData.length; i++) {
      if (moviesData[i].genres != null) {
        if (moviesData[i].genres!.contains("Drama")) {
          setState(() {
            dramaMovies.add(moviesData[i]);
          });
        } else if (moviesData[i].genres!.contains("Comedy")) {
          setState(() {
            comedyMovies.add(moviesData[i]);
          });
        } else if (moviesData[i].genres!.contains("Action")) {
          setState(() {
            actionMovies.add(moviesData[i]);
          });
        } else if (moviesData[i].genres!.contains("Adventure")) {
          setState(() {
            adventureMovies.add(moviesData[i]);
          });
        }
      }
    }
    setState(() {
      moviesByCategories.add(actionMovies);
      moviesByCategories.add(dramaMovies);
      moviesByCategories.add(comedyMovies);
      moviesByCategories.add(adventureMovies);
      loading = false;
    });
    return moviesData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.colors[3],
      appBar: AppBar(
          backgroundColor: Constants.colors[3],
          leading: Container(),
          title: Text(
            "Demo App",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Constants.colors[0],
            ),
          ),
          centerTitle: true),
      body: loading == true
          ? Container(
              width: screenWidth(context, dividedBy: 1),
              height: screenHeight(context, dividedBy: 1),
              child: Center(
                child: SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Constants.colors[0],
                    ),
                  ),
                ),
              ),
            )
          : SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // SizedBox(
                  //   height: screenHeight(context, dividedBy: 30),
                  // ),
                  /// futurebuilder
                  Container(
                    width: screenWidth(context, dividedBy: 1),
                    // height: screenHeight(context, dividedBy: 1),
                    // color: Colors.pink,
                    child: FutureBuilder<List<GetMovies>>(
                      future: futureMovies,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Container(
                            width: screenWidth(context, dividedBy: 1),
                            child: ListView.builder(
                              itemCount: categories.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (ctx, index) {
                                return Column(
                                  children: [
                                    SizedBox(
                                      height:
                                          screenHeight(context, dividedBy: 60),
                                    ),
                                    HomePageCard(
                                        movieList: moviesByCategories[index],
                                        category: categories[index]),
                                  ],
                                );
                              },
                            ),
                          );
                        } else if (snapshot.hasError) {
                          print(snapshot.error);
                          return Text("${snapshot.error}");
                        }
                        // To show a spinner while loading
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.8,
                          child: const Center(
                            child: SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.pink,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  // Container(
                  //   child: BlocBuilder<MovieBloc, MovieStates>(
                  //       builder: (BuildContext context, MovieStates state) {
                  //     if (state is MovieErrorState) {
                  //       final error = state.error;
                  //       return Container(
                  //         width: MediaQuery.of(context).size.width,
                  //         height: MediaQuery.of(context).size.height * 0.8,
                  //         child: Center(
                  //           child: Text(
                  //             error.toString(),
                  //             style: TextStyle(
                  //                 fontSize: 16,
                  //                 fontWeight: FontWeight.bold,
                  //                 fontFamily: "Exo-Regular"),
                  //           ),
                  //         ),
                  //       );
                  //     }
                  //     if (state is MovieLoadedState) {
                  //       print("Loaded State");
                  //       List<GetMovies> movies = state.moviesList!;
                  //       return Container(
                  //           width: MediaQuery.of(context).size.width,
                  //           height: MediaQuery.of(context).size.height * 0.8,
                  //           color:Colors.yellow,
                  //           child: Center(
                  //             child: Text(
                  //               movies[0].name!,
                  //               style: TextStyle(
                  //                   fontSize: 16,
                  //                   fontWeight: FontWeight.bold,
                  //                   fontFamily: "Exo-Regular"),
                  //             ),
                  //           ));
                  //     }
                  //     return Container(
                  //       width: MediaQuery.of(context).size.width,
                  //       height: MediaQuery.of(context).size.height * 0.8,
                  //       child: Center(
                  //         child: SizedBox(
                  //           width: 18,
                  //           height: 18,
                  //           child: CircularProgressIndicator(
                  //             strokeWidth: 2,
                  //             valueColor: AlwaysStoppedAnimation<Color>(
                  //               Colors.pink,
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     );
                  //   }),
                  // ),
                ],
              ),
            ),
    );
  }
}
