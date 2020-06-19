import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prueba_gbp/blocs/task_bloc.dart';

import 'package:prueba_gbp/models/task_model.dart';
import 'package:prueba_gbp/models/user_model.dart';

class TaskDialog extends StatefulWidget {
  final User user;

  TaskDialog({Key key, this.user}) : super(key: key);

  @override
  _TaskDialogState createState() => _TaskDialogState();
}

class _TaskDialogState extends State<TaskDialog> {

  TextEditingController _controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<TaskBloc>(context, listen: false);
    final size = MediaQuery.of(context).size;
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0)
      ),
      title: Center(child: Text('Crear actividad', style: TextStyle(color:Colors.blue),)),
      content: Container(
        height: size.height*0.15,
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10.0)
              ),
              child: TextFormField(
                decoration: InputDecoration(
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none
                ),
                controller: _controller,
                maxLines: 4,
                onChanged: (value){
                },
                
              ),
            ),
            Row(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey)
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey)
                  ),
                )
              ],
            )
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
              child: Text('Aceptar'),
              onPressed: ()async{
                setState(() {
                  Task task = Task(
                    userId: widget.user.name,
                    task: _controller.text,
                    date: DateTime.now().toString(),
                    
                  );
                  bloc.addTask(task, widget.user.name);
                });
                Navigator.pop(context);
              }
        ),
        FlatButton(
              child: Text('Cancelar'),
              onPressed: () {Navigator.pop(context);}
        ),
      ],
    );

  }
}