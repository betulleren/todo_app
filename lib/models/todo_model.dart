class Todo {
  String id;      // Görevin benzersiz kimliği
  String title;   // Görevin metni (örn: "Sunuma hazırlan")
  bool isDone;    // Tamamlandı mı? (Varsayılan olarak false/hayır)

  Todo({
    required this.id,
    required this.title,
    this.isDone = false,
  });
}