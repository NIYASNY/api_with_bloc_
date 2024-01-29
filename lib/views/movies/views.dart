import 'package:api_using_moviesecond_app/bloc/cubit.dart';
import 'package:api_using_moviesecond_app/views/movies/item.dart';
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
            backgroundColor: Colors.amber,
            title: const Text('Movies'),
          ),
          body: BlocBuilder<MoviesCubit, MoviesStates>(
            buildWhen: (previous, current) =>
                current is! GetMoviesFromPaginationLoadingStates && current is! GetMoviesFromPaginationFailedStates,
            builder: (context, state) {
              if (state is GetMoviesLoadingStates) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is GetMoviesFailedStates) {
                return Center(
                  child: Text(state.msg),
                );
              } else if (state is GetMoviesSuccessStates) {
                return NotificationListener<ScrollNotification>(
                  onNotification: (notification) {
                    if (notification.metrics.pixels ==
                            notification.metrics.maxScrollExtent &&
                        notification is ScrollUpdateNotification) {
                      print("Loading");
                      MoviesCubit cubit = BlocProvider.of(context);
                      cubit.getData(fromLoading: true);
                    }
                    return true;
                  },
                  child: ListView.separated(
                      padding: const EdgeInsets.all(16),
                      itemBuilder: (context, index) =>
                          MovieItems(model: state.list[index]),
                      separatorBuilder: (context, index) => const SizedBox(
                            height: 16,
                          ),
                      itemCount: state.list.length),
                );
              } else {
                return Text('Failed Text');
              }
            },
          ),
          bottomNavigationBar: SafeArea(
            child: SizedBox(
              height: 60,
              child: BlocBuilder<MoviesCubit, MoviesStates>(
                buildWhen: (previous, current) => current is GetMoviesFromPaginationLoadingStates || current is GetMoviesSuccessStates || current is GetMoviesFromPaginationFailedStates,
                builder: (context, state) {
                  if (state is GetMoviesFromPaginationLoadingStates) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is GetMoviesFromPaginationFailedStates) {
                    return Center(
                      child: Text(state.msg),
                    );
                  } else {
                    return SizedBox.shrink();
                  }
                },
              ),
            ),
          )),
    );
  }
}
