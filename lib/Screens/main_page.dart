import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Application/BottomNavBloc/bottom_nav_bloc.dart';
import 'Playlist/playlist.dart';
import 'Settings page/settings.dart';
import 'home_screen.dart';
import 'library.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    
    final screens = [
       ScreenHome(),
      const ScreenLibrary(),
      const ScreenPlaylist(),
      const ScreenSettings(),
    ];
    return BlocBuilder<BottomNavBloc, BottomNavState>(
      builder: (context, state) {
        return Scaffold(
          body: IndexedStack(
            index: state.index,
            children: screens,
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: state.index,
            onTap: (index) {
               BlocProvider.of<BottomNavBloc>(context).add(IndexChanger(index: index));
            },
            unselectedItemColor: Colors.white,
            unselectedIconTheme: const IconThemeData(color: Colors.white),
            backgroundColor: const Color.fromARGB(255, 0, 0, 0),
            type: BottomNavigationBarType.fixed,
            fixedColor: Colors.cyan,
            // ignore: prefer_const_literals_to_create_immutables
            items: [
              const BottomNavigationBarItem(
                icon: Icon(Icons.other_houses_outlined),
                label: 'Home',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.auto_awesome_motion_rounded),
                label: 'Library',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.playlist_play_sharp),
                label: 'playlist' ,
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.settings_outlined),
                label: 'Settings',
              ),
            ],
          ),
        );
      },
    );
  }
}
