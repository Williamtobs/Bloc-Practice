part of 'notes_bloc.dart';

sealed class NotesState extends Equatable {
  const NotesState();

  @override
  List<Object> get props => [];
}

final class NotesLoading extends NotesState {}

final class NotesLoaded extends NotesState {
  final List<Notes> notes;

  const NotesLoaded({this.notes = const <Notes>[]});

  @override
  List<Object> get props => [notes];
}
