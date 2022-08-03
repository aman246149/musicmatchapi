part of 'tracks_bloc.dart';

@immutable
abstract class TracksState {}

class TracksInitial extends TracksState {}

class TracksLoadingState extends TracksState {}

class TracksErrorState extends TracksState {
  final String error;

  TracksErrorState({required this.error});
}




class TracksTrackSuccessState extends TracksState {
  final List<MusicModel> response;

  TracksTrackSuccessState({required this.response});
}