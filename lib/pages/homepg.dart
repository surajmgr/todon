// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
// import 'package:todon/models/notemdl.dart';
import 'package:todon/pages/notedetails.dart';
import 'package:todon/widgets/drawer.dart';

import 'package:todon/database/dbhelper.dart';
import 'package:todon/models/note.dart';

import 'dart:async';
import 'package:sqflite/sqflite.dart';

class HomePage extends StatefulWidget {
  // const HomePage({Key? key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Note>? noteList;
  int count = 0;

  var txt = "List of the Notes";
  @override
  Widget build(BuildContext context) {
    if (noteList == null) {
      noteList = <Note>[];
      updateListView();
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: Builder(
          builder: (context) => IconButton(
            onPressed: () => Scaffold.of(context).openDrawer(),
            icon: const Icon(
              Icons.auto_awesome,
              size: 25,
            ),
          ),
        ),
        title: Text(
          txt,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
        backgroundColor: const Color(0xFF0B0D0E),
        elevation: 0.0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search_sharp),
          )
        ],
      ),
      body: getNotesListView(),
      drawer: const MyDrawer(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(190, 12, 12, 12),
        onPressed: (() {
          navigateToDetails(Note('', '', '', 'In-Progress'), "Add Note");
        }),
        child: const Center(
          child: Icon(
            Icons.add,
            size: 35.0,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  ListView getNotesListView() {
    // TextStyle titleStyle = Theme.of(context).textTheme.subhead;

    return ListView.builder(
      itemCount: 0,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(40, 28, 40, 0),
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(13),
            ),
            color: Colors.white12,
            child: ListTile(
              leading: CircleAvatar(
                  backgroundColor: getStateColor(
                this.noteList![index].state,
              )),
              title: Text(
                this.noteList![index].title!,
                style: TextStyle(
                  // decoration: TextDecoration.underline,
                  // color: Colors.amberAccent,
                  fontFamily: 'EDU VIC',
                  fontSize: 28,
                  fontWeight: FontWeight.w400,
                ),
              ),
              subtitle: Text(
                this.noteList![index].description! + "\n",
                style: TextStyle(
                  color: Colors.white70,
                  fontFamily: 'Edu VIC',
                  fontSize: 20,
                  fontWeight: FontWeight.w300,
                ),
              ),
              trailing: GestureDetector(
                child: Icon(Icons.delete),
                onTap: () {
                  _delete(context, noteList![index]);
                },
              ),
              onTap: () {
                debugPrint("List Tile is tapped!");
                navigateToDetails(this.noteList![index], "Edit Note");
              },
            ),
          ),
        );
      },
    );
  }

  Color getStateColor(String? state) {
    switch (state) {
      case "In-Progress":
        return Colors.red;
        break;
      case "Completed":
        return Colors.green;
        break;
      default:
        return Colors.red;
    }
  }

  Object getStateIcon(String? state) {
    switch (state) {
      case "In-Progress":
        return Icon(Icons.check_circle_outlined);
        break;
      case "Completed":
        return Icon(Icons.check_circle_rounded);
        break;
      default:
        return Icon(Icons.check_circle_outlined);
    }
  }

  void _delete(BuildContext context, Note note) async {
    int? result = await databaseHelper.deleteNote(note.id!);
    //TODO update
    updateListView();
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void navigateToDetails(Note note, String title) async {
    bool result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return NoteDetails(note, title);
    }));

    if (result == true) {
      updateListView();
    }
  }

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initDatabase();
    dbFuture.then((database) {
      Future<List<Note>>? noteListFuture = databaseHelper.getNoteList();
      noteListFuture!.then((noteList) {
        setState(() {
          this.noteList = noteList;
          this.count = noteList.length;
        });
      });
    });
  }
}
