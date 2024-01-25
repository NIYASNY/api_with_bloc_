import 'package:api_using_moviesecond_app/bloc/cubit.dart';
import 'package:api_using_moviesecond_app/views/movies/item.dart';
import 'package:api_using_moviesecond_app/views/movies/model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MoviesView extends StatelessWidget {
  const MoviesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MoviesCubit()..getData(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Movies'),
        ),
        body: BlocBuilder<MoviesCubit, MoviesStates>(
          builder: (context, state) {
            if (state is GetMoviesLoadingStates) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is GetMoviesFailedStates) {
              return Center(
                child: Text('Failed'),
              );
            } else if (state is GetMoviesSuccessStates) {
              return ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemBuilder: (context, index) =>
                      MovieItems(model: state.list[index]),
                  separatorBuilder: (context, index) => const SizedBox(
                        height: 16,
                      ),
                  itemCount: state.list.length);
            } else {
              return Text('Failed Text');
            }
          },
        ),
      ),
    );
  }
}
