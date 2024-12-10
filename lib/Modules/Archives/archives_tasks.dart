import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Shared/Components/Components.dart';
import '../../Shared/Cubit/cubit.dart';
import '../../Shared/Cubit/states.dart';

class ArchivesTasks extends StatelessWidget {
  const ArchivesTasks({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit , AppStates>(
        builder: (context , state) {
          return ListView.separated(
            itemBuilder: (context , index) => buildTaskItem(AppCubit.get(context).archiveTasks[index] , context ),
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
            itemCount: AppCubit.get(context).archiveTasks.length ,
          );
        },
        listener: (context , state) {

        }
    );
  }
}