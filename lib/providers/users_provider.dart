import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:prueba_gbp/models/user_model.dart';

class UserProvider {

  String _url = 'https://api.github.com/users';

  Future<List<User>> getUsers() async {

    // List<User> users = [
    //   User(
    //     name: 'foo',
    //     image: 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/1024px-No_image_available.svg.png',
    //     link: 'https://google.com'
    //   ),
    //   User(
    //     name: 'bar',
    //     image: 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/1024px-No_image_available.svg.png',
    //     link: 'https://google.com'
    //   )
    // ];


    List<User> users = new List();

    var response = await http.get(_url);
    var jsonData = json.decode(response.body);
    
    for(var item in jsonData){
      users.add(User.fromJson(item));
    }
    print(users);
    return users;

  }


}