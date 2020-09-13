import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ExamProvider(),
      child: MaterialApp(
        title: 'YourExam',
        theme: ThemeData(
          fontFamily: "Poppins",
          primarySwatch: Colors.grey,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: WelcomeScreen(),
        routes: {
          "/disclaimer": (context) => Disclaimer(),
          "/room": (context) => Room(),
          "/select": (context) => CourseSelection(),
        },
      ),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: _height,
        width: _width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Welcome to the new reading experience",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 40,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: _height * 0.25,
            ),
            GestureDetector(
              onTap: () => Navigator.of(context).pushNamed("/disclaimer"),
              child: CircleAvatar(
                radius: 30,
                backgroundColor: Colors.red,
                child: Icon(
                  Icons.chevron_right,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CourseSelection extends StatefulWidget {
  @override
  _CourseSelectionState createState() => _CourseSelectionState();
}

class _CourseSelectionState extends State<CourseSelection> {
  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: _height,
        width: _width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Select Degree Program",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Consumer<ExamProvider>(
              builder: (context, theprovider, child) {
                return DropdownButton(
                  value: theprovider.value,
                  items: theprovider.getCourses,
                  onChanged: (value) => theprovider.changeValue(value),
                  icon: Icon(
                    Icons.school_rounded,
                    color: Colors.black,
                  ),
                );
              },
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: _width * 0.5,
              decoration: BoxDecoration(
                color: Colors.black,
              ),
              child: MaterialButton(
                onPressed: () => Navigator.of(context).pushNamed(
                  "/room",
                ),
                minWidth: _width * 0.5,
                child: Text(
                  "Continue",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Room extends StatefulWidget {
  @override
  _RoomState createState() => _RoomState();
}

class _RoomState extends State<Room> {
  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return Consumer<ExamProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text(
              provider.stringCourses[provider.value],
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
          ),
          body: Stack(
            children: [
              Container(
                height: _height,
                width: _width,
              ),
            ],
          ),
        );
      },
    );
  }
}

class Disclaimer extends StatefulWidget {
  @override
  _DisclaimerState createState() => _DisclaimerState();
}

class _DisclaimerState extends State<Disclaimer> {
  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: _height,
        width: _width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Disclaimer",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            Image(
              image: AssetImage(
                "assets/images/undraw_online.png",
              ),
              height: _height * 0.3,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 20.0,
              ),
              child: Text(
                "Unfornately (or fortunate for some) this is not an online exam testing site. On this site you can only view past exam question papers according to your selection.",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: _width * 0.5,
              decoration: BoxDecoration(
                color: Colors.black,
              ),
              child: MaterialButton(
                onPressed: () => Navigator.of(context).pushReplacementNamed(
                  "/select",
                ),
                minWidth: _width * 0.5,
                child: Text(
                  "I understand",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ExamProvider extends ChangeNotifier {
  List stringCourses = [
    "Software Engineering",
    "Computer Science",
    "Information Technology",
    "Information Security And Assurance"
  ];

  List<DropdownMenuItem> initializeApp(List courseList) {
    List<DropdownMenuItem<dynamic>> courses = List();
    for (String item in courseList) {
      courses.add(
        DropdownMenuItem(
          value: courseList.indexOf(item),
          child: Text(item),
        ),
      );
    }
    return courses;
  }

  get getCourses => initializeApp(stringCourses);
  int _value = 0;
  changeValue(value) {
    _value = value;
    notifyListeners();
  }

  get value => _value;
}
