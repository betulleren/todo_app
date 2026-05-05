# 🌸 Pink Todo App (Flutter Sunum Demosu)

Bu proje, Flutter'ın temel yapıtaşlarını (State Yönetimi, Tema Kullanımı, Hazır Widget'lar) uygulamalı olarak göstermek amacıyla hazırlanmış basit, şık ve **sunum odaklı** bir Todo (Yapılacaklar Listesi) uygulamasıdır.

Sunum sırasında, projeksiyon veya dev ekranlarda en arka sıradan bile kodların ve uygulamanın net bir şekilde okunabilmesi için "Ultra Sunum Modu" baz alınarak UI elemanları (butonlar, yazılar, seçim kutuları) normalden çok daha büyük tasarlanmıştır.

##  Öne Çıkan Özellikler

*   **Tek Satırda Tema Yönetimi:** `ColorScheme.fromSeed(seedColor: Colors.pink)` kullanılarak tüm uygulamanın renk paleti tek merkezden pembe tonlarına ayarlanmıştır.
*  **Anlık Durum Güncelleme:** `setState` kullanılarak görev ekleme, silme ve tamamlama işlemlerinde ekranın anında tepki vermesi sağlanmıştır (StatefulWidget mantığı).
*  **Performanslı Listeleme:** `ListView.builder` sayesinde sadece ekranda görünen elemanlar çizilerek kaynak tüketimi minimize edilmiştir.
*  **Kaydırarak Silme (Swipe to Delete):** Flutter'ın yerleşik `Dismissible` widget'ı ile ekstra paket kullanmadan animasyonlu silme özelliği eklenmiştir.
*   **Boş Ekran Yönetimi:** Liste boş olduğunda kullanıcıyı beyaz bir ekranla baş başa bırakmak yerine görsel bir geribildirim (Empty State) sunulur.

## 📂 Proje Mimarisi (Clean Code)

Proje, kodun sürdürülebilirliğini artırmak için veri ve görünüm katmanlarına ayrılmıştır (Separation of Concerns):

```text
lib/
 ├── models/
 │   └── todo_model.dart       # Veri yapısı (Görevin ID, Başlık ve Durum bilgileri)
 ├── screens/
 │   └── todo_list_screen.dart # Arayüz ve UI mantığı
 └── main.dart                 # Uygulama giriş noktası ve tema ayarları
