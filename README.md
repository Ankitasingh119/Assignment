# flutter_assignment

# 📱 Flutter Product App

A Flutter application that fetches and displays products from a public API using `flutter_bloc`, following clean architecture with the **Repository Pattern**. It supports infinite scroll, sorting, favorites, grid/list toggle, and detailed product views.

## 🔗 Public API Used

https://dummyjson.com/products

## 🚀 Features

- Splash Screen  
- Product Home Screen  
- Grid/List View Toggle  
- Infinite Scroll Pagination  
- Product Detail Screen  
- Mark/Unmark Favorites  
- Favorites Screen  
- Sorting by Price, Rating, Name  
- Shimmer Loader while fetching  
- Error & Empty State Handling  
- Responsive UI (Mobile & Tablet)

## 📦 Setup Instructions

1️⃣ Clone the Repo  
```bash
git clone https://github.com/YOUR_USERNAME/flutter_product_app.git
cd flutter_product_app
flutter pub get
flutter run
lib/
├── app.dart                       # Root app setup
├── main.dart                      # Entry point
├── models/                        # Data models (Product)
├── repositories/                  # API logic (ProductRepository)
├── blocs/                         # BLoC logic for list and favorites
│   ├── product_list/
│   └── favorites/
├── screens/                       # splash, home, detail, favorites
├── widgets/                       # UI components (list/grid items, loader)
https://github.com/Ankitasingh119/Assignment

