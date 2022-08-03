class MusicModel {
  final num trackId;
  final String trackName;
  final String albumName;
  final String artistName;
  final num explicit;
  final num trackRating;

  MusicModel(
      {required this.trackId,
      required this.trackName,
      required this.albumName,
      required this.artistName,
      required this.explicit,
      required this.trackRating});

  factory MusicModel.fromJson(Map<String, dynamic> map) {
    return MusicModel(
        trackId: map["track_id"],
        trackName: map["track_name"],
        albumName: map["album_name"],
        artistName: map["artist_name"],
        explicit: map["explicit"],
        trackRating: map["track_rating"]);
  }

  static Map<String, dynamic> toMap(MusicModel model) {
    return {
      "track_id": model.trackId,
      "track_name": model.trackName,
      "album_name": model.albumName,
      "artist_name": model.artistName,
      "explicit": model.explicit,
      "track_rating": model.trackRating
    };
  }
}
