import 'package:bloc_practice/bloc/notes/notes_bloc.dart';
import 'package:bloc_practice/models/notes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotePage extends StatefulWidget {
  final Notes? note;
  const NotePage({super.key, this.note});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    if (widget.note != null) {
      _titleController.text = widget.note!.title;
      _contentController.text = widget.note!.content;
    }

    String idGenerator() {
      final now = DateTime.now();
      return now.microsecondsSinceEpoch.toString();
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Note Page'),
      ),
      body: BlocListener<NotesBloc, NotesState>(
        listener: (context, state) {
          if (state is NotesLoaded) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Note added successfully'),
              ),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 20),
              TextField(
                controller: _titleController,
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: 'Note Title',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: TextField(
                  controller: _contentController,
                  maxLines: 99999,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                    hintText: 'Enter your note here...',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  if (widget.note != null) {
                    context.read<NotesBloc>().add(
                          UpdateNote(
                            note: widget.note!.copyWith(
                              title: _titleController.text,
                              content: _contentController.text,
                            ),
                          ),
                        );
                  } else {
                    if (_titleController.text.isNotEmpty &&
                        _contentController.text.isNotEmpty) {
                      context.read<NotesBloc>().add(
                            AddNote(
                              note: Notes(
                                id: idGenerator(),
                                title: _titleController.text,
                                content: _contentController.text,
                                date: DateTime.now().toString(),
                              ),
                            ),
                          );
                      Navigator.of(context).pop();
                    }
                  }
                },
                child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: Center(
                        child: Text(widget.note != null ? 'Update' : 'Save',
                            style: const TextStyle(fontSize: 20)))),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
