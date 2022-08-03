part of 'bookmarks_bloc.dart';

@immutable
abstract class BookmarksEvent {}


class AddFavourite extends BookmarksEvent {
  final MusicModel data;

  AddFavourite({required this.data});

}

class FetchFavourite extends BookmarksEvent{
  
}