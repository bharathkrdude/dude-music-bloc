part of 'playlists_bloc.dart';

@freezed
class PlaylistsState with _$PlaylistsState {
  const factory PlaylistsState({
    required List<Playlists> playlistdb,
    required bool playAndPauseVisiblilty,
    required bool textformVisiblity,
    required bool playbuttonVisible
  }) = Initial;

  factory PlaylistsState.initial(){
    return PlaylistsState(playlistdb: playlistsBox.values.toList(), playAndPauseVisiblilty: isPlaying,textformVisiblity: false ,playbuttonVisible: false);
  }
}