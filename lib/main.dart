import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_app/color.dart';
import 'package:social_app/firebase_options.dart';
import 'package:social_app/layoutpage.dart';
import 'package:social_app/provider/user_provider.dart';
import 'package:social_app/welcomepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: MaterialApp(
        routes: {
          '/welcome': (context) => WelcomePage(),
        },
        theme: ThemeData(useMaterial3: true),
        debugShowCheckedModeBanner: false,
        home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator(
                color: pinkColor,
              );
            }

            if (snapshot.hasError) {
              // Handle error
              return Text('Error: ${snapshot.error}');
            }
            if (snapshot.data != null) {
              return LayoutPage();
            }
            return WelcomePage();
          },
        ),
      ),
    );
  }
}
