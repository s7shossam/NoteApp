import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/note.dart';
import 'note_detail_screen.dart';
import 'add_note_screen.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Box<Note> noteBox = Hive.box<Note>('notes');
    return Scaffold(
      appBar: AppBar(title: const Text('My Notes')),
      body: ValueListenableBuilder(
        valueListenable: noteBox.listenable(),
        builder: (context, Box<Note> box, _) {
          if (box.isEmpty) {
            return const Center(child: Text('No notes yet.'));
          }
          final notes = box.values.toList().cast<Note>();
          notes.sort((a, b) => b.date.compareTo(a.date));
          return ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, index) {
              final note = notes[index];
              return ListTile(
                title: Text(note.title),
                subtitle: Text(DateFormat.yMMMd().format(note.date)),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => NoteDetailScreen(note: note),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const AddNoteScreen()),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
