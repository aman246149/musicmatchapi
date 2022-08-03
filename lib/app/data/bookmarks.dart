

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:practice/app/model/music_model.dart';

class FavouriteStorage {
  static Future<List<MusicModel>> addData(MusicModel data) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<MusicModel> favlist = [];
    List<String>? list = await sharedPreferences.getStringList("favourites");

    if (list != null) {
      if (list.isNotEmpty) {
        //map data
        var decodedlist = jsonDecode(list.toString());
        for (int i = 0; i < decodedlist[0].length; i++) {
          final MusicModel ldata = MusicModel.fromJson(decodedlist[0][i]);
          favlist.add(ldata);
        }
      }
    }

    favlist.add(data);

    //encoding the data
    List<Map<String, dynamic>> lmap = [];
    for (int i = 0; i < favlist.length; i++) {
      lmap.add(MusicModel.toMap(favlist[i]));
    }
    List<String> encodedList = [];
    final String encodedData = jsonEncode(lmap);
    encodedList.add(encodedData);
    await sharedPreferences.setStringList("favourites", encodedList);
    return favlist;
  }

  static Future<List<MusicModel>> getData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    List<MusicModel> favlist = [];
    List<String>? list = await sharedPreferences.getStringList("favourites");

    if (list == null) {
      return favlist;
    }

    if (list.isNotEmpty) {
      var decodedjson = jsonDecode(list.toString()); //map data
      for (int i = 0; i < decodedjson[0].length; i++) {
        final MusicModel ldata = MusicModel.fromJson(decodedjson[0][i]);
        favlist.add(ldata);
      }
    }

    return favlist;
  }
}