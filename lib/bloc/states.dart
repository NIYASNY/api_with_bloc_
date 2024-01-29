part of 'cubit.dart';

class MoviesStates {}

class GetMoviesinitialStates extends MoviesStates {}

class GetMoviesLoadingStates extends MoviesStates {}

class GetMoviesSuccessStates extends MoviesStates {
  final List<MovieModel> list;

  GetMoviesSuccessStates({required this.list});
}

class GetMoviesFailedStates extends MoviesStates {
  final String msg;

  GetMoviesFailedStates({required this.msg});
}

class GetMoviesFromPaginationLoadingStates extends MoviesStates {}

class GetMoviesFromPaginationFailedStates extends MoviesStates {
  final String msg;

  GetMoviesFromPaginationFailedStates({required this.msg});
}
