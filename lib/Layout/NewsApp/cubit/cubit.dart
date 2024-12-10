import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/Layout/NewsApp/cubit/states.dart';
import 'package:todo_app/Modules/NewsModules/Business/business_screen.dart';
import 'package:todo_app/Modules/NewsModules/Science/science_screen.dart';
import 'package:todo_app/Modules/NewsModules/Settings/settings_screen.dart';
import 'package:todo_app/Modules/NewsModules/Sports/sports_screen.dart';
import 'package:todo_app/Network/Remote/dio_helper.dart';

import '../../../Shared/Components/Constants.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
      icon: Icon(
          Icons.business
      ),
      label: 'Business',
    ),
    BottomNavigationBarItem(
      icon: Icon(
          Icons.sports
      ),
      label: 'Sports',
    ),
    BottomNavigationBarItem(
      icon: Icon(
          Icons.science
      ),
      label: 'Science',
    ),
    BottomNavigationBarItem(
      icon: Icon(
          Icons.settings
      ),
      label: 'Settings',
    ),
  ];

  List<Widget> Screens = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
    SettingsScreen()
  ];

  List<Map> business = [];

  void ChangeIndex(int index) {
    currentIndex = index;
    emit(NewsChangeNavigationTapState());
  }

  void GetBusinessData() {
    emit(NewsLoadingState());
    var quries = {
      'country' : 'eg',
      'category' : 'business',
      'apiKey' : 'ae4081daeba24222b8e0bef991aae771'
    };
    DioHelper.getData(query: quries , url: method_url).then((response) {
      business = response?.data['articles'];
      print('DDDD $business');
      emit(NewsGetBusinessSuccessState());
    }).catchError((error) {
      print('DDDD $error');
      emit(NewsGetBusinessFalireState(error: error.toString()));
    });
  }




}