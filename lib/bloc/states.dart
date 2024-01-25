part of 'cubit.dart';

class MoviesStates {}

class GetMoviesLoadingStates extends MoviesStates {}

class GetMoviesSuccessStates extends MoviesStates {
  final List<MovieModel> list;

  GetMoviesSuccessStates({required this.list});
}

class GetMoviesFailedStates extends MoviesStates {}

class GetMoviesFromPaginationLoadingStates extends MoviesStates {}

class GetMoviesFromPaginationFailedStates extends MoviesStates {}
