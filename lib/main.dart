import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_cubit/authcubit.dart';
import 'firebase_options.dart';
import 'layout/cubit_layout/social_cubite.dart';
import 'layout/cubit_layout/social_screen.dart';
import 'modules/on_bording.dart';
import 'modules/shared%20prefersnce.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await SharedProf.init();
  Widget widget;
  String? uid = SharedProf.getData(key: 'uid');
  if (uid != null) {
    widget = SocialScreen();
  } else {
    widget = OnBording();
  }
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(create: (context) => AuthCubit()),
        BlocProvider<SocialCubite>(
            create: (context) => SocialCubite()
              ..getuserdata()
              ..getpost()),

        // إضافة ThemeCubit
      ],
      child: MyApp(startwidget: widget),
    ),
  );
}

class MyApp extends StatelessWidget {
  final Widget startwidget;
  const MyApp({super.key, required this.startwidget});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(backgroundColor: Colors.white),
        scaffoldBackgroundColor: Colors.white,
        textTheme: TextTheme(
            bodyLarge: TextStyle(color: Colors.black),
            bodyMedium: TextStyle(color: Colors.black),
            bodySmall: TextStyle(color: Colors.black)),
        floatingActionButtonTheme:
            FloatingActionButtonThemeData(backgroundColor: Colors.deepOrange),
        brightness: Brightness.light,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.white, // لون الخلفية
          selectedItemColor: Colors.blue, // لون المختار
          unselectedItemColor: Colors.grey,
          // لون الغير مختار
          elevation: 10, // ارتفاع ظل البار
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.black,
          selectedItemColor: Colors.amber,
          unselectedItemColor: Colors.white70,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: startwidget,
    );
  }
}
