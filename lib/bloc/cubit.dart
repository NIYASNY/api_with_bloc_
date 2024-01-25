import 'package:api_using_moviesecond_app/views/movies/model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'states.dart';

class MoviesCubit extends Cubit<MoviesStates> {
  MoviesCubit() : super(MoviesStates());

  final List<MovieModel> _list = [];

  void getData() async {
    emit(GetMoviesLoadingStates());
    try {
      var response = await Dio().get(
          'https://api.themoviedb.org/3/trending/movie/day?api_key=3c68dd7dff00ba8ba33d7f88d1c3ea39');
      var model = MoviesData.fromJson(response.data);
      _list.addAll(model.list);
      emit(GetMoviesSuccessStates(list: _list));
    } on DioException catch (ex) {
      emit(GetMoviesFailedStates());
    }
  }
}
