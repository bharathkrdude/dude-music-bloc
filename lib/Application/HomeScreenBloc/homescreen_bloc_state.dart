part of 'homescreen_bloc_bloc.dart';

@freezed

class HomescreenBlocState with _$HomescreenBlocState {
  
  const factory HomescreenBlocState({
    required List<Songs> dbSongs,
    required bool playerVisibility,
      required List<Songs> searchsongs,
      required String? value,
      required bool isShuffle,
      required bool isRepeat
  }) = Initial;
   factory HomescreenBlocState.initial(){
        return HomescreenBlocState(dbSongs: box.values.toList(), playerVisibility: false, searchsongs: box.values.toList(), value: null, isShuffle: false, isRepeat: false);
  } 
  
  
}
 List<Songs> searchSongs(String value) {
    
     return songsDisplay = allDbSongs
          .where((element) =>
              element.songname.toLowerCase().contains(value.toLowerCase()))
          .toList();
    
  }
