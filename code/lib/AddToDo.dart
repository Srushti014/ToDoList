import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list/ToDoModel.dart';

import 'MyApp.dart';

class AddToDo extends StatefulWidget {
  @override
  _AddToDoState createState() => _AddToDoState();
}

class _AddToDoState extends State<AddToDo> {
  TextEditingController addTask = TextEditingController();
  TextEditingController desc = TextEditingController();
  List<String> todoItems = [];
  String dropdownValue = "Default";
  List<Color> colors = [
    Colors.black,
    Colors.green,
    Colors.red,
    Colors.yellow,
    Colors.amber,
    Colors.blueGrey,
    Colors.blue,
    Colors.blueAccent,
    Colors.pink,
    Colors.teal,
    Colors.purple,
    Colors.indigo
  ];
  Color selectedColor = Color(1);
  int indSel = -1;
  bool validate = true;
  String _selectedTime;
  String _selectedDate;
  bool isEditMode;

  @override
  void initState() {
    addTask.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: new Text('Add a new task')),
        body: Container(
          height: screenHeight,
          width: screenWidth,
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            primary: true,
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(children: [
              Card(
                margin: EdgeInsets.all(20),
                child: Row(
                  children: [
                    Text(
                      ' List Type:    ',
                      style: TextStyle(fontSize: 20),
                    ),
                    getDropDownMenu(),
                  ],
                ),
              ),
              getColorGridView(),
              Container(
                margin: EdgeInsets.fromLTRB(10, 30, 10, 30),
                child: TextField(
                  controller: addTask,
                  onSubmitted: (val) {
                    getDataOnPopup();
                  },
                  decoration: InputDecoration(
                      hintText: 'Enter Task Title...',
                      errorText: validate ? null : "Please enter Text.!!!",
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.all(16.0)),
                ),
              ),
              //Spacer(),
              Container(
                margin: EdgeInsets.fromLTRB(10, 30, 10, 30),
                child: TextField(
                  controller: desc,
                  onSubmitted: (val) {
                    getDataOnPopup();
                  },
                  decoration: InputDecoration(
                      hintText: 'Enter Task Description...!!!',
                      errorText: validate ? "Please enter Text.!!!" : null,
                      contentPadding: EdgeInsets.all(16.0)),
                ),
              ),
              Text(
                'Due date',
              ),
              TextFormField(
                onTap: () {
                  _pickUserDueDate();
                  _pickUserDueTime();
                },
                readOnly: true,
                decoration: InputDecoration(
                  hintText: _selectedDate == null
                      ? 'Provide your due date'
                      : _selectedDate.toString() + _selectedTime.toString(),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Due time',
              ),
              TextFormField(
                onTap: () {
                  // _pickUserDueTime();
                },
                readOnly: true,
                decoration: InputDecoration(
                  hintText: _selectedTime == null
                      ? 'Provide your due time'
                      : _selectedTime.toString(),
                ),
              ),

              //Spacer(),
              ElevatedButton(
                onPressed: () {
                  getDataOnPopup();
                },
                child: Text('Save!'),
              ),
            ]),
          ),
        ));
  }

  void _pickUserDueDate() {
    showDatePicker(
            context: context,
            initialDate: /*widget.isEditMode ? _selectedDate :*/ DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime(2030))
        .then((date) {
      if (date == null) {
        return;
      }
      date = date;
      setState(() {
        _selectedDate = date.toString();
      });
    });
    /*showTimePicker(
      context: context,
      initialTime: */ /*widget.isEditMode ? _selectedTime :*/ /* TimeOfDay.now(),
    ).then((time) {
      if (time == null) {
        return;
      }
      setState(() {
        _selectedTime = time.toString();
      });
    });*/
  }

  void _pickUserDueTime() {
    showTimePicker(
      context: context,
      initialTime: /*widget.isEditMode ? _selectedTime :*/ TimeOfDay.now(),
    ).then((time) {
      if (time == null) {
        return;
      }
      setState(() {
        _selectedTime = time.toString();
      });
    });
  }

  getDataOnPopup() {
    ToDoModel data = ToDoModel(
      title: addTask.text,
      desc: desc.text,
      listType: dropdownValue,
      color: selectedColor,
      date: _selectedDate,
      time: _selectedTime,
    );
    Navigator.pop(context, data);
    /*if (addTask.text.isEmpty || desc.text.isEmpty) {
      validate = false;
    } else {
      validate = true;
      if (dropdownValue == 'Default') {
        showAlertBox();
      } else {
        Navigator.pop(context, data);
      }
    }*/

    //if(dropdownValue != 'Default')
  }

  showAlertBox() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: new Text('Choose List Type.!!'),
              actions: <Widget>[
                FlatButton(
                    child: Text('Ok'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
              ]);
        });
  }

  getDropDownValue(LanguageEnum item) {
    switch (item) {
      case LanguageEnum.Default:
        return "Default";
        break;

      case LanguageEnum.Chores:
        return "Chores";
        break;

      case LanguageEnum.Goals:
        return "Goals";
        break;

      case LanguageEnum.Work:
        return "Work";
        break;

      default:
        return "Default";
    }
  }

  getDropDownMenu() {
    //dropdownValue = getDropDownValue(LanguageEnum.Default);
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.attachment),
      iconSize: 24,
      elevation: 16,
      style: TextStyle(color: Colors.black, fontSize: 20),
      underline: Container(
        height: 2,
        color: Colors.indigo,
      ),
      onChanged: (String newValue) {
        setState(() {
          dropdownValue = newValue;
        });
      },
      items: <String>[
        getDropDownValue(LanguageEnum.Default),
        getDropDownValue(LanguageEnum.Chores),
        getDropDownValue(LanguageEnum.Goals),
        getDropDownValue(LanguageEnum.Work),
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  getColorGridView() {
    return GridView.builder(
        padding: EdgeInsets.all(16),
        itemCount: colors.length,
        primary: false,
        shrinkWrap: true,
        //padding: const EdgeInsets.all(20),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 6,
        ),
        itemBuilder: (context, index) {
          return InkWell(
            focusColor: indSel == index ? Colors.amber : Colors.transparent,
            child: Container(
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                  color:
                      indSel == index ? Colors.amberAccent : Colors.transparent,
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              child: Card(
                color: colors[index],
                //decoration : Border.all(indSel == index ? Colors.amber : Colors.red);
              ),
            ),
            onTap: () {
              selectedColor = colors[index];
              indSel = index;
              setState(() {});
            },
          );
        });
  }
}

enum LanguageEnum {
  Default,
  Chores,
  Goals,
  Work,
}
