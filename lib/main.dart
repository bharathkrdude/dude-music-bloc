import 'package:dude_music_/Application/BottomNavBloc/bottom_nav_bloc.dart';
import 'package:dude_music_/Application/FavoritesBloc/favorites_bloc.dart';
import 'package:dude_music_/Application/HomeScreenBloc/homescreen_bloc_bloc.dart';
import 'package:dude_music_/Application/PlaylistsBloc/playlists_bloc.dart';
import 'package:dude_music_/Application/RecentlyPlayed/recently_played_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/services.dart';
import 'Screens/splash_screen.dart';
import 'db/model/model.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(SongsAdapter());
  await Hive.openBox<Songs>('Songs');

  Hive.registerAdapter(FavsongsAdapter());
  await Hive.openBox<Favsongs>('favsongs');

  Hive.registerAdapter(RecentSongsAdapter());
  await Hive.openBox<RecentSongs>('recentsongs');

  Hive.registerAdapter(PlaylistsAdapter());
  await Hive.openBox<Playlists>('playlists');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent
            //color set to transperent or set your own color
            ));
    return MultiBlocProvider(
     providers: [
       BlocProvider(create: (context) => HomescreenBlocBloc()),
       BlocProvider(create: (context) => RecentlyPlayedBloc()),
       BlocProvider(create: (context) => FavoritesBloc()),
       BlocProvider(create: (context) => BottomNavBloc()),
       BlocProvider(create: (context) => PlaylistsBloc()),
     ],
      child: MaterialApp(
        title: 'Dude Music',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          iconTheme: const IconThemeData(color: Colors.white),
          textTheme: Theme.of(context).textTheme.apply(
                bodyColor: Colors.white,
              ),
          primarySwatch: Colors.blue,
        ),
        home: const ScreenSplash(),
      ),
    );
  }
}
