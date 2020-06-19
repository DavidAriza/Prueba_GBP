import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prueba_gbp/blocs/task_bloc.dart';
import 'package:prueba_gbp/screens/userTask_page.dart';
import 'package:prueba_gbp/screens/users_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TaskBloc(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          
          primarySwatch: Colors.blue,

          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: UsersPage(),
        routes: {
          'users'     : (BuildContext context) => UsersPage(),
          'userTasks' : (BuildContext context) => UserTaskPage()
        },
      ),
    );
  }
}

