import 'package:flutter/material.dart';
import 'package:todoapp/components/scroll_no_glow_behavior.dart';
import 'package:todoapp/components/taskcard.dart';
import 'package:todoapp/db/database_helper.dart';
import 'package:todoapp/screens/taskpage.dart';


class HomeScreen extends StatefulWidget {
  
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  DatabaseHelper _databaseHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: 24.0,
          ),
          color: Color(0xFFF6F6F6),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      top: 32,
                        bottom: 32
                    ),
                    child: Image(
                      image: AssetImage(
                          'assets/images/logo.png'
                      ),
                    ),
                  ),
                  Expanded(
                    child: FutureBuilder(
                      initialData: [],
                      future: _databaseHelper.getTasks(),
                      builder: (context, snapshot){
                        return ScrollConfiguration(
                            behavior: ScrollNoGlowBehavior(),
                            child: ListView.builder(
                          itemCount:  snapshot.data.length,
                          itemBuilder: (context,index){
                            return GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => TaskPage(
                                  task: snapshot.data[index],
                                ),
                                ),
                                ).then((value) {
                                  setState(() {

                                  });
                                });
                              },
                              child: TaskCard(
                                title: snapshot.data[index].title,
                                description: snapshot.data[index].description,
                              ),
                            );
                          },
                        ));
                      },
                    ),
                  )

                ],

              ),
              Positioned(
                bottom: 24.0,
                  right: 0.0,
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(
                          context,
                        MaterialPageRoute(builder: (context) => TaskPage(task: null))
                      ).then((value){
                        setState(() {

                        });
                      });
                    },
                    child: Container(
                      width: 60.0,height: 60.0,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFF7349FE),Color(0xFF643FDB)],
                            begin: Alignment(0.0,-1.0),
                          end: Alignment(0.0,1.0)
                        ),
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: Image(
                        image: AssetImage(
                          "assets/images/add_icon.png",
                        ),
                      ),
                    ),
                  ),)
            ],
          )
        ),
      ),
    );
  }
}
