import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoo/components.dart';

import 'todo/cubit.dart';
import 'todo/states.dart';

class Done extends StatelessWidget {
  const Done({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener:(context,state)
      {

      },
      builder:(context,state)
      {
        var tasks=AppCubit.get(context).donetasks;
        return TasksBuilder(
          tasks: tasks,
        );
      },

    );
  }
}
