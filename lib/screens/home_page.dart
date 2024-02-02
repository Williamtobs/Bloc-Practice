import 'package:bloc_practice/screens/note_page.dart';
import 'package:flutter/material.dart';

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 20),
            EachTile(
              title: 'First Tile',
              delete: () {},
              edit: () {},
            ),
            const SizedBox(height: 20),
            EachTile(
              title: 'Second Tile',
              delete: () {},
              edit: () {},
            ),
            const SizedBox(height: 20),
            EachTile(
              title: 'Third Tile',
              delete: () {},
              edit: () {},
            ),
          ],
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
