import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:practice/app/data/bookmarks.dart';
import 'package:practice/app/model/music_model.dart';

part 'bookmarks_event.dart';
part 'bookmarks_state.dart';

class BookmarksBloc extends Bloc<BookmarksEvent, BookmarksState> {
  BookmarksBloc() : super(BookmarksInitial()) {
    on<BookmarksEvent>((event, emit) {
      // TODO: implement event handler
    });

      on<AddFavourite>((event, emit) async {
      emit(FavouriteLoading()); 
      List<MusicModel> list = await FavouriteStorage.addData(event.data);
      emit(FavouriteSuccessState(list: list));
    });

    on<FetchFavourite>((event, emit) async {
      emit(FavouriteLoading());
      List<MusicModel> list = await FavouriteStorage.getData();
      emit(FavouriteSuccessState(list: list));
    });
  }
}
