import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../Screens/splash_screen.dart';
import '../../db/model/dbfunctions.dart';
import '../../db/model/model.dart';

part 'recently_played_event.dart';
part 'recently_played_state.dart';
part 'recently_played_bloc.freezed.dart';

class RecentlyPlayedBloc extends Bloc<RecentlyPlayedEvent, RecentlyPlayedState> {
  RecentlyPlayedBloc() : super(RecentlyPlayedState.initial()) {
    on<RecentlyPlayedEvent>((event, emit) {
      emit(RecentlyPlayedState(recentsdb: recentdb.values.toList(), dbSongs: box.values.toList()));
    });
  }
}
