import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/Modules/Archives/archives_tasks.dart';
import 'package:todo_app/Modules/Done/done_tasks.dart';
import 'package:todo_app/Modules/New_Tasks/new_tasks.dart';
import 'package:todo_app/Network/Local/Local_Database.dart';
import 'package:todo_app/Shared/Components/Components.dart';
import 'package:todo_app/Shared/Cubit/cubit.dart';
import 'package:todo_app/Shared/Cubit/states.dart';

import '../../Shared/Components/Constants.dart';

class Homelayout extends StatelessWidget
{

  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var statusController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..createDataBase() ,
      child: BlocConsumer<AppCubit , AppStates>(
        listener: (context , state) {},
        builder: (context , state) {
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar (
              centerTitle: true,
              title: Text(
                AppCubit.get(context).titles[AppCubit.get(context).currentIndex],
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
              backgroundColor: Colors.blue,
              onPressed: () {
                if (AppCubit.get(context).isBottomSheetOpen) {
                  if (formKey.currentState!.validate()) {
                    AppCubit.get(context).InsertDataBase(
                        title: titleController.text,
                        date: dateController.text,
                        time: timeController.text,
                        status: 'new'
                    ).then((value) {
                      Navigator.pop(context);
                      // AppCubit.get(context).ChangeBottomSheetShown(isShow: false, icon: Icons.edit);
                    });
                  } else {

                  }
                } else {
                  AppCubit.get(context).floatIcon = Icons.add;
                  scaffoldKey.currentState?.showBottomSheet(
                        (context) => Container(
                      // color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Form(
                          key: formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children:
                            [
                              defaultTextInput(
                                  fromController: titleController,
                                  keyboardType: TextInputType.text,
                                  validationCallBack: (value) {
                                    if (value!.isEmpty) {
                                      return 'Title must not be Empty';
                                    }
                                    return null;
                                  },
                                  hint: 'Task Title',
                                  prefixIcon: Icons.title
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              defaultTextInput(
                                  fromController: timeController,
                                  keyboardType: TextInputType.datetime,
                                  onTap: () {
                                    showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                    ).then((time) {
                                      timeController.text =
                                          time!.format(context).toString();
                                    });
                                  },
                                  validationCallBack: (value) {
                                    if (value!.isEmpty) {
                                      return 'Time must not be Empty';
                                    }
                                    return null;
                                  },
                                  hint: 'Task Time',
                                  prefixIcon: Icons.timer),
                              const SizedBox(
                                height: 20,
                              ),
                              defaultTextInput(
                                  fromController: dateController,
                                  keyboardType: TextInputType.datetime,
                                  onTap: () {
                                    showDatePicker(
                                      context: context,
                                      firstDate: DateTime.now(),
                                      initialDate: DateTime.now(),
                                      lastDate: DateTime(2025),
                                    ).then((date) {
                                      dateController.text = DateFormat.yMMMd().format(date!);
                                    });
                                  },
                                  validationCallBack: (value) {
                                    if (value!.isEmpty) {
                                      return 'Date must not be Empty';
                                    }
                                    return null;
                                  },
                                  hint: 'Task Date',
                                  prefixIcon: Icons.date_range_outlined),
                              const SizedBox(
                                height: 20,
                              ),
                              // defaultTextInput(
                              //     fromController: statusController,
                              //     keyboardType: TextInputType.text,
                              //     validationCallBack: (value) {
                              //       if (value!.isEmpty) {
                              //         return 'Status must not be Empty';
                              //       }
                              //       return null;
                              //     },
                              //     hint: 'Task Status',
                              //     prefixIcon: Icons.info_outline),
                            ],
                          ),
                        ),
                      ),
                    ),
                    elevation: 30.0,
                  ).closed.then((value) {
                    AppCubit.get(context).ChangeBottomSheetShown(isShow: false, icon: Icons.edit);
                  });
                  AppCubit.get(context).ChangeBottomSheetShown(isShow: true, icon: Icons.add);
                }
              },
              child: Icon(
                AppCubit.get(context).floatIcon,
                color: Colors.white,
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex: AppCubit.get(context).currentIndex,
                onTap: (index) {
                  AppCubit.get(context).ChangeIndex(index);
                },
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.menu),
                    label: 'Tasks',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.check_circle_outline),
                    label: 'Done',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.archive_outlined),
                    label: 'Archives',
                  )
                ]),
            body: state is! AppShowIndicatorState ?  AppCubit.get(context).Items[AppCubit.get(context).currentIndex] : Center(child: CircularProgressIndicator()) ,
          );
        }
      ),
    );
  }
}


