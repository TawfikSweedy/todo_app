import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/Shared/Cubit/cubit.dart';
import 'package:todo_app/Shared/Cubit/states.dart';
import '../../Shared/Components/Components.dart';
import '../../Shared/Components/Constants.dart';

class NewTasks extends StatelessWidget {
  const NewTasks({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit , AppStates>(
        builder: (context , state) {
          return ListView.separated(
            itemBuilder: (context , index) => buildTaskItem(AppCubit.get(context).newTasks[index] , context),
            separatorBuilder: (context , index) => Padding(
              padding: const EdgeInsetsDirectional.only(
                  start: 20.0
              ),
              child: Container(
                width: double.infinity,
                height: 1.0,
                color: Colors.grey[300],
              ),
            ),
            itemCount: AppCubit.get(context).newTasks .length ,
          );
        },
        listener: (context , state) {

        }
    );
  }
}
