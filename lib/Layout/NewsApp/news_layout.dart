
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/Layout/NewsApp/cubit/cubit.dart';
import 'package:todo_app/Layout/NewsApp/cubit/states.dart';
import 'package:todo_app/Network/Remote/dio_helper.dart';
import 'package:todo_app/Shared/Components/Constants.dart';


class NewsLayout extends StatelessWidget {

  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsCubit()..GetBusinessData() ,
      child: BlocConsumer<NewsCubit , NewsStates>(
          listener: (context , state) {},
          builder: (context , state) {
            var cubit = NewsCubit.get(context);
            return Scaffold(
              key: scaffoldKey,
              appBar: AppBar(
                  title: Text(
                    'News',
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600
                    ),
                  ),
                  centerTitle: true,
                  actions: [
                    IconButton(icon: Icon(
                      Icons.search
                    ),
                     onPressed: (){}
                    ),
                  ],
              ),
              bottomNavigationBar: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  currentIndex: cubit.currentIndex,
                  onTap: (index) {
                    NewsCubit .get(context).ChangeIndex(index);
                  },
                  items: cubit.bottomItems ,
              ),
              body: state is! NewsShowIndicatorState ?  cubit.Screens[cubit.currentIndex] : Center(child: CircularProgressIndicator()) ,
            );
          }
      ),
    );
  }
}
