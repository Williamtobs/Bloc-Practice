import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:bloc_practice/models/notes.dart';

part 'notes_event.dart';
part 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  NotesBloc() : super(NotesLoading()) {
    on<LoadNotes>((event, emit) {
      emit(NotesLoaded(notes: event.notes));
    });

    on<AddNote>((event, emit) {
      if (state is NotesLoaded) {
        final List<Notes> updatedNotes =
            List<Notes>.from((state as NotesLoaded).notes)..add(event.note);
        emit(NotesLoaded(notes: updatedNotes));
      }
    });

    on<UpdateNote>((event, emit) {
      if (state is NotesLoaded) {
        final List<Notes> updatedNotes =
            (state as NotesLoaded).notes.map((note) {
          return note.id == event.note.id ? event.note : note;
        }).toList();
        emit(NotesLoaded(notes: updatedNotes));
      }
    });

    on<DeleteNote>((event, emit) {
      if (state is NotesLoaded) {
        final List<Notes> updatedNotes =
            (state as NotesLoaded).notes.where((note) {
          return note.id != event.note.id;
        }).toList();
        emit(NotesLoaded(notes: updatedNotes));
      }
    });
  }
}
