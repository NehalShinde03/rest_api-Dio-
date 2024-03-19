class Model{

  int userId;
  int id;
  String title;

  Model({this.userId=0, this.id=0, this.title=""});

  factory Model.fromJson(Map<String, dynamic> json) => Model(
      userId : json['userId'],
      id : json['id'],
      title : json['title'],
  );

}