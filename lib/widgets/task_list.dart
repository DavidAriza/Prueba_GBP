
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import 'package:prueba_gbp/blocs/task_bloc.dart';
import 'package:prueba_gbp/models/task_model.dart';
import 'package:prueba_gbp/models/user_model.dart';

class TaskList extends StatefulWidget {
  final User user;
  TaskList({Key key, this.user}) : super(key: key);

  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bloc = Provider.of<TaskBloc>(context);
    bloc.getTasksByUser(widget.user.name);
    return StreamBuilder<List<Task>>(
      stream: bloc.taskStream ,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        if(snapshot.hasData){
          List<Task> tasks = snapshot.data;
          return Container(
            padding: EdgeInsets.all(5.0),
            height: size.height*0.3,
            child: ListView.builder(
              itemCount: tasks.length ,
              itemBuilder: (context, index) {
                return TaskItem(
                  task: tasks[index],
                  user: widget.user,
                );
              },
              ),
          );
        } else{
          return CircularProgressIndicator();
        }
        
      },
    );
  }
}

class TaskItem extends StatefulWidget {
  final Task task;
  final User user;
  TaskItem({Key key, this.task, this.user}) : super(key: key);

  @override
  _TaskItemState createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  @override
  Widget build(BuildContext context) {
    
    String dateFormate = DateFormat("dd-MM-yyyy HH:mm").format(DateTime.parse(widget.task.date));
    _checkItem()async{
      Provider.of<TaskBloc>(context, listen: false).isDone(widget.task.id);
    }
    return GestureDetector(
      onTap: _checkItem,
      child: Card(
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Checkbox(
                value: widget.task.isDone,
                onChanged: (value){
                  _checkItem();
                  Provider.of<TaskBloc>(context,listen: false).removeTask(widget.task.userId, widget.task.id);
                  Provider.of<TaskBloc>(context,listen: false).addCompletedTask(widget.task, widget.task.userId);
                },
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(widget.task.task),
                    Text(dateFormate)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}