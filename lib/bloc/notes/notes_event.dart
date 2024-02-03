part of 'notes_bloc.dart';

sealed class NotesEvent extends Equatable {
  const NotesEvent();

  @override
  List<Object> get props => [];
}

class LoadNotes extends NotesEvent {
  final List<Notes> notes;

  const LoadNotes({this.notes = const <Notes>[]});

  @override
  List<Object> get props => [notes];
}

class AddNote extends NotesEvent {
  final Notes note;

  const AddNote({required this.note});

  @override
  List<Object> get props => [note];
}

class UpdateNote extends NotesEvent {
  final Notes note;

  const UpdateNote({required this.note});

  @override
  List<Object> get props => [note];
}

class DeleteNote extends NotesEvent {
  final Notes note;

  const DeleteNote({required this.note});

  @override
  List<Object> get props => [note];
}
