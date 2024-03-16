import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/consistency.dart';
import 'package:social_app/shared/shared%20prefrence.dart';
import 'package:social_app/social%20screen/login/login%20screen.dart';

import 'app_cubit/social_cubit.dart';
import 'firebase/firebase_options.dart';
import 'layout/social layout.dart';
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
}
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  String? token=await FirebaseMessaging.instance.getToken();
  print (" tokenn is${token}");

//foreground fcm
  FirebaseMessaging.onMessage.listen((event) {
    print(event.data);
  }

  );

// when click on notification to open the app
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print(event.data);
  });


  //background fcm

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  await CachHelper.init();

 UID = CachHelper.getdata(key: 'UId') as String?;
  print("habiba Uid  ${UID}");
  Widget startScreen;
  if (UID != null) {
    startScreen = SocialLayout();
  } else {
    startScreen = login();
  }
  runApp(MyApp(startScreen));
}

class MyApp extends StatelessWidget {
  var StartScreen;
  MyApp(this.StartScreen);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialCubit()..GetDataToShow()..getPosts(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            appBarTheme: const AppBarTheme(
                elevation: 0,
                color: Colors.white,
                iconTheme: IconThemeData(color: Colors.black),
                titleTextStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
                systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.white,
                    statusBarIconBrightness: Brightness.dark)),
            scaffoldBackgroundColor: Colors.white,
            textTheme: const TextTheme(
              bodyLarge: TextStyle(
                  color: Colors.grey,
                  fontSize: 17,
                  fontWeight: FontWeight.bold),
              headlineSmall: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.bold),
              headlineLarge: TextStyle(color: Colors.black),
            ),
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                selectedItemColor: Colors.blue,
                unselectedItemColor: Colors.grey)),
        home: StartScreen,
      ),
    );
  }
}
