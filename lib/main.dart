import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice/app/view/bloc/apibloc/api_bloc.dart';
import 'package:practice/app/view/bloc/bookmarks/bookmarks_bloc.dart';
import 'package:practice/app/view/bloc/lyricsBlocs/bloc/lyrics_bloc.dart';
import 'package:practice/app/view/bloc/tracksbloc/tracks_bloc.dart';
import 'package:practice/app/view/pages/homepage.dart';
import 'package:practice/app/view/pages/internet_checking_page.dart';

import 'app/view/bloc/InternetBloc/internet_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ApiBloc()..add(FetchApiEvent()),
        ),
        BlocProvider(create: (context) => TracksBloc()),
        BlocProvider(create: (context) => LyricsBloc()),
        BlocProvider(create: (context) => BookmarksBloc()),
        BlocProvider(
          create: (_) => ConnectedBloc(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          useMaterial3: true,
          primarySwatch: Colors.blue,
        ),
        home: InterNetCheckingPage(),
      ),
    );
  }
}
