import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../data/api_call.dart';
import '../../../../model/music_model.dart';

part 'lyrics_event.dart';
part 'lyrics_state.dart';

class LyricsBloc extends Bloc<LyricsEvent, LyricsState> {
  LyricsBloc() : super(LyricsInitial()) {
    on<LyricsEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<FetchLyrics>((event, emit) async {
      emit(LyricsLoadingState());
      final resp = await ApiCall().fetchLyricsUsingId(event.trackId);

      resp.fold((left) => emit(LyricsErrorState(error: left.error)),
          (right) => emit(LyricsuccessState(response: right)));
    });
  }
}
