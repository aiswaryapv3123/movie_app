// To parse this JSON data, do
//
//     final getMovies = getMoviesFromJson(jsonString);

import 'dart:convert';

List<GetMovies> getMoviesFromJson(String str) => List<GetMovies>.from(json.decode(str).map((x) => GetMovies.fromJson(x)));

String getMoviesToJson(List<GetMovies> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetMovies {
  GetMovies({
    this.id,
    this.url,
    this.name,
    this.type,
    this.language,
    this.genres,
    this.rating,
    this.image,
    this.summary,
    this.updated,
  });

  final int? id;
  final String? url;
  final String? name;
  final String? type;
  final String? language;
  final List<String>? genres;
  final Rating? rating;
  final Image? image;
  final String? summary;
  final int? updated;

  factory GetMovies.fromJson(Map<String, dynamic> json) => GetMovies(
    id: json["id"] == null ? null : json["id"],
    url: json["url"] == null ? null : json["url"],
    name: json["name"] == null ? null : json["name"],
    type: json["type"] == null ? null : json["type"],
    language: json["language"] == null ? null : json["language"],
    genres: json["genres"] == null ? null : List<String>.from(json["genres"].map((x) => x)),
    rating: json["rating"] == null ? null : Rating.fromJson(json["rating"]),
    image: json["image"] == null ? null : Image.fromJson(json["image"]),
    summary: json["summary"] == null ? null : json["summary"],
    updated: json["updated"] == null ? null : json["updated"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "url": url == null ? null : url,
    "name": name == null ? null : name,
    "type": type == null ? null : type,
    "language": language == null ? null : language,
    "genres": genres == null ? null : List<dynamic>.from(genres!.map((x) => x)),
    "rating": rating == null ? null : rating!.toJson(),
    "image": image == null ? null : image!.toJson(),
    "summary": summary == null ? null : summary,
    "updated": updated == null ? null : updated,
  };
}

class Image {
  Image({
    this.medium,
    this.original,
  });

  final String? medium;
  final String? original;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
    medium: json["medium"] == null ? null : json["medium"],
    original: json["original"] == null ? null : json["original"],
  );

  Map<String, dynamic> toJson() => {
    "medium": medium == null ? null : medium,
    "original": original == null ? null : original,
  };
}

class Rating {
  Rating({
    this.average,
  });

  final double? average;

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
    average: json["average"] == null ? null : json["average"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "average": average == null ? null : average,
  };
}



// {
// "id": 32,
// "url": "https://www.tvmaze.com/shows/32/fargo",
// "name": "Fargo",
// "type": "Scripted",
// "language": "English",
// "genres": [
// "Drama",
// "Comedy",
// "Crime"
// ],
// "rating": {
// "average": 8.9
// },
// "image": {
// "medium": "https://static.tvmaze.com/uploads/images/medium_portrait/267/669639.jpg",
// "original": "https://static.tvmaze.com/uploads/images/original_untouched/267/669639.jpg"
// },
// "summary": "<p><b>Fargo </b>is a seasonal anthology crime drama with some dark comical elements, inspired by the film <i>Fargo</i> written by the Coen brothers. Each season follows a new case and new characters, all entrenched in the trademark humor, murder and \"Minnesota nice\" that has made the film an enduring classic.</p>",
// "updated": 1643098234
// }