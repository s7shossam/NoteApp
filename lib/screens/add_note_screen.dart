import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/note.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({super.key});

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  void _saveNote() async {
    final title = _titleController.text;
    final content = _contentController.text;
    if (title.isEmpty || content.isEmpty) return;

    final note = Note(
      id: DateTime.now().millisecondsSinceEpoch,
      title: title,
      content: content,
      date: DateTime.now(),
    );
    final box = Hive.box<Note>('notes');
    await box.add(note);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Note')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _contentController,
              decoration: const InputDecoration(labelText: 'Content'),
              maxLines: 6,
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: _saveNote,
              child: const Text('Save'),
            )
          ],
        ),
      ),
    );
  }
}
