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
    try {     var response = await Dio().get(
          'https://api.themoviedb.org/3/trending/movie/day?api_key=3c68dd7dff00ba8ba33d7f88d1c3ea39&page=$pageNumber');
      var model = MoviesData.fromJson(response.data);
      if (response.statusCode == 200) {
        pageNumber++;
        _list.addAll(model.list);
      }
      emit(GetMoviesSuccessStates(list: _list));
    } on DioError catch (ex) {
      if (fromLoading) {
        if (ex.response?.statusCode == 404) {
          emit(GetMoviesFromPaginationFailedStates(msg: 'Resource not found'));
        } else {
          emit(GetMoviesFromPaginationFailedStates(
              msg:
                  'Api call falied with statuscode ${ex.response?.statusCode}'));
        }
        await Future.delayed(Duration(seconds: 1));
        emit(GetMoviesinitialStates());
      } 
      // if (fromLoading) {
      //   emit(GetMoviesFromPaginationFailedStates(
      //       msg: ex.response!.data["errors"]));
      //   await Future.delayed(Duration(seconds: 1));
      //   emit(GetMoviesinitialStates());
      // } else {
      //   emit(GetMoviesFailedStates(msg: ex.toString()));
      // }
      // if (fromLoading) {
      //   if (ex.response?.statusCode == 404) {
      //     emit(GetMoviesFromPaginationFailedStates(msg: 'Resource not found'));
      //   } else if (ex.response?.statusCode == 401) {
      //     emit(GetMoviesFromPaginationFailedStates(msg: 'Invalid Api Key'));
      //   }
      // } else {
      //    emit(GetMoviesFailedStates(msg: ex.toString()));
      // }
    }
  }
}
