import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/auth_cubit/authcubit.dart';
import 'package:shopapp/firebase_options.dart';
import 'package:shopapp/layout/cubit_layout/social_cubite.dart';
import 'package:shopapp/layout/cubit_layout/social_screen.dart';
import 'package:shopapp/modules/login.dart';
import 'package:shopapp/modules/on_bording.dart';
import 'package:shopapp/modules/shared%20prefersnce.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
await sharedprof.init();
Widget widget;
String?uid=sharedprof.getData(key:'uid');
if(uid !=null){
  widget=socialscreen();
}else{

  widget=OnBording();
}
  runApp(

  MultiBlocProvider(
      providers: [
        BlocProvider<authcubit>(create: (context) => authcubit()),
            BlocProvider<socialcubite>(create: (context) => socialcubite()..getuserdata()..getpost()),

     // إضافة ThemeCubit
      ],
      
      child: MyApp(
startwidget: widget

      ),
),

  );
}

class MyApp extends StatelessWidget {

final Widget startwidget;
  const MyApp({required this.startwidget});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

theme: ThemeData(
  appBarTheme: AppBarTheme(backgroundColor: Colors.white),
  scaffoldBackgroundColor:Colors.white,
  textTheme: TextTheme(
    bodyLarge: TextStyle(color:Colors.black),
     bodyMedium: TextStyle(color:Colors.black),
      bodySmall: TextStyle(color:Colors.black)
      
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: Colors.deepOrange),
    brightness: Brightness.light,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,     // لون الخلفية
      selectedItemColor: Colors.blue,    // لون المختار
      unselectedItemColor: Colors.grey,
        // لون الغير مختار
      elevation: 10,                      // ارتفاع ظل البار
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

      home:startwidget,
    );
  }
}