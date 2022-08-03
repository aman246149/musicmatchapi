part of 'api_bloc.dart';

@immutable
abstract class ApiState {}

class ApiInitial extends ApiState {}

class ApiLoadingState extends ApiState {}

class ApiErrorState extends ApiState {
  final String error;

  ApiErrorState({required this.error});
}

class ApiSuccessState extends ApiState {
  final List<MusicModel> response;

  ApiSuccessState({required this.response});
}


// class ApiSucessLyricsState extends ApiState {
//   final String lyrics;

//   ApiSucessLyricsState({required this.lyrics});
// }
