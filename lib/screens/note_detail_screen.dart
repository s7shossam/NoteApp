import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/note.dart';

class NoteDetailScreen extends StatefulWidget {
  final Note note;
  const NoteDetailScreen({super.key, required this.note});

  @override
  State<NoteDetailScreen> createState() => _NoteDetailScreenState();
}

class _NoteDetailScreenState extends State<NoteDetailScreen> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;

  @override
  void initState() {
    _titleController = TextEditingController(text: widget.note.title);
    _contentController = TextEditingController(text: widget.note.content);
    super.initState();
  }

  void _updateNote() async {
    widget.note.title = _titleController.text;
    widget.note.content = _contentController.text;
    widget.note.date = DateTime.now();
    await widget.note.save();
    Navigator.pop(context);
  }

  void _deleteNote() async {
    await widget.note.delete();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Note Detail'),
        actions: [
          IconButton(onPressed: _deleteNote, icon: const Icon(Icons.delete)),
        ],
      ),
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
              onPressed: _updateNote,
              child: const Text('Update'),
            )
          ],
        ),
      ),
    );
  }
}
