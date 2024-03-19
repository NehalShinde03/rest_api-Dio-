class Models{

  int userId;
  int id;
  String title;
  String body;

  Models({this.userId=0, this.id=0, this.title="", this.body=""});

  factory Models.fromJson(Map<String, dynamic> json) => Models(
    userId : json['userId'],
    id : json['id'],
    title : json['title'],
    body : json['body'],
  );

}