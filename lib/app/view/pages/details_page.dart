import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice/app/view/bloc/bookmarks/bookmarks_bloc.dart';
import 'package:practice/app/view/bloc/lyricsBlocs/bloc/lyrics_bloc.dart';
import 'package:practice/app/view/bloc/tracksbloc/tracks_bloc.dart';
import 'package:practice/app/view/pages/book_marks.dart';

import '../bloc/apibloc/api_bloc.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({Key? key}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  var KtextStyle = TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Track Details"),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(child: BlocBuilder<TracksBloc, TracksState>(
              builder: (context, state) {
                if (state is TracksLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (state is TracksErrorState) {
                  return Center(
                    child: Text(state.error),
                  );
                }

                if (state is TracksTrackSuccessState) {
                  var resp = state.response[0];
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 18.0, left: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            resp.trackName,
                            style: KtextStyle,
                          ),
                          Text(resp.artistName, style: KtextStyle),
                          Text(resp.albumName, style: KtextStyle),
                          resp.explicit == 0
                              ? Text("False", style: KtextStyle)
                              : Text("True", style: KtextStyle),
                          Text(resp.trackRating.toString(), style: KtextStyle),
                          ElevatedButton(
                            onPressed: () {
                              BlocProvider.of<BookmarksBloc>(context)
                                  .add(AddFavourite(data: resp));
                            },
                            child: Text("Add BookMarks",
                                style: TextStyle(
                                  color: Colors.white,
                                )),
                            style:
                                ElevatedButton.styleFrom(primary: Colors.brown),
                          )
                        ],
                      ),
                    ),
                  );
                }
                return Container();
              },
            )),
            Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Lyrics",
                        style: KtextStyle,
                      ),
                      BlocBuilder<LyricsBloc, LyricsState>(
                        builder: (context, state) {
                          if (state is LyricsLoadingState) {
                            return const Center(
                              child: Text("Loading Lyrics"),
                            );
                          }

                          if (state is LyricsErrorState) {
                            return Center(
                              child: Text(state.error),
                            );
                          }

                          if (state is LyricsuccessState) {
                            return Expanded(
                              child: ListView(
                                children: [
                                  state.response.isEmpty
                                      ? Text("No Lyrics Available")
                                      : Text(state.response)
                                ],
                              ),
                            );
                          }
                          return Container();
                        },
                      )
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
