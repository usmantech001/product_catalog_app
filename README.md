# product_catalog_app

# Overview
The Product Catalog App is a Flutter-based mobile application designed to allow users to manage and browse products locally. The app supports the following functionalities:

- Browse a list of products.
- View individual product details.
- Filter products by category and price range.
- Add, edit, and delete products.
- Offline data management with local storage using SQLite.
- The app is structured using the MVC (Model-View-Controller) architecture and utilizes GetX for state management, ensuring a clean separation of concerns and efficient state handling.

# Features
- Product Management: Add, edit, and delete products from the catalog.
- Filtering: Filter products by category and price range.
- Offline Support: Data is stored locally using SQLite, allowing the app to function offline.
- State Management: GetX is used for efficient state management, providing reactive and simple-to-use controllers.

# Setup Instructions
# Prerequisites
- Flutter SDK
- Android Studio or Visual Studio Code
- Dart SDK
- SQLite (Integrated with the app via the sqflite package)

# Steps to Set Up Locally
- Clone the Repository

git clone https://github.com/usmantech001/product_catalog_app.git
cd product_catalog_app

# Install Dependencies
flutter pub get

# Set Up the SQLite Database

SQLite is used for local storage in this app. The database schema is automatically created when the app is first run. No additional setup is required.

# Run the App

Connect a device or start an emulator, and then run the app with the following command:
 - flutter run

The app should build and run on the connected device or emulator.

# Additional Setup
 Image Picker: The app uses the image_picker package for selecting images. Make sure the necessary permissions are added to the Android AndroidManifest.xml and iOS Info.plist files.

# Design Decisions, Optimizations, and Trade-offs
MVC Architecture: The app is structured using MVC to ensure a clear separation of concerns. Models handle the data, views manage the UI, and controllers connect the two, handling business logic.

GetX for State Management: GetX was chosen for its simplicity and powerful features, including reactive programming, dependency injection, and easy navigation. It reduces boilerplate code and provides a more efficient way to manage state compared to other solutions like Provider or Bloc.

SQLite for Local Storage: Since the app is designed for offline usage without requiring authentication, SQLite was chosen for its reliability and simplicity in handling local data. This avoids the overhead of setting up a backend or using Firebase for such use cases.

No Authentication: The app does not include authentication as it's intended for local, offline use only. This simplifies the user experience but may limit the app's suitability for multi-user scenarios or data syncing across devices.

Image Management: Images are managed locally. While this simplifies the app and reduces the need for an external storage solution, it can lead to increased app size if many images are stored.

# State Management Solution
The app uses GetX for state management. GetX was selected for the following reasons:

Simplicity: GetX reduces the complexity of state management by offering an easy-to-use API that is intuitive for developers.

Reactive Programming: GetX enables reactive programming, where the UI automatically updates in response to changes in the application state, reducing the need for manual refreshes.

Dependency Injection: GetX provides built-in dependency injection, making it easier to manage dependencies across the app without relying on external packages or complex configurations.

Navigation: GetX offers a straightforward navigation system that integrates well with the state management, making it easier to handle complex navigation scenarios.

