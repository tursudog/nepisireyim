import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nepisireyim/views/home_page_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

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

  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);

  OneSignal.initialize("0cd53a58-1092-4646-8710-68090649741e");

// The promptForPushNotificationsWithUserResponse function will show the iOS or Android push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
  OneSignal.Notifications.requestPermission(true);
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
