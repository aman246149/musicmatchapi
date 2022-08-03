import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice/app/view/bloc/bookmarks/bookmarks_bloc.dart';
import 'package:practice/app/view/bloc/lyricsBlocs/bloc/lyrics_bloc.dart';
import 'package:practice/app/view/pages/book_marks.dart';
import 'package:practice/app/view/pages/details_page.dart';

import '../bloc/apibloc/api_bloc.dart';
import '../bloc/tracksbloc/tracks_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Trending"),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                BlocProvider.of<BookmarksBloc>(context).add(FetchFavourite());
                Navigator.push(context, MaterialPageRoute(builder: (context) => BookMarks(),));
              },
              icon: const Icon(Icons.bookmark)),
        ),
        body: BlocConsumer<ApiBloc, ApiState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is ApiLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is ApiErrorState) {
              return Center(
                child: Text(state.error),
              );
            }

            if (state is ApiSuccessState) {
              return Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: ListView.separated(
                    separatorBuilder: (context, index) {
                      return const Divider(
                        height: 5,
                        thickness: 2,
                      );
                    },
                    itemCount: state.response.length,
                    itemBuilder: (context, index) {
                      var list = state.response[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const DetailScreen(),
                              ));

                          BlocProvider.of<TracksBloc>(context)
                              .add(FetchTrackUsingId(trackId: list.trackId));
                          BlocProvider.of<LyricsBloc>(context)
                              .add(FetchLyrics(trackId: list.trackId));
                        },
                        child: ListTile(
                          title: Text(list.trackName.toString()),
                          subtitle: Text(list.albumName),
                          leading: Icon(Icons.music_note),
                          trailing: Text(list.artistName.split(" ")[0]),
                        ),
                      );
                    }),
              );
            }
            return Container();
          },
        ));
  }
}
