part of 'playlists_bloc.dart';

@freezed
class PlaylistsEvent with _$PlaylistsEvent {
  const factory PlaylistsEvent.playlistsAdded() = PlaylistsAdded;

  const factory PlaylistsEvent.pauseVisible() = PauseVisible;

  const factory PlaylistsEvent.playVisible() = playVisible;

  const factory PlaylistsEvent.textFieldVisible() = TextFieldVisible;

  const factory PlaylistsEvent.textFieldNotVisible() = TextFieldNotVisible;

  const factory PlaylistsEvent.playButtonVisble() = PlayButtonVisble;
  
  const factory PlaylistsEvent.playButtonNotVisble() = PlayButtonNotVisble;
}