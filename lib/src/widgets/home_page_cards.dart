import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/src/models/get_movies_response.dart';
import 'package:movies_app/src/screens/movie_details_page.dart';
import 'package:movies_app/src/utils/constants.dart';
import 'package:movies_app/src/utils/utils.dart';

class HomePageCard extends StatefulWidget {
  final String category;
  final List<GetMovies> movieList;
  const HomePageCard({Key? key, required this.movieList, required this.category}) : super(key: key);

  @override
  _HomePageCardState createState() => _HomePageCardState();
}

class _HomePageCardState extends State<HomePageCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:EdgeInsets.only(
              left: screenHeight(context, dividedBy: 90),
            ),
            child: Text(widget.category,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Constants.colors[0],
              ),),
          ),
          Container(
            width: screenWidth(context, dividedBy: 1),
            height: screenHeight(context, dividedBy: 4),
            // color:Colors.blue,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: widget.movieList.length,
              itemBuilder:(ctx, index) {
                return GestureDetector(
                  onTap:(){
                    push(context, MovieDetailsPage(movieData: widget.movieList[index]));
                  },
                  child: CachedNetworkImage(
                    width: screenWidth(context, dividedBy: 2.6),
                    height: screenHeight(context, dividedBy: 4),
                    imageUrl: widget.movieList[index].image!.original ?? "https://image.shutterstock.com/image-vector/image-not-found-grayscale-photo-260nw-1737334631.jpg",
                    fit: BoxFit.cover,
                    imageBuilder: (context, img) {
                      return Row(
                        children: [
                          Container(
                              width: screenWidth(context, dividedBy: 2.9),
                              height: screenHeight(context, dividedBy: 5),
                            margin: EdgeInsets.only(
                                right: screenHeight(context, dividedBy: 90),
                                left: screenHeight(context, dividedBy: 200),
                                ),
                              decoration: BoxDecoration(
                                // color:Colors.yellow,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(4),
                                ),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: img,
                                ),
                              ),
                          ),
                          // SizedBox(
                          //   width: screenWidth(context, dividedBy:40),
                          // ),
                        ],
                      );
                    },
                    placeholder: (context, img) => Center(
                      child: SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation(Constants.colors[0]),
                        ),
                      ),
                    ),
                    errorWidget: (_, s, d) => const Center(
                      child: Icon(
                        Icons.image_not_supported,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              }
            ),
          ),
        ],
      )
    );
  }
}

