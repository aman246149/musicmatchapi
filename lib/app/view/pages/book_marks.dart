import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice/app/view/bloc/bookmarks/bookmarks_bloc.dart';
import 'package:practice/app/view/pages/details_page.dart';

import '../bloc/lyricsBlocs/bloc/lyrics_bloc.dart';
import '../bloc/tracksbloc/tracks_bloc.dart';

class BookMarks extends StatefulWidget {
  const BookMarks({Key? key}) : super(key: key);

  @override
  State<BookMarks> createState() => _BookMarksState();
}

class _BookMarksState extends State<BookMarks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Your Tracks")),
      body: SafeArea(
        child: BlocConsumer<BookmarksBloc, BookmarksState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            if (state is FavouriteError) {
              return Center(
                child: Text(state.message),
              );
            }

            if (state is FavouriteLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is FavouriteSuccessState) {
              print("favourite success state");
              return state.list.isEmpty
                  ? const Center(child: Text("add favourite first"))
                  : ListView.separated(
                      separatorBuilder: (context, index) => Divider(
                        height: 5,
                        thickness: 5,
                      ),
                      itemCount: state.list.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailScreen(),
                                ));
                            BlocProvider.of<TracksBloc>(context).add(
                                FetchTrackUsingId(
                                    trackId: state.list[index].trackId));
                            BlocProvider.of<LyricsBloc>(context).add(
                                FetchLyrics(
                                    trackId: state.list[index].trackId));
                          },
                          child: ListTile(
                            title: Text(state.list[index].trackName),
                            subtitle: Text(state.list[index].albumName),
                            trailing: Text(state.list[index].artistName),
                            leading: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "TrackId",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(state.list[index].trackId.toString()),
                              ],
                            ),
                          ),
                        );
                      },
                    );
            }

            return Container();
          },
        ),
      ),
    );
  }
}
