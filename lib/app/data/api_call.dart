import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:practice/app/model/music_model.dart';
import 'package:practice/global/custom_error.dart';
import 'package:http/http.dart' as http;

class ApiCall {
  String APIKEY = "374e54337bac2696c81b44ef1a9304c1";
  Future<Either<CustomError, List<MusicModel>>> fetchTracks() async {
    List<MusicModel> list = [];
    String url =
        "https://api.musixmatch.com/ws/1.1/chart.tracks.get?apikey=$APIKEY&format=json&page=1&page_size=40&country=us&f_has_lyrics=1";
    try {
      final response = await http.get(Uri.parse(url));
      var decodedJson = jsonDecode(response.body);
      List responseList = decodedJson["message"]["body"]["track_list"];
      for (var i = 0; i < responseList.length; i++) {
        list.add(MusicModel.fromJson(responseList[i]["track"]));
      }
      return Right(list);
    } catch (e) {
      return Left(CustomError(error: e.toString()));
    }
  }

  Future<Either<CustomError, List<MusicModel>>> fetchTrackUsingId(
      num id) async {
    List<MusicModel> list = [];
    String url =
        "https://api.musixmatch.com/ws/1.1/track.get?track_id=$id&apikey=$APIKEY";
    try {
      final response = await http.get(Uri.parse(url));
      var decodedJson = jsonDecode(response.body);
      var responsedata = decodedJson["message"]["body"];

      list.add(MusicModel.fromJson(responsedata["track"]));

      return Right(list);
    } catch (e) {
      return Left(CustomError(error: e.toString()));
    }
  }

  Future<Either<CustomError, String>> fetchLyricsUsingId(num id) async {
    String url =
        "https://api.musixmatch.com/ws/1.1/track.lyrics.get?track_id=$id&apikey=$APIKEY";
    try {
      final response = await http.get(Uri.parse(url));
      var decodedJson = jsonDecode(response.body);
      var responsedata =
          decodedJson["message"]["body"]["lyrics"]["lyrics_body"];

      return Right(responsedata);
    } catch (e) {
      return Left(CustomError(error: e.toString()));
    }
  }
}
