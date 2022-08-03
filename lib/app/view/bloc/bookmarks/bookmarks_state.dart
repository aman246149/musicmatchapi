part of 'bookmarks_bloc.dart';

@immutable
abstract class BookmarksState {}

class BookmarksInitial extends BookmarksState {}


class FavouriteInitial extends BookmarksState {}

class FavouriteLoading extends BookmarksState {}

class FavouriteError extends BookmarksState {
  final String message;

  FavouriteError({required this.message});
}

class FavouriteSuccessState extends BookmarksState {
  final List<MusicModel> list;

  FavouriteSuccessState({required this.list});
}