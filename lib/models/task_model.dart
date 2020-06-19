

class Task {

  int id;
  String userId;
  String task;
  String date;
  bool isDone;

  Task({this.id, this.userId, this.task, this.date, this.isDone = false});

  factory Task.fromJson(Map<String,dynamic> json ) => new Task(
    id : json['id'],
    userId: json['userId'],
    task: json['task'],
    date: json['date']
  );

  Map<String,dynamic> toMap(){
    var map = new Map<String,dynamic> ();
    if(id!= null){
      map['id'] = id;
    }
    map['userId'] = userId;
    map['task'] = task;
    map['date'] = date;
    return map;
  }

}