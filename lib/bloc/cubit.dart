import 'package:api_using_moviesecond_app/views/movies/model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'states.dart';

class MoviesCubit extends Cubit<MoviesStates> {
  MoviesCubit() : super(MoviesStates());

  final List<MovieModel> _list = [];

  int pageNumber = 1;
  // int spageNumber = 1;

  void getData({bool fromLoading = false}) async {
    if (fromLoading) {
      emit(GetMoviesFromPaginationLoadingStates());
    } else {
      emit(GetMoviesLoadingStates());
    }
    try {
      var response = await Dio().get(
          'https://api.themoviedb.org/3/trending/movie/day?api_key=3c68dd7dff00ba8ba33d7f88d1c3ea39&page=$pageNumber');
      var model = MoviesData.fromJson(response.data);
      if (model.list.isNotEmpty) {
        pageNumber++;
        _list.addAll(model.list);
      }
      emit(GetMoviesSuccessStates(list: _list));
    } on DioException catch (ex) {
      if (fromLoading) {
        emit(GetMoviesFromPaginationFailedStates(
            msg: ex.response!.data["errors"]));
        await Future.delayed(Duration(seconds: 1));
        emit(GetMoviesinitialStates());
      } else {
        emit(GetMoviesFailedStates(msg: ex.toString()));
      }
      //   if (fromLoading) {
      //     emit(GetMoviesFromPaginationFailedStates(msg: ex.toString()));
      //   }
      //   emit(GetMoviesFailedStates(msg: ex.response!.data["errors"]));
      //   await Future.delayed(Duration(seconds: 1));
      //   emit(MoviesStates());
      // }
    }
  }
}
