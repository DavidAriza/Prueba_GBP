import 'package:flutter/material.dart';
import 'package:prueba_gbp/models/user_model.dart';
import 'package:prueba_gbp/providers/users_provider.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Prueba GBP'),
        centerTitle: true
      ),
      body: Body(),
      
    );
  }
}

class Body extends StatefulWidget {
  Body({Key key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  
  UserProvider userProvider = new UserProvider();
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: FutureBuilder(
        future: userProvider.getUsers() ,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if(snapshot.hasData){
            List<User> users = snapshot.data;
            return ListView.separated(
              itemCount: users.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: <Widget>[
                        CircleAvatar(
                          backgroundImage: NetworkImage(users[index].image),
                          radius: 40,
                        ),
                        SizedBox(width: 10.0,),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(users[index].name, style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 18)),
                              Text(users[index].link)
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  onTap: (){
                    Navigator.pushNamed(context, 'userTasks', arguments: users[index]);
                  },
                );
              },
              separatorBuilder: (context, index) {
                  return Divider(height: 50,);
              }
            );

          } else return Center(child: Text('Cargando usuarios...'),);
        },
      ),
    );
    
  }
}