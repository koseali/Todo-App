# PatikaTodoApp
# Bootcamp Graduent Project

![Screens](https://github.com/koseali/PatikaTodoApp/blob/feature/Todo/PromotionFolder/promotion.png)
![Screens](https://github.com/koseali/PatikaTodoApp/blob/feature/Todo/PromotionFolder/splashScreen.gif)
![Screens](https://github.com/koseali/PatikaTodoApp/blob/feature/Todo/PromotionFolder/delete.gif)
![Screens](https://github.com/koseali/PatikaTodoApp/blob/feature/Todo/PromotionFolder/searchandSort.gif)

<!-- GETTING STARTED -->
## Getting Started

I developed this project for the IBTech Patika IOS Bootcamp


## Requirements
* [Xcode](https://developer.apple.com/xcode/)


## Description
1. Ekran: (Liste Ekranı:)
⁃ VIPER patterni ile yazılmalıdır.
⁃ Todo list itemları arasında arama yapılabilmelidir.
⁃ Todo list itemları sıralama butonu ile düzenlenme tarihine göre sıralanabilmelidir.
⁃ Sadece todo list itemları güncellendiğinde görünüm güncellenmelidir. (Ekrana her girişte güncelleme olmamalı)
2. ekran: (Detay Ekranı:)
⁃ MVVM patterni ile yazılmalıdır.
⁃ Todo için title, detail, tamamlama zamanı bilgileri girilecektir. ⁃ Edit ve Add işlemleri için aynı ekran kullanılacaktır.
Git Kullanımı:
- Uygulama github.com sayfasına public repo olarak yüklenmelidir.
 
⁃ Tamamlama zamanı ayarlanmış todo'nun zamanı geldiğinde uygulamada local push notification gösterilmelidir.
⁃ Notification yönetimi bir localNotificationManager aracılığıyla yapılmalıdır.
⁃ viewModel localNotificationManager’a notificationManager protokolü üzerinden
erişmelidir.
⁃ Todo title’ı eklenmemişse todo kaydedilmemelidir.
Her iki ekran için ortak olan özellikler:
⁃ İşlemler coreData ile yapılmalıdır.
⁃ coreData’ya bir coreDataManager üzerinden erişilmelidir.
⁃ Interactor ve viewModel coreDataManager’a dataManager protokolü üzerinden erişmelidir.
⁃ UI ve animasyon tamamen tercihe bağlı olup farklı cihaz görünümleri gözetilmelidir.


### Installation

2. Clone the repo
   ```sh
   git clone https://github.com/koseali/PatikaTodoApp.git
   ```



## Design Patterns
![VIPER](https://github.com/koseali/PatikaTodoApp/blob/feature/Todo/PromotionFolder/viper.png)
![MVVM](https://cdn-images-1.medium.com/max/1600/1*uhPpTHYzTmHGrAZy8hiM7w.png)
