part of 'mostly_played_bloc.dart';

@freezed
class MostlyPlayedEvent with _$MostlyPlayedEvent {
  const factory MostlyPlayedEvent.started() = _Started;
}