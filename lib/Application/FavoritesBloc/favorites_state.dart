part of 'favorites_bloc.dart';

@freezed
class FavoritesState with _$FavoritesState {
  const factory FavoritesState({
    required List<Favsongs> favsongs,
    required List<Songs> dbSongs,
  }) = Initial;
   factory FavoritesState.initial() {
    return FavoritesState(favsongs: favdb.values.toList(), dbSongs: box.values.toList());
  }
}