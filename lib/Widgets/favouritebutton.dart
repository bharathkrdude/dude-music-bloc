
import 'package:dude_music_/Application/FavoritesBloc/favorites_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Screens/splash_screen.dart';
import '../db/model/dbfunctions.dart';
import '../db/model/model.dart';

class Favbutton extends StatelessWidget {
 Favbutton({super.key,required this.index});
  int index;

  @override
  Widget build(BuildContext context) {
    fav = favdb.values.toList();
    

    return Row(
      children:[
        fav.where((element) => element.id == songs[index].id.toString()).isEmpty 
        ? IconButton(onPressed: (){
          favdb.add(
                    Favsongs(
                      artist: songs[index].artist,
                      duration: songs[index].duration.toString(),
                      songname: songs[index].songname,
                      songurl: songs[index].songurl,
                      id: songs[index].id.toString(),
                      //index: widget.index,
                    ),
                  );
                   BlocProvider.of<FavoritesBloc>(context).add(const Started());
                  
                  print(favdb.values.toString());
        }, 
        icon: const Icon(Icons.favorite_outline,color: Colors.white,),
        )
        : IconButton(onPressed: () async{
           int currentIndex = fav.indexWhere((element) =>
                      element.id == songs[index].id.toString());
                  await favdb.deleteAt(currentIndex);
                  BlocProvider.of<FavoritesBloc>(context).add( Started());
        }, icon: const Icon(Icons.favorite_sharp,color: Colors.red,),)
      ]
      
    );
  }
}
List<Favsongs> fav = [];
List<Songs> songs = box.values.toList();