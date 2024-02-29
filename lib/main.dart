import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'package:provider/provider.dart';
import 'package:quantum/provider/login_provider.dart';
import 'package:quantum/provider/signup_provider.dart';
import 'package:quantum/provider/task_provider.dart';
import 'package:quantum/screens/introduction_screen.dart';
import 'package:quantum/screens/task_screen.dart';
import 'package:quantum/services/local_notification.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Authentication/login_screen.dart';

import 'constants/colors.dart';

int? initScreen;
SharedPreferences? prefs;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  prefs = await SharedPreferences.getInstance();
  initScreen = (prefs?.getInt("initScreen"));
  prefs?.setInt("initScreen", 1);
  LocalNotificationService().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => SignUpProvider()),
        ChangeNotifierProvider(create: (_) => TaskProvider()),
      ],
      child: GetMaterialApp(
        title: 'ToDo app',
        theme: ThemeData(
            primarySwatch: Colors.blue,
            fontFamily: 'MyFont',
            useMaterial3: true,
            appBarTheme: const AppBarTheme(
                centerTitle: true, foregroundColor: kWhite, toolbarHeight: 70),
            scaffoldBackgroundColor: kBGColor),
        initialRoute: initScreen == 0 || initScreen == null ? "/" : "home",
        routes: {
          '/': (context) => const MyIntroductionScreen(),
          'home': (context) => FirebaseAuth.instance.currentUser == null
              ? const LoginScreen()
              : const TasksScreen()
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}