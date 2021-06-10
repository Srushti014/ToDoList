import 'package:flutter/material.dart';
import 'package:to_do_list/ToDoList.dart';

double screenHeight;
double screenWidth;

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToDoList',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.indigo,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        //visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ToDoList(),
    );
  }
}

/*class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}*/

/*class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 5), () {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ToDoList(),
          ));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    */ /*Future.delayed(Duration(seconds: 5), () {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ToDoList(),
          ));
    });*/ /*
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Container(
      color: Colors.white,
      child: Image.asset("images/todolist.png"),
    );
  }
}*/

/// Note
/*class ToDoList extends StatefulWidget {
  @override
  _ToDoListState createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Material(
      child: Container(
        height: screenHeight,
        width: screenWidth,
        color: Colors.white,
        child: Column(
          children: [
            InkWell(
              child: Container(
                child: Text('Screen0'),
              ),
              onTap: () {
                print("Screen 0");
              },
            ),
            FlatButton(
              onPressed: () {
                print("Screen 1");
              },
              child: Text('Screeen1'),
            ),
            RaisedButton(
              onPressed: () {
                print("Screen 2");
              },
              child: Text('Screen2'),
            ),
            OutlineButton(
              onPressed: () {
                print("Screen 3");
              },
              child: Text('Screen3'),
            )
          ],
        ),
      ),
    );
  }
}*/
