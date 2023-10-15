import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../Screens/splash_screen.dart';
import '../../db/model/dbfunctions.dart';
import '../../db/model/model.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';
part 'favorites_bloc.freezed.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  FavoritesBloc() : super(FavoritesState.initial()) {
    on<FavoritesEvent>((event, emit) {
      emit(FavoritesState(favsongs:favdb.values.toList(), dbSongs: box.values.toList()));
    });
  }
}
