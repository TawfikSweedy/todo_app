import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/Modules/Archives/archives_tasks.dart';
import 'package:todo_app/Modules/Done/done_tasks.dart';
import 'package:todo_app/Network/Local/Local_Database.dart';
import 'package:todo_app/Shared/Cubit/states.dart';
import '../../Modules/New_Tasks/new_tasks.dart';
import '../Components/Constants.dart';

class AppCubit extends Cubit<AppStates> {
  Database? dataBase;
  Database? tableofTasks;

  List<Map> tasks = [];
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archiveTasks = [];

  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  IconData floatIcon = Icons.edit;
  bool isBottomSheetOpen = false;
  List<Widget> Items = [NewTasks(), DoneTasks(), ArchivesTasks()];
  List<String> titles = ['New Tasks', 'Done Tasks', 'Archives Tasks'];

  void ChangeIndex(int index) {
    currentIndex = index;
    emit(AppChangeNavigationTapState());
  }

  void createDataBase() {
    CreateDataBase().then((value) {
      emit(AppCreateDataBaseState());
    });
  }

  Future CreateDataBase() async {
    return dataBase = await openDatabase('todo.db', version: 1,
        onCreate: (database, version) {
      print('database created');
      database
          .execute(
              'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)')
          .then((value) {
        print('Table Created');
      }).catchError((error) {
        print('database not created');
      });
    }, onOpen: (database) {
      tableofTasks = database;
      GetDataBase(database);
      print('database opened');
    });
  }

  Future InsertDataBase(
      {@required title,
      @required date,
      @required time,
      @required status}) async {
    return await dataBase!.transaction((txn) {
      txn
          .rawInsert(
              'INSERT INTO tasks (title, time, date, status) VALUES ("$title" , "$time" , "$date" , "$status" )')
          .then((value) {
        print('$value Insert Successfully');
        emit(AppInsertDataBaseState());
        GetDataBase(dataBase!);
      }).catchError((error) {
        print('error ${error.toString()}');
      });
      return Future.value(null);
    });
  }

  void GetDataBase(Database data) {
    newTasks = [];
    doneTasks = [];
    archiveTasks = [];
    emit(AppShowIndicatorState());
    data.rawQuery('SELECT * FROM tasks').then((value) {
      tasks = value;
      newTasks = value.where((element) => element['status'] == 'new').toList();
      doneTasks = value.where((element) => element['status'] == 'done').toList();
      archiveTasks = value.where((element) => element['status'] == 'archive').toList();
      print('done taskssss :::: $doneTasks');
      value.forEach((element)  {
        if (element["status"] == 'done') {
          
        }
      });
      emit(AppGetDataBaseState());
    });
  }

  Future RemoveFromData(int id) async {
    await dataBase?.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value) {
      emit(AppDeleteDataBaseState());
      GetDataBase(dataBase!);
    });
  }


  Future UpdateDataBase(
      String status ,
      int id
      ) async {
    return await dataBase?.rawUpdate(
        'UPDATE tasks SET status = ? WHERE id = ?',
        [status, id]
    ).then((value) {
      emit(AppUpdateDataBaseStatus());
      GetDataBase(dataBase!);
    });
  }

  void ChangeBottomSheetShown({required bool isShow, required IconData icon}) {
    isBottomSheetOpen = isShow;
    floatIcon = icon;
    emit(AppChangeBottomSheetShownState());
  }
}
