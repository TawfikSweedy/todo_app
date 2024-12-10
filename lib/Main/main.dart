import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_app/Layout/Home/HomeLayout.dart';
import 'package:todo_app/Layout/NewsApp/cubit/cubit.dart';
import 'package:todo_app/Network/Remote/dio_helper.dart';
import 'package:todo_app/Shared/Bloc_Observer/Bloc_Observer.dart';
import 'package:todo_app/Shared/Components/Constants.dart';

import '../Layout/NewsApp/news_layout.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  runApp(const todo_app());
}

class todo_app extends StatelessWidget {
  const todo_app({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark
          ),
          backgroundColor: Colors.white,
          elevation: 0.0,
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 20.0 ,
            fontWeight: FontWeight.bold
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            selectedItemColor: Colors.deepOrange
        )
      ),
      themeMode: ThemeMode.light,
      home: Homelayout(),
    );
  }
}
