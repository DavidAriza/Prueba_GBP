class User{

  String name;
  String image;
  String link;

  User({this.name, this.link, this.image});

  factory User.fromJson(Map<String,dynamic> json ) => new User(
    name: json['login'],
    image: json['avatar_url'],
    link: json['url']
  );

}