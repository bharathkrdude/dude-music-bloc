
import 'package:hive/hive.dart';

import '../../Screens/splash_screen.dart';
import 'model.dart';

late Box<Favsongs> favdb;
late Box<RecentSongs> recentdb;
late Box<Playlists> playlistsBox;

openfavbox() async{
  favdb = await Hive.openBox<Favsongs>('favsongs');
  // print(favdb.values.toString());
  // favdb.clear();
}
openrecentbox()async{
  recentdb =await Hive.openBox<RecentSongs>('recentsongs');
  // recentdb.clear();

}
 Future recentlyPlayedUupdation(RecentSongs value) async{
  print('${value.songname}HELLO');
  List<RecentSongs> list = recentdb.values.toList();
  if(list.where((element) => element.songname== value.songname).isEmpty){
recentdb.add(value);
  }
  else {
  int index = list.indexWhere((element) => element.songname== value.songname);
  recentdb.deleteAt(index);
  recentdb.add(value);
  }
}
songCount(Songs value,int index){
  int count = value.count;
  value.count = count + 1;
  box.putAt(index, value);
  print("${value.songname} played ${value.count} times");
}
openplaylistdb() async{
playlistsBox = await Hive.openBox<Playlists>('playlists');
}