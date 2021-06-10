import 'package:flutter/material.dart';
import 'package:to_do_list/MyApp.dart';

import 'AddToDo.dart';
import 'ToDoModel.dart';

class ToDoList extends StatefulWidget {
  @override
  createState() => new ToDoListState();
}

class ToDoListState extends State<ToDoList> {
  List<ToDoModel> todoItems = [];
  List<ToDoModel> chores = [];
  List<ToDoModel> work = [];
  List<ToDoModel> goals = [];
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('To Do List'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        height: screenHeight,
        width: screenWidth,
        color: Colors.white,
        child: SingleChildScrollView(
          primary: true,
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              Card(
                child: Column(
                  children: [
                    Text(
                      'Chores',
                      style: TextStyle(
                          fontSize: 30,
                          //fontStyle: FontStyle.italic,
                          color: Colors.green),
                    ),
                    getListView(chores),
                  ],
                ),
              ),
              Card(
                child: Column(
                  children: [
                    Text(
                      'Goals',
                      style: TextStyle(
                          fontSize: 30,
                          //fontStyle: FontStyle.italic,
                          color: Colors.deepOrange),
                    ),
                    getListView(goals),
                  ],
                ),
              ),
              Card(
                child: Column(
                  children: [
                    Text(
                      'Work',
                      style: TextStyle(
                          fontSize: 30,
                          //fontStyle: FontStyle.italic,
                          color: Colors.amber),
                    ),
                    getListView(work),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            ToDoModel toDoItem = await Navigator.of(context)
                .push(new MaterialPageRoute(builder: (context) => AddToDo()));
            if (toDoItem != null) {
              switch (toDoItem.listType) {
                case "Chores":
                  {
                    chores.add(toDoItem);
                    setState(() {});
                  }
                  break;
                case "Goals":
                  {
                    goals.add(toDoItem);
                    setState(() {});
                  }
                  break;
                case "Work":
                  {
                    work.add(toDoItem);
                    setState(() {});
                  }
                  break;
              }
            }
          },
          tooltip: 'Add task',
          child: Icon(Icons.add)),
    ));
  }

  removeTodoItem(int index) {
    setState(() {
      todoItems.removeAt(index);
    });
  }

  promptRemoveTodoItem(int index) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: new Text('Mark "${todoItems[index]}" as done?'),
              actions: <Widget>[
                FlatButton(
                    child: Text('CANCEL'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
                FlatButton(
                    child: Text('MARK AS DONE'),
                    onPressed: () {
                      removeTodoItem(index);
                      Navigator.of(context).pop();
                    })
              ]);
        });
  }

  getListView(List<ToDoModel> item) {
    return item.length > 0
        ? ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: item.length,
            itemBuilder: (context, index) {
              return boxContainer(item[index], index);
            },
          )
        : LayoutBuilder(builder: (ctx, constraints) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: screenHeight * 0.2,
                    child:
                        Image.asset('images/todolist.png', fit: BoxFit.cover),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'No tasks added yet...',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            );
          });
  }

  boxContainer(
    ToDoModel toDoList,
    int index,
  ) {
    return Dismissible(
      background: stackBehindDismiss(),
      key: ObjectKey(index),
      child: Container(
        //padding: EdgeInsets.all(20.0),
        child: InkWell(
            child: Card(
          margin: EdgeInsets.all(10),
          //height: screenHeight * 0.06,
          //width: screenWidth,
          color: toDoList.color,
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            ListTile(
              leading: CircleAvatar(
                child: Icon(Icons.backup_table),
              ),
              title: Text(
                toDoList.title,
                style: TextStyle(fontSize: 20),
              ),
              subtitle: Text(
                toDoList.date + toDoList.time,
              ),
              trailing: Icon(Icons.arrow_back),
            ),
          ]),
        )),
      ),
      onDismissed: (direction) {
        if (toDoList.listType == "Chores") {
          var item = chores.elementAt(index);
        } else if (toDoList.listType == "Goals") {
          var item = goals.elementAt(index);
        } else {
          var item = work.elementAt(index);
        }
        //To delete
        deleteItem(toDoList, index);
      },
    );
  }

  stackBehindDismiss() {
    return Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(right: 20.0),
      color: Colors.red,
      child: Icon(
        Icons.delete,
        color: Colors.white,
      ),
    );
  }

  void deleteItem(item, index) {
    setState(() {
      if (item.listType == "Chores") {
        chores.removeAt(index);
      } else if (item.listType == "Goals") {
        goals.removeAt(index);
      } else {
        work.removeAt(index);
      }
    });
  }
}
