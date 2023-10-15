part of 'recently_played_bloc.dart';

@freezed
class RecentlyPlayedState with _$RecentlyPlayedState {
  const factory RecentlyPlayedState({
    required List<RecentSongs> recentsdb,
    required List<Songs> dbSongs,
  }) = Initial;
   factory RecentlyPlayedState.initial(){
    return RecentlyPlayedState(recentsdb: recentdb.values.toList(), dbSongs: box.values.toList());
  }
}