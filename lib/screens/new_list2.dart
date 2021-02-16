import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:new_event/screens/note_detail.dart';
import 'package:new_event/models/note.dart';
import 'package:new_event/utils/database_helper.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart';

class EventList extends StatefulWidget {
  Note note;

  _callMethod(BuildContext context) => createState()._delete(context, note);

  @override
  _EventListState createState() => _EventListState();
}

class _EventListState extends State<EventList> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Note> noteList;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    if (noteList == null) {
      noteList = List<Note>();
      updateListView();
    }
    return Scaffold(
      // backgroundColor: Colors.blueGrey,

      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: <Widget>[
              Container(
                //padding: EdgeInsets.symmetric(),
                decoration: BoxDecoration(color: Color(0xff102733)),
              ),
              SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  // padding: EdgeInsets.symmetric(vertical: 25, horizontal: 10),

                  padding: EdgeInsets.only(left: 10, top: 22, right: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        //padding: EdgeInsets.symmetric(vertical: 30),
                        child: Row(
                          children: <Widget>[
                            Text(
                              "Event",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w800),
                            ),
                            Text(
                              "App",
                              style: TextStyle(
                                  color: Colors.deepOrangeAccent,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w800),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          Text(
                            "All Events",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SingleChildScrollView(
                        child: Container(// color: Colors.blue,
                          height: MediaQuery.of(context).size.height - 100,
                          //height: 512,
                          child:
                              //notesListView()
                              //notesListView1(),
                              GestureDetector(child: notesListView2()),
                        ),
                      )
                    ],
                  ),
                ),
              ),

              //  notesListView(),
            ],
          ),
        ),
      ),

      floatingActionButton: Container(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        child: FloatingActionButton(
            backgroundColor: Colors.deepOrangeAccent,
            child: Icon(Icons.add),
            onPressed: () {
              debugPrint('Fab Clicked');
              navigateToDetail(Note('', '', 2, "", ""), 'Add Note');
            }),
      ),
    );
  }

  Widget notesListView2() {
    TextStyle titleStyle = Theme.of(context).textTheme.subtitle1;
    return SingleChildScrollView(
      child: Container(// color: Colors.green,
        child: ListView.builder(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            itemCount: count,
            itemBuilder: (BuildContext context, int position) {
              return GestureDetector(
                onTap: () {
                  debugPrint('ListTile Tapped');
                  navigateToDetail(this.noteList[position], 'Edit note');
                },
                child: Container(
                //  height: MediaQuery.of(context).size.height,
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                      color: Color(0xff29404E),
                      borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    children: <Widget>[
                      Container(  //color: Colors.deepOrangeAccent,
                        padding: EdgeInsets.only(left: 16),
                        width: MediaQuery.of(context).size.width - 26,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              this.noteList[position].title,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 22),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Container(
                             // color: Colors.blue,
                              child: Row(
                                children: <Widget>[
                                  Image.asset(
                                    "assets/calender.png",
                                    height: 18,
                                  ),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  Expanded(
                                    child: Container(
                                     // width: MediaQuery.of(context).size.width - 80,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            this.noteList[position].date,
                                            style: TextStyle(
                                                color: Colors.white, fontSize: 15),
                                          ),

                                          //SizedBox(width: 15,),

                                          GestureDetector(
                                              child: Container(
                                                height: 40,
                                                width: 40,
                                                child: Icon(
                                                  Icons.delete,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              onTap: () {
                                                _delete(
                                                    context, noteList[position]);
                                              }),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: <Widget>[
                                Image.asset(
                                  "assets/location.png",
                                  height: 18,
                                ),
                                SizedBox(
                                  width: 12,
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width - 100,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        this.noteList[position].address,
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 15),
                                      ),],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      //),

                      // ClipRRect(
                      //   borderRadius: BorderRadius.only(topRight: Radius.circular(8), bottomRight: Radius.circular(8)),
                      // child: Image.asset(imgeAssetPath, height: 100,width: 120, fit: BoxFit.cover,)),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }

  // Returns the priority color

  Color getPriorityColor(int priority) {
    switch (priority) {
      case 1:
        return Colors.deepOrangeAccent;
        break;

      case 2:
        return Colors.lightGreenAccent;
        break;

      default:
        return Colors.lightGreenAccent;
    }
  }

  // Returns to priority icon

  Icon getIconPriority(int priority) {
    switch (priority) {
      case 1:
        return Icon(Icons.arrow_right);
        break;

      case 2:
        return Icon(Icons.keyboard_arrow_right);
        break;

      default:
        return Icon(Icons.keyboard_arrow_right);
    }
  }

  void _delete(
    BuildContext context,
    Note note,
  ) async {
    int result = await databaseHelper.deleteNote(note.id);
    if (result != 0) {
      _showSnackBar(context, "Note Deleted Successully");
      updateListView();
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void navigateToDetail(
    Note note,
    String title,
  ) async {
    bool result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return NoteDetail(note, title);
    }));
    if (result == true) {
      updateListView();
    }
  }

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Note>> noteListFuture = databaseHelper.getNoteList();
      noteListFuture.then((noteList) {
        setState(() {
          this.noteList = noteList;
          this.count = noteList.length;
        });
      });
    });
  }
}
