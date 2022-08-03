import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:practice/app/data/api_call.dart';
import 'package:practice/app/model/music_model.dart';

part 'api_event.dart';
part 'api_state.dart';

class ApiBloc extends Bloc<ApiEvent, ApiState> {
  ApiBloc() : super(ApiInitial()) {
    on<ApiEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<FetchApiEvent>((event, emit) async {
      emit(ApiLoadingState());
      final resp = await ApiCall().fetchTracks();

      resp.fold((left) => emit(ApiErrorState(error: left.error)),
          (right) => emit(ApiSuccessState(response: right)));
    });



  
  }
}
