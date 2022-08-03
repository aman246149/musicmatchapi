part of 'lyrics_bloc.dart';

@immutable
abstract class LyricsEvent {}


class FetchLyrics extends LyricsEvent {
  final num trackId;

  FetchLyrics({required this.trackId});
}