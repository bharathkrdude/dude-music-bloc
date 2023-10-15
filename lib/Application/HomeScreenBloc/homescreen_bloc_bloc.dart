import 'package:dude_music_/Widgets/search.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../Screens/splash_screen.dart';
import '../../db/model/model.dart';

part 'homescreen_bloc_event.dart';
part 'homescreen_bloc_state.dart';
part 'homescreen_bloc_bloc.freezed.dart';

class HomescreenBlocBloc extends Bloc<HomescreenBlocEvent, HomescreenBlocState> {
  HomescreenBlocBloc() : super(HomescreenBlocState.initial()) {
    on<PlayerVisble>((event, emit) {
      emit(state.copyWith(playerVisibility: true));
    }
    );
    on<Searchresult>((event, emit) {
      final result = searchSongs(event.query);
      emit(state.copyWith(searchsongs: result));
    });
    on<IsShuffle>((event, emit) {
      emit(state.copyWith(isShuffle: !state.isShuffle));
    });
    on<IsRepeat>((event, emit) {
      emit(state.copyWith(isRepeat: !state.isRepeat));
    });
  }
}
