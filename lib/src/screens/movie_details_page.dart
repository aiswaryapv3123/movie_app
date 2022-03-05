import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/src/models/get_movies_response.dart';
import 'package:movies_app/src/utils/constants.dart';
import 'package:movies_app/src/utils/utils.dart';
import 'package:intl/intl.dart';


class MovieDetailsPage extends StatefulWidget {
  final GetMovies movieData;
  const MovieDetailsPage({Key? key, required this.movieData}) : super(key: key);

  @override
  _MovieDetailsPageState createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
 String description = '';

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      description =Bidi.stripHtmlIfNeeded(widget.movieData.summary!);
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.colors[3],
      body:SingleChildScrollView(
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:[
            CachedNetworkImage(
              width: screenWidth(context, dividedBy: 1),
              height: screenHeight(context, dividedBy: 2),
              imageUrl: widget.movieData.image!.original ?? "https://image.shutterstock.com/image-vector/image-not-found-grayscale-photo-260nw-1737334631.jpg",
              fit: BoxFit.cover,
              imageBuilder: (context, img) {
                return Container(
                  width: screenWidth(context, dividedBy: 1),
                  height: screenHeight(context, dividedBy: 2),
                  decoration: BoxDecoration(
                    // color:Colors.yellow,
                    // borderRadius: const BorderRadius.all(
                    //   Radius.circular(4),
                    // ),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: img,
                    ),
                  ),
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
            Padding(
                padding:EdgeInsets.symmetric(horizontal: screenWidth(context, dividedBy:30),
                vertical: screenHeight(context, dividedBy:40)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.movieData.name!,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Constants.colors[0],
                    ),),
                  SizedBox(
                    height: screenHeight(context, dividedBy:50),
                  ),
                  Text(description.trimLeft(),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Constants.colors[0],
                    ),),

                  SizedBox(
                    height: screenHeight(context, dividedBy:50),
                  ),
                  Text("Rating : "+ widget.movieData.rating!.average!.toString(),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.blueGrey,
                    ),),
                  SizedBox(
                    height: screenHeight(context, dividedBy:150),
                  ),
                  Text("Genres : "+ widget.movieData.genres.toString(),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.blueGrey,
                    ),),
                ],
              ),
            )
          ]
        )
      )
    );
  }
}
