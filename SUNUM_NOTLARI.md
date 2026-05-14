# Flutter Todo App - Sunum Notları

Sunumunuzda jüriye (veya dinleyicilere) Flutter'ın gücünü ve mimarisini anlatmak için uygulamanızdaki şu **5 temel özelliği** öne çıkarmanızı şiddetle tavsiye ederim:

### 1. Platform Kanalları (MethodChannels) ile Native Batarya Seviyesi Okuma 🔋
* **Özellik:** Uygulamadaki batarya ikonuna basıldığında, cihazın gerçek batarya yüzdesinin (iOS'ta Swift, Android'de Kotlin üzerinden) okunup ekrana yazdırılması.
* **Sunumda Anlatılacaklar:**
  * **Flutter'ın Köprü (Bridge) Mimarisi:** React Native gibi framework'lerin aksine Flutter'ın JavaScript köprüsüne ihtiyaç duymadığını anlatın.
  * Flutter'ın `MethodChannel` yapısı sayesinde Swift (iOS) ve Kotlin (Android) kodlarıyla doğrudan ve asenkron (Future) olarak nasıl yüksek performanslı iletişim kurduğundan bahsedin. *(Örneğin: "iOS tarafında AppDelegate.swift dosyasında yazdığımız native kodu, Dart tarafından doğrudan tetikledik.")*

### 2. Akıcı Animasyonlar (AnimatedList & Transitions) 💫
* **Özellik:** Listeye yeni bir görev eklediğinizde veya sildiğinizde elemanların aniden belirmek yerine küçülerek/büyüyerek ve şeffaflığı değişerek (SizeTransition & FadeTransition) gelmesi/gitmesi.
* **Sunumda Anlatılacaklar:**
  * **Render Motoru:** Flutter'ın kendi render motoru (Skia/Impeller) olduğunu, cihazın OEM (yerel) arayüz bileşenlerini kullanmak yerine her pikseli kendisinin çizdiğini vurgulayın.
  * Bu sayede her iki platformda da 60fps (veya 120fps) pürüzsüz animasyonların donanım hızlandırmasıyla çok kolay bir şekilde elde edilebildiğini gösterin.

### 3. Uyarlanabilir Arayüz Bileşenleri (Adaptive Components) 🎛️
* **Özellik:** Sağ üstte temayı değiştirmeye yarayan butonun `Switch.adaptive` kullanılarak yapılmış olması.
* **Sunumda Anlatılacaklar:**
  * "Tek Kod Tabanı" mantığının sınırlarını gösterin. Uygulama iOS cihazda çalışırken switch butonu otomatik olarak bir **iOS (Cupertino)** butonu gibi görünür, Android'de çalışırken ise **Android (Material)** stiline bürünür.
  * Platform hissiyatını kaybetmeden cross-platform uygulama geliştirmenin ne kadar kolay olduğunu vurgulayın.

### 4. Anlık Tema Değişimi (Dark/Light Mode & State Management) 🌗
* **Özellik:** Switch butonuna tıklandığında uygulamanın renklerinin, gölgelerinin ve arka planının (gradient) anında Karanlık/Aydınlık moda geçmesi.
* **Sunumda Anlatılacaklar:**
  * **Deklaratif (Declarative) UI:** Flutter'ın reaktif yapısından bahsedin. Durum (State) değiştiğinde (`setState` tetiklendiğinde) Flutter'ın UI ağacını saniyeler içinde ne kadar hızlı ve verimli bir şekilde yeniden inşa ettiğini gösterin.
  * Özel tasarımların (Gradients, BoxShadows) her iki platformda da birebir aynı göründüğünü, "bir kere yaz her yerde aynı tasarıma sahip ol" prensibini kanıtladığını söyleyin.

### 5. Kullanıcı Etkileşimi ve Geri Bildirimler (SnackBars) 💬
* **Özellik:** Bir görev silindiğinde alt tarafta kayan ve özel tasarlanmış bir bildirim penceresinin (SnackBar) çıkması.
* **Sunumda Anlatılacaklar:**
  * Kullanıcı deneyiminin (UX) Flutter ile nasıl kolayca zenginleştirildiğinden bahsedin. Scaffold yapısının sunduğu hazır bileşenler sayesinde, uygulamaya modern bir hava katmanın sadece birkaç satır kod aldığını gösterebilirsiniz.

---

**💡 Sunum Taktiği:**
Sunum yaparken ekranı paylaşın; bir yandan görev ekleyip silerken animasyonların akıcılığına dikkat çekin, ardından batarya ikonuna basıp *"Şu an arka planda Swift/Kotlin kodunu tetikledim"* diyerek uygulamanın altındaki mühendislikten bahsedin. Bu, dinleyicileri ve jüriyi oldukça etkileyecektir!
