import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/todo_model.dart';

// StatefulWidget ve setState() kullanımı
class TodoListScreen extends StatefulWidget {
  final bool isDarkMode;
  final Function(bool) onThemeChanged;

  const TodoListScreen({
    super.key,
    required this.isDarkMode,
    required this.onThemeChanged,
  });

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final List<Todo> _todos = [];
  final TextEditingController _textController = TextEditingController();
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  // Method Channel Tanımlaması
  // Native iletişim için MethodChannel (Batarya)
  static const platform = MethodChannel('samples.flutter.dev/battery');
  String _batteryLevel = 'Batarya: ?';

  Future<void> _getBatteryLevel() async {
    String batteryLevel;
    try {
      final int result = await platform.invokeMethod('getBatteryLevel');
      batteryLevel = 'Batarya: %$result';
    } on PlatformException catch (e) {
      batteryLevel = "Alınamadı: '${e.message}'.";
    }

    setState(() {
      _batteryLevel = batteryLevel;
    });

    // Batarya yazısını 3 saniye sonra gizle
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _batteryLevel = 'Batarya: ?';
        });
      }
    });
  }

  // Görev Ekleme/Silme, SnackBar ve AnimatedList
  void _addTodo(String title) {
    if (title.trim().isEmpty) return;
    final newTodo = Todo(id: DateTime.now().toString(), title: title.trim());
    _todos.insert(0, newTodo);
    _listKey.currentState
        ?.insertItem(0, duration: const Duration(milliseconds: 500));
    setState(() {});
  }

  void _removeTodo(int index) {
    final removedTodo = _todos.removeAt(index);
    _listKey.currentState?.removeItem(
      index,
      (context, animation) => _buildItem(removedTodo, animation, index, true),
      duration: const Duration(milliseconds: 400),
    );
    setState(() {});

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('"${removedTodo.title}" silindi!',
            style: const TextStyle(fontSize: 18)),
        backgroundColor: Colors.pink.shade400,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        margin: const EdgeInsets.all(20),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Widget _buildItem(
      Todo todo, Animation<double> animation, int index, bool isRemoving) {
    final curvedAnimation = CurvedAnimation(
      parent: animation,
      curve: Curves.easeOutBack,
    );

    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(1.0, 0.0),
        end: Offset.zero,
      ).animate(curvedAnimation),
      child: SizeTransition(
        sizeFactor: curvedAnimation,
        child: FadeTransition(
          opacity: animation,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              color: widget.isDarkMode ? Colors.grey[800] : Colors.white,
              borderRadius: BorderRadius.circular(25),
              border: Border.all(
                color: widget.isDarkMode
                    ? Colors.grey.shade700
                    : Colors.pink.shade50,
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: todo.isDone
                      ? Colors.grey.withOpacity(0.05)
                      : (widget.isDarkMode
                          ? Colors.black26
                          : Colors.pink.withOpacity(0.08)),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              leading: Transform.scale(
                scale: 1.8,
                child: Checkbox(
                  value: todo.isDone,
                  onChanged: isRemoving
                      ? null
                      : (val) => setState(() => todo.isDone = val!),
                  activeColor: Colors.pink,
                  shape: const CircleBorder(),
                  side: BorderSide(color: Colors.pink.shade200, width: 2),
                ),
              ),
              title: Text(
                todo.title,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w600,
                  color: todo.isDone
                      ? Colors.grey.shade500
                      : (widget.isDarkMode ? Colors.white : Colors.black87),
                  decoration: todo.isDone ? TextDecoration.lineThrough : null,
                  decorationColor: Colors.pink.shade300,
                  decorationThickness: 2,
                ),
              ),
              trailing: Container(
                decoration: BoxDecoration(
                  color: widget.isDarkMode
                      ? Colors.red.shade900.withOpacity(0.3)
                      : Colors.red.shade50,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: Icon(Icons.delete_outline,
                      color: widget.isDarkMode ? Colors.redAccent : Colors.red,
                      size: 32),
                  onPressed: isRemoving ? null : () => _removeTodo(index),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showAddDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: widget.isDarkMode ? Colors.grey[900] : Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        title: Text(
          'Yeni Görev Ekle',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.pink.shade300),
        ),
        content: TextField(
          controller: _textController,
          autofocus: true,
          style: TextStyle(
              fontSize: 24,
              color: widget.isDarkMode ? Colors.white : Colors.black87),
          decoration: InputDecoration(
            hintText: 'Ne yapacaksın?',
            hintStyle: TextStyle(fontSize: 22, color: Colors.grey.shade500),
            filled: true,
            fillColor:
                widget.isDarkMode ? Colors.grey[800] : Colors.pink.shade50,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none,
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          ),
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          ElevatedButton(
            onPressed: () {
              if (_textController.text.trim().isNotEmpty) {
                _addTodo(_textController.text);
                _textController.clear();
                Navigator.pop(context);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.pink,
              foregroundColor: Colors.white,
              elevation: 5,
              shadowColor: Colors.pink.withOpacity(0.5),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              minimumSize: const Size(160, 60),
            ),
            child: const Text('EKLE',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  // Arayüz oluşturma ve "Her şey widget'tır" mantığı
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        toolbarHeight: 90,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(left: 5, right: 15),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.battery_charging_full, size: 30),
                onPressed: _getBatteryLevel,
                tooltip: 'Batarya Oku (MethodChannel)',
              ),
              const Expanded(
                child: Center(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text('Yapılacaklar',
                        style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 28,
                            letterSpacing: 1.0)),
                  ),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(widget.isDarkMode ? Icons.dark_mode : Icons.light_mode,
                      size: 24),
                  const SizedBox(width: 5),
                  // 1. Özellik: Adaptive Switch
                  // Tema değişimi için Switch.adaptive
                  Switch.adaptive(
                    value: widget.isDarkMode,
                    onChanged: widget.onThemeChanged,
                    activeColor: Colors.white,
                    activeTrackColor: Colors.pink.shade200,
                  ),
                ],
              ),
            ],
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: widget.isDarkMode
                  ? [Colors.pink.shade900, Colors.pink.shade800]
                  : [Colors.pink.shade400, Colors.pink.shade300],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(35),
              bottomRight: Radius.circular(35),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.pink.withOpacity(0.4),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: widget.isDarkMode
                ? [const Color(0xFF121212), const Color(0xFF1E1E1E)]
                : [const Color(0xFFFFF0F5), Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            // Batarya Seviyesi Göstergesi
            if (_batteryLevel != 'Batarya: ?')
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.green, width: 2),
                  ),
                  child: Text(
                    _batteryLevel,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green),
                  ),
                ),
              ),
            Expanded(
              child: Stack(
                children: [
                  AnimatedOpacity(
                    opacity: _todos.isEmpty ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 400),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(40),
                            decoration: BoxDecoration(
                              color: widget.isDarkMode
                                  ? Colors.grey[800]
                                  : Colors.pink.shade50,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.pink.withOpacity(0.1),
                                  blurRadius: 20,
                                  spreadRadius: 10,
                                ),
                              ],
                            ),
                            child: Icon(Icons.fact_check_outlined,
                                size: 120, color: Colors.pink.shade300),
                          ),
                          const SizedBox(height: 30),
                          const Text(
                            'Harika! Tüm görevleri tamamladın 🎉',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Colors.pink),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Flutter Architecture & Cross-Platform Demo',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 16,
                                color: widget.isDarkMode
                                    ? Colors.grey.shade400
                                    : Colors.grey,
                                fontStyle: FontStyle.italic),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // AnimatedList
                  IgnorePointer(
                    ignoring: _todos.isEmpty,
                    child: AnimatedList(
                      key: _listKey,
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, top: 30, bottom: 120),
                      initialItemCount: _todos.length,
                      itemBuilder: (context, index, animation) {
                        return _buildItem(
                            _todos[index], animation, index, false);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.pink.withOpacity(0.4),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: SizedBox(
          width: 90,
          height: 90,
          child: FloatingActionButton(
            // Hot Reload demosu
            onPressed: _showAddDialog,
            backgroundColor: Colors.pink,
            elevation: 0,
            shape: const CircleBorder(),
            child: const Icon(Icons.add_rounded, size: 50, color: Colors.white),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
