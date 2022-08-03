import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/api_call.dart';
import '../../../model/music_model.dart';

part 'tracks_event.dart';
part 'tracks_state.dart';

class TracksBloc extends Bloc<TracksEvent, TracksState> {
  TracksBloc() : super(TracksInitial()) {
    on<TracksEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<FetchTrackUsingId>((event, emit) async {
      emit(TracksLoadingState());
      final resp = await ApiCall().fetchTrackUsingId(event.trackId);

      resp.fold((left) => emit(TracksErrorState(error: left.error)),
          (right) => emit(TracksTrackSuccessState(response: right)));
    });
  }
}
