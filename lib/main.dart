import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nepisireyim/views/home_page_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final prefs = await SharedPreferences.getInstance();
  final isFirstOpen = prefs.getBool('isFirstOpen') ?? true;

  runApp(NePisireyimApp(isFirstOpen: isFirstOpen));

  if (isFirstOpen) {
    await prefs.setBool('isFirstOpen', false);
  }
  initAnalytics();

}

Future<void> initAnalytics() async {
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  await analytics.logEvent(
    name: 'screen_view',
    parameters: {
      'firebase_screen': "menuPage",
      'firebase_screen_class': "menuClass",
    },
  );
}
class
NePisireyimApp extends StatelessWidget {
  bool isFirstOpen = false;
  NePisireyimApp({super.key,required this.isFirstOpen });


  @override
  Widget build(BuildContext context) {
    return  MaterialApp(home: MenuPageView(showDialogOnFirstOpen: isFirstOpen));
  }
}
