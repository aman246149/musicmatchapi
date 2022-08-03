part of 'api_bloc.dart';

@immutable
abstract class ApiEvent {}

class FetchApiEvent extends ApiEvent {}



class FetchLyricsUsingId extends ApiEvent {
  final num trackId;

  FetchLyricsUsingId({required this.trackId});
}
