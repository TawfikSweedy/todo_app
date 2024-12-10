
import 'package:flutter/material.dart';
import 'package:todo_app/Shared/Cubit/cubit.dart';

Widget defaultTextInput({
  bool isObscureText = false,
  required TextEditingController fromController,
  Function(String)? onFieldSubmit,
  Function(String)? onChange,
  String? Function(String?)? validationCallBack,
  required TextInputType keyboardType,
  String label = "Text Field",
  required String hint,
  IconData prefixIcon = Icons.edit,
  IconData? suffixIcon,
  VoidCallback? suffixPressed,
  VoidCallback? onTap,
}) =>
    TextFormField(
      obscureText: isObscureText,
      controller: fromController,
      onFieldSubmitted: onFieldSubmit,
      onChanged: onChange,
      keyboardType: keyboardType,
      validator: validationCallBack,
      onTap: onTap,
      decoration: InputDecoration(
          hintText: label,
          labelText: hint,
          prefixIcon: Icon(prefixIcon),
          suffixIcon: suffixIcon != null
              ? IconButton(icon: Icon(suffixIcon), onPressed: suffixPressed)
              : null,
          border: const OutlineInputBorder()),
    );


Widget buildTaskItem(Map model , context) => Dismissible(
  key: Key(model['id '].toString()),
  onDismissed: (direction) {
     AppCubit.get(context).RemoveFromData(model["id"]);
  },
  child: Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        CircleAvatar(
          radius: 40.0,
          child: Text('${model["time"]}'),
        ),
        SizedBox(
          width: 20.0,
        ),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Task Title : ${model["title"]}' ,
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(
                width: 20.0,
              ),
              Text(
                '${model["date"]}' ,
                style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey
                ),
              )
            ],
          ),
        ),
        SizedBox(
          width: 20.0,
        ),
        Row(
          children: [
            IconButton(
                onPressed: () {
                  AppCubit.get(context).UpdateDataBase('done', model["id"]);
                },
                icon: Icon(
                  Icons.done_all,
                  color: Colors.green,
                )
            ),
            IconButton(
                onPressed: () {
                  AppCubit.get(context).UpdateDataBase('archive', model["id"]);
                },
                icon: Icon(
                    Icons.archive_sharp,
                    color: Colors.black45,
                )
            ),
          ],
        ),
        // Expanded(
        //   child: Text('${model["status"]}',
        //     style: TextStyle (
        //       fontSize: 14.0,
        //     ),
        //   ),
        // )
      ],
    ),
  ),
);