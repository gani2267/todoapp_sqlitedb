import 'package:flutter/material.dart';
import 'package:todoapp/components/scroll_no_glow_behavior.dart';
import 'package:todoapp/components/todowidget.dart';
import 'package:todoapp/db/database_helper.dart';
import 'package:todoapp/screens/home.dart';

import '../db/model/task.dart';
import '../db/model/todo.dart';

class TaskPage extends StatefulWidget {
  final Task task;

  const TaskPage({@required this.task});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  DatabaseHelper _dbHelper = DatabaseHelper();

  int _taskId = 0;
  String _taskTitle = "";
  String _taskDescription = "";

  FocusNode _titleFocus;
  FocusNode _descriptionFocus;
  FocusNode _todoFocus;

  bool _contentVisile = false;

  @override
  void initState() {
    if (widget.task != null) {
      // Set visibility to true
      _contentVisile = true;

      _taskTitle = widget.task.title;
      _taskDescription = widget.task.description;
      _taskId = widget.task.id;
    }

    _titleFocus = FocusNode();
    _descriptionFocus = FocusNode();
    _todoFocus = FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    _titleFocus?.dispose();
    _descriptionFocus?.dispose();
    _todoFocus?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(

          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: 24,bottom: 6
                    ),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: EdgeInsets.all(24.0),
                            child: Image(
                              image: AssetImage(
                                  'assets/images/back_arrow_icon.png'
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            focusNode: _titleFocus,
                            onSubmitted: (value) async {

                              // check if field is not empty
                              if(value != "") {
                                // check if task is null
                                if (widget.task == null) {


                                  Task _newTask = Task(
                                    title: value,
                                  );

                                  _taskId = await _dbHelper.insertTask(_newTask);

                                  setState(() {
                                    _contentVisile = true;
                                    _taskTitle = value;
                                  });
                                }else{
                                  await _dbHelper.updateTaskTitle(_taskId, value);

                                }
                                _descriptionFocus.requestFocus();
                              }
                            },
                            controller: TextEditingController()..text = _taskTitle,
                            decoration: InputDecoration(
                                hintText: "Enter Task Title",
                                border: InputBorder.none
                            ),
                            style: TextStyle(
                              fontSize: 26.0,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF211551),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Visibility(
                    visible: _contentVisile,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 12),
                      child: TextField(
                        focusNode: _descriptionFocus,
                        onSubmitted: (value) async {
                          if(value != ""){
                            if(_taskId != 0){
                              await _dbHelper.updateTaskDescription(_taskId, value);
                              _taskDescription = value;
                            }
                          }
                          _todoFocus?.requestFocus();
                        },
                        controller: TextEditingController()..text = _taskDescription,
                        decoration: InputDecoration(
                            hintText: "Enter Description for the task...",border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 24,
                            )
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: FutureBuilder(
                      initialData: [],
                      future: _dbHelper.getTodo(_taskId),
                      builder: (context, snapshot){
                        return ScrollConfiguration(
                            behavior: ScrollNoGlowBehavior(),
                            child: ListView.builder(
                              itemCount:  snapshot.data.length,
                              itemBuilder: (context,index){
                                return GestureDetector(
                                  onTap: () async {

                                    if(snapshot.data[index].isDone == 0){
                                      await _dbHelper.updateTodoDone(snapshot.data[index].id, 1);
                                    } else {
                                      await _dbHelper.updateTodoDone(snapshot.data[index].id, 0);
                                    }
                                    setState(() {

                                    });
                                  },
                                  child: TodoWidget(
                                    text: snapshot.data[index].title,
                                    isDone: snapshot.data[index].isDone == 0 ? false: true,
                                  ),
                                );
                              },
                            ));
                      },
                    ),
                  ),

                  // code below has error
                  // Expanded(
                  //   child: FutureBuilder(
                  //     initialData: [],
                  //     future: _dbHelper.getTodo(_taskId),
                  //     builder: (context, snapshot){
                  //       return ListView.builder(
                  //         itemCount: snapshot?.data.length ?? 0,
                  //         itemBuilder: (context,index){
                  //           return GestureDetector(
                  //             onTap: () async {
                  //               Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(),
                  //               ),
                  //               ).then((value) {
                  //                 setState(() {
                  //
                  //                 });
                  //               });
                  //               if(snapshot.data[index].isDone == 0){
                  //                 await _dbHelper.updateTodoDone(snapshot.data[index].id, 1);
                  //               } else {
                  //                 await _dbHelper.updateTodoDone(snapshot.data[index].id, 0);
                  //               }
                  //
                  //               setState(() {});
                  //             },
                  //             child: TodoWidget(
                  //               text: snapshot.data[index].title,
                  //    isDone: snapshot.data[index].isDone == 0 ? false: true,
                  //             ),
                  //           );
                  //         },
                  //       );
                  //     },
                  //   ),
                  // ),
                  Visibility(
                    visible: _contentVisile,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: Row(
                        children: [
                          Container(
                            width: 20,height: 20,
                            margin: EdgeInsets.only(
                                right: 12
                            ),
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                    color: Color(0xFF86829D),
                                    width: 1.5
                                )
                            ),
                            child: Image(
                              image: AssetImage('assets/images/check_icon.png'),
                            ),
                          ),
                          Expanded(
                              child: TextField(
                                focusNode: _todoFocus,
                                controller: TextEditingController()..text = "",
                                onSubmitted: (value) async {

                                  // check if field is not empty
                                  if(value != "") {
                                    // check if task is null
                                    if (_taskId !=0) {
                                      DatabaseHelper _dbHelper = DatabaseHelper();

                                      Todo _newTodo = Todo(
                                        title: value,
                                        isDone: 0,
                                        taskId: _taskId,
                                      );

                                      await _dbHelper.insertTodo(_newTodo);
                                      setState(() {
                                        _todoFocus.requestFocus();
                                      });

                                    }else{
                                      print("Task doesn't exit");
                                    }
                                  }

                                },
                                decoration: InputDecoration(
                                    hintText: "Enter Todo item...",
                                    border: InputBorder.none
                                ),
                              )
                          ),],
                      ),
                    ),
                  ),

                ],
              ),
              Visibility(
                visible: _contentVisile,
                child: Positioned(
                  bottom: 24.0,
                  right: 24.0,
                  child: GestureDetector(
                    onTap: () async {
                      if(_taskId != 0) {
                        Navigator.pop(context);
                        await _dbHelper.deleteTask(_taskId);
                      }
                    },
                    child: Container(
                      width: 60.0,height: 60.0,
                      decoration: BoxDecoration(
                          color: Color(0xFFFE3577),
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: Image(
                        image: AssetImage(
                          "assets/images/delete_icon.png",
                        ),
                      ),
                    ),
                  ),),
              )],
          ),
        ),
      )
    );
  }


}
