class Todo{
  final int id;
  final String title;
  final int taskId;
  final int isDone;

  Todo({this.id,this.taskId,this.title,this.isDone});

  Map<String, dynamic> toMap(){
    return{
      'id': id,
      'taskId': taskId,
      'title': title,
      'isDone': isDone,
    };
  }
}