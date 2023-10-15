import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:dude_music_/Screens/Playlist/playlistdetails.dart';
import 'package:dude_music_/Screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';

import '../../Application/HomeScreenBloc/homescreen_bloc_bloc.dart';
import '../../Application/PlaylistsBloc/playlists_bloc.dart';
import '../../db/model/dbfunctions.dart';
import '../../db/model/model.dart';
import '../../style.dart';
import '../splash_screen.dart';
import 'add_more_songs_playlist.dart';


List<Songs> songs = [];
bool isPlaying = false;
class PlayPauseButton extends StatelessWidget {
  PlayPauseButton({super.key,required this.playlistname,required this.playlistindex,required this.allplaylistsongs});
  String playlistname;
  int playlistindex;
  List<Songs> allplaylistsongs = [];

  @override
  Widget build(BuildContext context) {
    return 
              BlocBuilder<PlaylistsBloc, PlaylistsState>(
                builder: (context, state) {
                   List<Playlists> playlistsong = state.playlistdb.toList();
                songs = playlistsong[playlistindex].playlistsonglist;
                   if (songs.isEmpty) {
                  return addsongbutton(context);
                }else if(isPlaying==false){
                  return playbutton(context);
                }else{
                  return pausebutton(context);
                }
                },
              );

  }

  Container addsongbutton(BuildContext context) {
  double width = MediaQuery.of(context).size.width;
  return Container(
    width: width * 0.28,
    decoration: BoxDecoration(
      color:Colors.white,
      borderRadius: BorderRadius.circular(50),
    ),
    child: Center(
      child: Row(
        children: [
          width10,
          TextButton(
            onPressed: () {
              playbuttonvisible = true;
              Navigator.of(context).push(MaterialPageRoute(builder: (context) =>AddSongs(index: playlistindex)));
              BlocProvider.of<PlaylistsBloc>(context).add(const PlaylistsAdded());
            },
            child: const Text('Add Songs', style: TextStyle(color: Colors.black,)),
          )
        ],
      ),
    ),
  );
}

Container playbutton(BuildContext context) {
  double width = MediaQuery.of(context).size.width;
  return Container(
    width: width * 0.25,
    decoration: BoxDecoration(
      color: Colors.pink,
      borderRadius: BorderRadius.circular(50),
    ),
    child: Row(
      children: [
        TextButton.icon(
          icon: const Icon(
            Icons.play_arrow_outlined,
            color: Colors.white,
          ),
          onPressed: () {
            audioPlayerplaylist.open(
              Playlist(audios: playlistsongs, startIndex:0),
              showNotification: true,
            );
            audioPlayerplaylist.playOrPause();
            BlocProvider.of<HomescreenBlocBloc>(context).add(const PlayerVisble());
            BlocProvider.of<PlaylistsBloc>(context).add(const PauseVisible());
            isPlaying = true;
            
          },
          label: const Text('Play', style: TextStyle(color: Colors.white)),
        )
      ],
    ),
  );
}

Container pausebutton(BuildContext context) {
  double width = MediaQuery.of(context).size.width;
  return Container(
    width: width * 0.3,
    decoration: BoxDecoration(
      color: Colors.pink,
      borderRadius: BorderRadius.circular(50),
    ),
    child: Row(
      children: [
        TextButton.icon(
          icon: const Icon(
            Icons.pause,
            color: Colors.white,
          ),
          onPressed: () {
           audioPlayerplaylist.playOrPause();
            BlocProvider.of<PlaylistsBloc>(context).add(const PauseVisible());
            isPlaying = false;      
            
          },
          label: const Text('Pause', style: TextStyle(color: Colors.white)),
        )
      ],
    ),
  );
}
}