import 'package:flutter/material.dart';
import '../models/todo_model.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final List<Todo> _todos = [];
  final TextEditingController _textController = TextEditingController();

  // YENİ GÖREV EKLEME PENCERESİ
  void _showAddDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        title: const Text('YENİ GÖREV EKLE',
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.pink)),
        content: TextField(
          controller: _textController,
          autofocus: true,
          style: const TextStyle(fontSize: 30),
          decoration: const InputDecoration(
            hintText: 'Ne yapacaksın?',
            hintStyle: TextStyle(fontSize: 26),
          ),
        ),
        actions: [
          // EKLE BUTONU
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                if (_textController.text.isNotEmpty) {
                  setState(() => _todos.add(Todo(id: DateTime.now().toString(), title: _textController.text)));
                  _textController.clear();
                  Navigator.pop(context);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink,
                minimumSize: const Size(150, 70), // Buton boyutu
              ),
              child: const Text('EKLE', style: TextStyle(fontSize: 26, color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF0F5),
      appBar: AppBar(title: const Text('TODO APP')),

      // BOŞ EKRAN GÖRÜNTÜSÜ
      body: _todos.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.edit_note, size: 200, color: Colors.pink),
            const Text('LİSTE BOŞ!',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.pink)),
          ],
        ),
      )
      // LİSTE GÖRÜNÜMÜ
          : ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: _todos.length,
        itemBuilder: (context, index) {
          final todo = _todos[index];
          return Card(
            elevation: 5,
            margin: const EdgeInsets.only(bottom: 20),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: ListTile(
              contentPadding: const EdgeInsets.all(15),
              // DEV CHECKBOX
              leading: Transform.scale(
                scale: 2.5,
                child: Checkbox(
                  value: todo.isDone,
                  onChanged: (val) => setState(() => todo.isDone = val!),
                  activeColor: Colors.pink,
                ),
              ),
              title: Text(todo.title,
                  style: TextStyle(
                    fontSize: 30, // Liste elemanı yazısı dev yapıldı
                    fontWeight: FontWeight.bold,
                    decoration: todo.isDone ? TextDecoration.lineThrough : null,
                  )),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red, size: 45),
                onPressed: () => setState(() => _todos.removeAt(index)),
              ),
            ),
          );
        },
      ),

      // + BUTONU
      floatingActionButton: SizedBox(
        width: 100, // Genişlik artırıldı
        height: 100, // Yükseklik artırıldı
        child: FloatingActionButton(
          onPressed: _showAddDialog,
          backgroundColor: Colors.pink,
          elevation: 10,
          shape: const CircleBorder(),
          child: const Icon(Icons.add, size: 60, color: Colors.white),
        ),
      ),
    );
  }
}