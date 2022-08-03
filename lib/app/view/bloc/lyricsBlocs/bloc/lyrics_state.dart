part of 'lyrics_bloc.dart';

@immutable
abstract class LyricsState {}

class LyricsInitial extends LyricsState {}

class LyricsLoadingState extends LyricsState {}

class LyricsErrorState extends LyricsState {
  final String error;

  LyricsErrorState({required this.error});
}

class LyricsuccessState extends LyricsState {
  final String response;

  LyricsuccessState({required this.response});
}
