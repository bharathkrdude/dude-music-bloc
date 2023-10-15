import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'mostly_played_event.dart';
part 'mostly_played_state.dart';
part 'mostly_played_bloc.freezed.dart';

class MostlyPlayedBloc extends Bloc<MostlyPlayedEvent, MostlyPlayedState> {
  MostlyPlayedBloc() : super(const _Initial()) {
    on<MostlyPlayedEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
