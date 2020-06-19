import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:prueba_gbp/blocs/task_bloc.dart';
import 'package:prueba_gbp/models/task_model.dart';
import 'package:prueba_gbp/models/user_model.dart';

class CompletedTaskList extends StatefulWidget {
  final User user;
  CompletedTaskList({Key key, this.user}) : super(key: key);

  @override
  _CompletedTaskListState createState() => _CompletedTaskListState();
}

class _CompletedTaskListState extends State<CompletedTaskList> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bloc = Provider.of<TaskBloc>(context);
    bloc.getCompletedTasks(widget.user.name);
    return StreamBuilder<List<Task>>(
      stream: bloc.completedTaskStream ,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        if(snapshot.hasData){
          List<Task> tasks = snapshot.data;
          return Container(
            height: size.height*0.3,
            child: ListView.builder(
              itemCount: tasks.length ,
              itemBuilder: (context, index) {
                String dateFormate = DateFormat("dd-MM-yyyy HH:mm").format(DateTime.parse(tasks[index].date));
                return Container(
                  padding: const EdgeInsets.all(5.0),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.check_box, color: Colors.green),
                          SizedBox(width: 10.0,),                     
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(tasks[index].task),
                                SizedBox(height: 10.0,),
                                Text(dateFormate)
                              ],
                            ),
                          )
                        ],
                      ),
                    )            
                  ),
                );
              },),
          );
        } else{
          return CircularProgressIndicator();
        }
        
      },
    );
  }
}

