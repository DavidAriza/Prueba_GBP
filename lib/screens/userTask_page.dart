import 'package:flutter/material.dart';
import 'package:prueba_gbp/models/user_model.dart';
import 'package:prueba_gbp/widgets/completedTask_list.dart';
import 'package:prueba_gbp/widgets/taskDialog.dart';
import 'package:prueba_gbp/widgets/task_list.dart';

class UserTaskPage extends StatelessWidget {
  const UserTaskPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final User user = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('Actividades de usuario'),
        centerTitle: true,
      ),
      body: Body(user: user,),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          _getDialog(context, user);

        },
      ),
    );
  }
  _getDialog(context, User user) async {
    return showDialog(
      context: context,
      child: TaskDialog(
        user: user,
      )
    );
  }

}

class Body extends StatefulWidget {
  final User user;
  Body({Key key, this.user}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: NetworkImage(widget.user.image),
                  radius: 40,
                ),
                SizedBox(width: 10.0,),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(widget.user.name, style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 18)),
                      Text(widget.user.link)
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            height: 30,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.orangeAccent
            ),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Pendientes'),
            ),
            
          ),
          TaskList(
            user: widget.user,             
          ),
          Container(
            height: 30,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.green
            ),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Completadas'),
            ),
            
          ),
          CompletedTaskList(
            user: widget.user,             
          )
        ],
      ),
    );
  }
}