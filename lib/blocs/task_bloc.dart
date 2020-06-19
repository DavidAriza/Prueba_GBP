import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:prueba_gbp/models/task_model.dart';
import 'package:prueba_gbp/providers/database_provider.dart';
import 'package:rxdart/rxdart.dart';

class TaskBloc extends ChangeNotifier{

  List<Task> _tasks = new List();
  List<Task> _completedTasks = new List();

  StreamController _tasksController = new BehaviorSubject<List<Task>>();
  StreamController _completedTasksController = new BehaviorSubject<List<Task>>();

  Stream<List<Task>> get taskStream => _tasksController.stream;
  Stream<List<Task>> get completedTaskStream => _completedTasksController.stream;  

  dispose(){
    _tasksController?.close();
    _completedTasksController?.close();
  }

  void getTasksByUser(String userId)async{
     _tasks= await DBProvider.db.getTaskByUser(userId);
    _tasksController.sink.add(_tasks);
  }

  void addTask(Task task, String userId) async {
    await DBProvider.db.newTask(task);
    getTasksByUser(userId);
  }

  void getCompletedTasks(String userId) async {
    _completedTasks = await DBProvider.db.getCompletedTaskByUser(userId);
    _completedTasksController.sink.add(_completedTasks);
  }

  void removeTask( String userId,int id) async {
    await DBProvider.db.deleteTask(id);
    getTasksByUser(userId);
  }
  
  void addCompletedTask(Task task, String userId) async{
    await DBProvider.db.completedTask(task);
    getCompletedTasks(userId);
  }

  void isDone(int id) async {
    int index = _tasks.indexWhere((element) => element.id == id);
    _tasks[index].isDone =! _tasks[index].isDone;
    notifyListeners();
  }

}