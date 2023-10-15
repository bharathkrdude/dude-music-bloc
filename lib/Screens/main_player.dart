import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:dude_music_/Application/HomeScreenBloc/homescreen_bloc_bloc.dart';
import 'package:dude_music_/Screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../Application/FavoritesBloc/favorites_bloc.dart';
import '../Widgets/favouritebutton.dart';
import 'Playlist/add_to_playlist.dart';
import 'home_screen.dart';

// bool isRepeat = false;

// bool isShuffle = false;

class Mainplayer extends StatelessWidget {
  const Mainplayer({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: audioPlayer.builderCurrent(builder: (context, playing) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                topSearch(context),
                const SizedBox(
                  height: 60,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: width - 100,
                      width: width - 100,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(40),
                          child: QueryArtworkWidget(
                            id: int.parse(playing.audio.audio.metas.id!),
                            type: ArtworkType.AUDIO,
                            nullArtworkWidget: ClipRRect(
                              child: Image.asset(
                                'assets/IMAGES/song logo.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          )),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  audioPlayer.getCurrentAudioTitle,
                  style: const TextStyle(fontSize: 22),
                  overflow: TextOverflow.clip,
                  maxLines: 1,
                  softWrap: false,
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        audioPlayer.getCurrentAudioArtist,
                        style:
                            const TextStyle(fontSize: 16, color: Colors.grey),
                        overflow: TextOverflow.clip,
                        maxLines: 1,
                        softWrap: false,
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              playlistBottomSheet(context, playing.index);
                            },
                            icon: const Icon(
                              Icons.playlist_add,
                              color: Colors.white,
                            )),
                        BlocBuilder<FavoritesBloc, FavoritesState>(
                          builder: (context, state) {
                            return Favbutton(
                                index: state.dbSongs.indexWhere((element) =>
                                    element.songname ==
                                    playing.audio.audio.metas.title));
                          },
                        ),
                      
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                audioPlayer.builderCurrentPosition(
                    builder: (context, currentPosition) {
                  return Column(
                    children: [
                      Slider(
                        activeColor: Colors.white,
                        inactiveColor: Colors.grey,
                        thumbColor: Colors.white,
                        value: currentPosition.inSeconds.toDouble(),
                        min: 0.0,
                        max: playing.audio.duration.inSeconds.toDouble(),
                        onChanged: (value) async {
                          final newDuration = Duration(seconds: value.toInt());
                          await audioPlayer.seek(newDuration);
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${currentPosition.toString().split(':')[1]}:${currentPosition.toString().split(':')[2].split('.')[0]}',
                              style: const TextStyle(color: Colors.grey),
                            ),
                            Text(
                              '${playing.audio.duration.toString().split(':')[1]}:${playing.audio.duration.toString().split(':')[2].split('.')[0]}',
                              style: const TextStyle(color: Colors.grey),
                            )
                          ],
                        ),
                      ),
                    ],
                  );
                }),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    BlocBuilder<HomescreenBlocBloc, HomescreenBlocState>(
                      builder: (context, state) {
                        return IconButton(
                          icon: state.isShuffle
                              ? const Icon(
                                  Icons.shuffle_rounded,
                                  color: Colors.blue,
                                )
                              : const Icon(Icons.shuffle_rounded),
                          color: Colors.white,
                          onPressed: () {
                            audioPlayer.toggleShuffle();

                            if (state.isShuffle == true) {
                              BlocProvider.of<HomescreenBlocBloc>(context)
                                  .add(const IsShuffle());
                            } else {
                              BlocProvider.of<HomescreenBlocBloc>(context)
                                  .add(const IsShuffle());
                            }
                          },
                          padding: EdgeInsets.zero,
                          splashRadius: 18,
                        );
                      },
                    ),
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
                            icon: Icon(
                                isPlaying ? Icons.pause : Icons.play_arrow),
                            color: Colors.blue,
                            onPressed: () {
                              audioPlayer.playOrPause();
                              // setState(() {
                              //   if (isPlaying == false){
                              //     isPlaying = true;
                              //   } else{
                              //     isPlaying = false;
                              //   }
                              // });
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
                    BlocBuilder<HomescreenBlocBloc, HomescreenBlocState>(
                      builder: (context, state) {
                        return IconButton(
                          icon: state.isRepeat == true
                              ? const Icon(
                                  Icons.repeat_one_rounded,
                                  color: Colors.blue,
                                )
                              : const Icon(Icons.repeat_outlined),
                          color: Colors.white,
                          onPressed: () {
                            
                              if (state.isRepeat == false) {
                                BlocProvider.of<HomescreenBlocBloc>(context).add(const IsRepeat());
                                audioPlayer.setLoopMode(LoopMode.single);
                              } else {
                                BlocProvider.of<HomescreenBlocBloc>(context).add(const IsRepeat());
                                audioPlayer.setLoopMode(LoopMode.none);
                              }
                            
                          },
                          padding: EdgeInsets.zero,
                          splashRadius: 18,
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                Center(
                    child: IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          // setState(() {});
                        },
                        icon: const Icon(
                          Icons.expand_more_sharp,
                          color: Colors.white,
                        ))),
              ],
            );
          }),
        ),
      ),
    );
  }
}
