part of 'tracks_bloc.dart';

@immutable
abstract class TracksEvent {}


class FetchTrackUsingId extends TracksEvent {
  final num trackId;

  FetchTrackUsingId({required this.trackId});
}