import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../Screens/Playlist/play_pause_button.dart';
import '../../db/model/dbfunctions.dart';
import '../../db/model/model.dart';

part 'playlists_event.dart';
part 'playlists_state.dart';
part 'playlists_bloc.freezed.dart';

class PlaylistsBloc extends Bloc<PlaylistsEvent, PlaylistsState> {
  PlaylistsBloc() : super(PlaylistsState.initial()) {
    on<PlaylistsEvent>((event, emit) {
      emit(PlaylistsState(playlistdb: playlistsBox.values.toList(), playAndPauseVisiblilty:isPlaying , textformVisiblity: false, playbuttonVisible: false));
    });
     on<PauseVisible>((event, emit) {
      emit(state.copyWith(playAndPauseVisiblilty: true));
    });
    on<playVisible>((event, emit) {
      emit(state.copyWith(playAndPauseVisiblilty: false));
    });

    on<TextFieldVisible>((event, emit) {
      emit(state.copyWith(textformVisiblity: true));
    });

    on<TextFieldNotVisible>((event, emit) {
      emit(state.copyWith(textformVisiblity: false));
    });

    on<PlayButtonVisble>((event, emit) {
      emit(state.copyWith(playbuttonVisible: true));
    });

    on<PlayButtonNotVisble>((event, emit) {
      emit(state.copyWith(playbuttonVisible: false));
    });

  }
}
