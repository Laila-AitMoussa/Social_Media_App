# Social Media App

Social Media App is a [Flutter](https://flutter.dev/) application for social networking. It allows users to create posts, like posts, comment on posts, follow/unfollow other users, delete their own posts, and more.

## Features

- **Authentication**: Users can sign up and log in to their accounts.
- **Create Posts**: Users can create new posts with images and descriptions.
- **Like Posts**: Users can like posts created by other users.
- **Comment on Posts**: Users can comment on posts created by other users.
- **Follow/Unfollow Users**: Users can follow or unfollow other users to see their posts in their feed.
- **Delete Posts**: Users can delete their own posts.
- **Profile Management**: Users can view their own profile and update their information.
- **Search Users**: Users can search for other users by their usernames.

## Screenshots

<p align="center">
 <img src="screenshots/welcomepage.png" width="200" height="400" />
 <img src="screenshots/login_page.png" width="200" height="400" />
 <img src="screenshots/signup_page.png" width="200" height="400" />
 <img src="screenshots/home_page.png" width="200" height="400" />
</p>
<p align="center">
  <img src="screenshots/add_post_page.png" width="200" height="400" />
  <img src="screenshots/search_page.png" width="200" height="400" />
  <img src="screenshots/profile_page.png" width="200" height="400" />
  <img src="screenshots/edit_page.png" width="200" height="400" />
</p>


## Installation

To run this application, you'll need:

- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- [Firebase account](https://firebase.google.com/) (for authentication and data storage)

For more details and a simple way to set up Firebase, see [FlutterFire](https://firebase.flutter.dev/docs/overview).

1. Clone this repository:

   ```bash
   git clone https://github.com/Laila-AitMoussa/Social_Media_App.git
   ```

2. Navigate to the project directory:

   ```bash
   cd Social_Media_App
   ```

3. Install dependencies:

   ```bash
   flutter pub get
   ```

4. Set up Firebase:

   - Create a new Firebase project.
   - Add an Android/iOS app to your Firebase project.
   - Follow the Firebase setup instructions and add the required configuration files to your Flutter app.

5. Run the app:

   ```bash
   flutter run
   ```
## Dependencies

- **cached_network_image**: A Flutter library to load and cache network images.
- **cloud_firestore**: Flutter plugin for Cloud Firestore, a cloud-hosted, NoSQL database with live synchronization and offline support.
- **firebase_auth**: Flutter plugin for Firebase Auth, which enables Flutter apps to use Firebase services like authentication, identity verification, and more.
- **firebase_core**: Flutter plugin for Firebase Core, which enables Flutter apps to use Firebase services such as Analytics, Authentication, and more.
- **firebase_storage**: Flutter plugin for Firebase Cloud Storage, a powerful, simple, and cost-effective object storage service built for Google scale.
- **gap**: A Flutter package to create space between widgets.
- **image_picker**: Flutter plugin for selecting images from the Android and iOS image library and taking new pictures with the camera.
- **image_stack**: A Flutter package to stack images and blend them into a single image with optional configurations.
- **intl**: Provides internationalization and localization support for Flutter applications.
- **provider**: State management library for Flutter applications, providing an elegant solution for managing application state.
- **transparent_image**: A Flutter package to load transparent images from the network.
- **uuid**: A simple package to generate RFC4122 UUIDs.

## Contributing

Contributions are welcome! Please feel free to open a pull request or submit an issue if you find any bugs or want to propose new features.
