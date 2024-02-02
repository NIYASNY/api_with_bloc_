class MoviesData {
  late final int page, totalPages, totalResults;
  late final List<MovieModel> list;

  MoviesData.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    list =
        List.from(json['results']).map((e) => MovieModel.fromJson(e)).toList();
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
  }
}

class MovieModel {
  late final bool adult;
  late final String image;
  late final int id;
  late final String title;
  late final String originalLanguage;
  late final String originalTitle;
  late final String overview;
  late final String posterPath;
  late final String mediaType;
  late final List<int> genreIds;
  late final double popularity;
  late final String releaseDate;
  late final bool video;
  late final double? voteAverage;
  late final int voteCount;

  MovieModel.fromJson(Map<String, dynamic> json) {
    adult = json['adult'];
    image = "https://image.tmdb.org/t/p/w500${json["backdrop_path"]}";
    id = json['id'];
    title = json['title'];
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    overview = json['overview'];
    posterPath = json['poster_path'].toString();
    mediaType = json['media_type'];
    genreIds = List.castFrom<dynamic, int>(json['genre_ids']);
    popularity = json['popularity'];
    releaseDate = json['release_date'];
    video = json['video'];
    voteAverage = double.parse(json["vote_average"].toString());
    voteCount = json['vote_count'];
  }
}
