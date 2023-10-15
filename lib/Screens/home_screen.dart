import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:dude_music_/Application/FavoritesBloc/favorites_bloc.dart';
import 'package:dude_music_/Application/HomeScreenBloc/homescreen_bloc_bloc.dart';
import 'package:dude_music_/Application/RecentlyPlayed/recently_played_bloc.dart';
import 'package:dude_music_/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../Widgets/search.dart';
import '../db/model/dbfunctions.dart';
import '../db/model/model.dart';
import 'Playlist/add_to_playlist.dart';
import 'main_player.dart';
import 'splash_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenHome extends StatelessWidget {
   ScreenHome({super.key});

  List<Songs> songs = box.values.toList();

  final AssetsAudioPlayer audioPlayer = AssetsAudioPlayer.withId('0');

  @override
 

  final _audioQuery = OnAudioQuery();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent
            //color set to transperent or set your own color
            ));
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            topSearch(context),
            allSongs(),
            BlocBuilder<HomescreenBlocBloc, HomescreenBlocState>(
              builder: (context, state) {
                return Visibility(visible: state.playerVisibility, child: miniPlayer(width,context));
              },
            )
          ],
        ),
      ),
    );
  }

  void addSongsToPlayer({required List<Songs> songs}){
    allSong.clear();
    for (var item in songs) { 
      allSong.add(
        Audio.file(
          item.songurl,
          metas: Metas(
            artist: item.artist,
            title: item.songname,
            id: item.id.toString(),
          ),
        ),
      );
    }
  }

  Expanded allSongs() {
    return Expanded(
      flex: 1,
      child: BlocBuilder<HomescreenBlocBloc, HomescreenBlocState>(
            builder: (context, state) {
              addSongsToPlayer(songs: state.dbSongs);
              if (state.dbSongs.isEmpty) {
                return const Center(
                  child: Text('No songs found',style: songnametext,)
                );
              }
              return ListView.builder(
                itemBuilder: ((context, index) {
                  Songs songs = state.dbSongs[index];
                  return ListTile(
                    onTap: () {
                      songCount(songs, index);
                      BlocProvider.of<HomescreenBlocBloc>(context)
                          .add(const PlayerVisble());
                      audioPlayer.open(
                        Playlist(audios: allSong, startIndex: index),
                        loopMode: LoopMode.playlist,
                        showNotification: true,
                      );
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const Mainplayer()));

                      RecentSongs Recents = RecentSongs(
                          songname: songs.songname,
                          artist: songs.artist,
                          duration: songs.duration.toString(),
                          songurl: songs.songurl,
                          id: songs.id.toString());
                      recentlyPlayedUupdation(Recents);
                      BlocProvider.of<RecentlyPlayedBloc>(context).add(const Recently());
                    },
                    trailing: IconButton(
                        onPressed: () {
                          showModalBottomSheet(
                              backgroundColor: Colors.black,
                              context: context,
                              builder: (context) {
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ListTile(
                                      leading: const Icon(
                                        Icons.favorite,
                                        color: Colors.red,
                                      ),
                                      title: const Text(
                                        'Add to favorites',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      onTap: () {
                                        List<Favsongs> favor =
                                            favdb.values.toList();
                                        if (favor
                                            .where((e) =>
                                                e.songname ==
                                                songs.songname)
                                            .isEmpty) {
                                          favdb.add(
                                            Favsongs(
                                              artist: songs.artist,
                                              duration: songs
                                                  .duration
                                                  .toString(),
                                              songname: songs.songname,
                                              songurl: songs.songurl,
                                              id: songs.id.toString(),
                                              //index: widget.index,
                                            ),
                                          );
                                          BlocProvider.of<FavoritesBloc>(context).add(const Started());
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content: Text(
                                                      '${songs.songname} Added To Favorites')));
                                        }
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    '${songs.songname} Is already Added To Favorites')));

                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    ListTile(
                                      leading: const Icon(
                                        Icons.playlist_add,
                                        color: Colors.lightBlue,
                                      ),
                                      title: const Text(
                                        'Add to playlist',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      onTap: () {
                                        playlistBottomSheet(context, index);
                                        
                                      },
                                    ),
                                  ],
                                );
                              });
                        },
                        icon: const Icon(
                          Icons.more_vert_outlined,
                          color: Colors.white,
                        )),
                    leading: QueryArtworkWidget(
                      artworkHeight: 90,
                      artworkWidth: 60,
                      artworkBorder: BorderRadius.circular(15),
                      id: songs.id,
                      type: ArtworkType.AUDIO,
                      nullArtworkWidget: Container(
                        width: 60,
                        height: 90,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.asset(
                            "assets/IMAGES/small logo.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    textColor: Colors.white,
                    title: Text(
                      songs.songname,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(
                      songs.artist,
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                }),
                itemCount: songs.length,
              );
            },

          ),
        
      
    );
  }

   miniPlayer(double width,BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const Mainplayer()));
      },
      child: Container(
        height: 82,
        decoration: BoxDecoration(
          boxShadow: [
            const BoxShadow(
              color: Color.fromARGB(255, 91, 87, 2),
              blurRadius: 1.0, // soften the shadow
              spreadRadius: 1.0, //extend the shadow
              offset: Offset(
                1.0, // Move to right 10  horizontally
                1.0, // Move to bottom 10 Vertically
              ),
            ),
            const BoxShadow(
              color: Color.fromARGB(255, 82, 31, 93),
              blurRadius: 1.0, // soften the shadow
              spreadRadius: 1.0, //extend the shadow
              offset: Offset(
                -1.0, // Move to right 10  horizontally
                -1.0, // Move to bottom 10 Vertically
              ),
            )
          ],
          borderRadius: BorderRadius.circular(20),
          color: const Color.fromARGB(243, 15, 15, 15),
        ),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            audioPlayer.builderCurrent(builder: (context, playing) {
              return Row(
                children: [
                  Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    child: QueryArtworkWidget(
                      // artworkHeight: 50,
                      // artworkWidth: 50,
                      artworkBorder: BorderRadius.circular(15),
                      id: int.parse(playing.audio.audio.metas.id!),
                      type: ArtworkType.AUDIO,
                      nullArtworkWidget: Image.asset(
                        'assets/IMAGES/DJ.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                          width: width - 130,
                          child: Text(
                            audioPlayer.getCurrentAudioTitle.toString(),
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                          )),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.skip_previous_sharp),
                            color: Colors.white,
                            onPressed: () {
                              audioPlayer.previous();
                            },
                            padding: EdgeInsets.zero,
                            splashRadius: 18,
                          ),
                          PlayerBuilder.isPlaying(
                              player: audioPlayer,
                              builder: (context, isPlaying) {
                                return IconButton(
                                  icon: Icon(isPlaying
                                      ? Icons.pause
                                      : Icons.play_arrow),
                                  color: Colors.blue,
                                  onPressed: () {
                                    audioPlayer.playOrPause();
                                  },
                                  padding: EdgeInsets.zero,
                                  splashRadius: 18,
                                );
                              }),
                          IconButton(
                            icon: const Icon(Icons.skip_next_sharp),
                            color: Colors.white,
                            onPressed: () {
                              audioPlayer.next();
                              
                            },
                            padding: EdgeInsets.zero,
                            splashRadius: 18,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}

List<Audio> allSong = [];
bool isVisible = false;

Row topSearch(context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Image.asset("assets/IMAGES/Dude Music.png"),
      IconButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => const Search()));
        },
        icon: const Icon(
          Icons.search,
          color: Colors.white,
          size: 32,
        ),
      ),
    ],
  );
}
