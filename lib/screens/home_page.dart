import 'package:bloc_practice/bloc/notes/notes_bloc.dart';
import 'package:bloc_practice/screens/note_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Home Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: BlocBuilder<NotesBloc, NotesState>(
          builder: (context, state) {
            if (state is NotesLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is NotesLoaded) {
              return ListView.builder(
                itemCount: state.notes.length,
                itemBuilder: (context, index) {
                  return EachTile(
                    title: state.notes[index].title,
                    delete: () {
                      context.read<NotesBloc>().add(
                            DeleteNote(
                              note: state.notes[index],
                            ),
                          );
                    },
                    edit: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => NotePage(
                            note: state.notes[index],
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            } else {
              return Text('Something went wrong',
                  style: Theme.of(context).textTheme.headlineSmall);
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const NotePage(),
            ),
          );
        },
        // _incrementCounter,
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class EachTile extends StatelessWidget {
  final String title;
  final Function()? delete;
  final Function()? edit;
  const EachTile({super.key, required this.title, this.delete, this.edit});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title, style: Theme.of(context).textTheme.headlineSmall),
        const Spacer(),
        IconButton(
          onPressed: delete,
          icon: const Icon(Icons.delete, color: Colors.red),
        ),
        IconButton(
          onPressed: edit,
          icon: const Icon(Icons.edit, color: Colors.blue),
        ),
      ],
    );
  }
}
