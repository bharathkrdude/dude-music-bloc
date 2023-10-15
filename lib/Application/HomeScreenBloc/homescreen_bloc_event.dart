part of 'homescreen_bloc_bloc.dart';

@freezed
class HomescreenBlocEvent with _$HomescreenBlocEvent {
  const factory HomescreenBlocEvent.started() = _Started;
  const factory HomescreenBlocEvent.playerVisble() = PlayerVisble;
  const factory HomescreenBlocEvent.searchResult({required String query}) = Searchresult;
  const factory HomescreenBlocEvent.isShuffle() = IsShuffle;
  const factory HomescreenBlocEvent.isRepeat() = IsRepeat;
  
  
}