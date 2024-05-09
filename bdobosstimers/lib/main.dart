import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

List<String> cetTimeSchedule = [
  "CET",
  "00:15",
  "02:00",
  "05:00",
  "09:00",
  "12:00",
  "14:00",
  "16:00",
  "19:00",
  "22:15",
  "23:15",
  "Mon",
  "Katum\nKaranda",
  "Karanda",
  "Kzarka",
  "Kzarka",
  "Offin",
  "Garmoth",
  "Kutum",
  "Nouver",
  "Kzarka",
  "Garmoth",
  "Tue",
  "Karanda",
  "Kutum",
  "Kzarka",
  "Nouver",
  "Kutum",
  "Garmoth",
  "Nouver",
  "Karanda",
  "Quint\nMuraka",
  "Garmoth",
  "Wed",
  "Kzarka\nKutum",
  "Karanda",
  "Kzarka",
  "Karanda",
  "-",
  "Garmoth",
  "Kutum\nOffin",
  "Vell",
  "Karanda\nKzarka",
  "Garmoth",
  "Thu",
  "Nouver",
  "Kutum",
  "Nouver",
  "Kutum",
  "Nouver",
  "Garmoth",
  "Kzarka",
  "Kutum",
  "Quint\nMuraka",
  "Garmoth",
  "Fri",
  "Kzarka\nKaranda",
  "Nouver",
  "Karanda",
  "Kutum",
  "Karanda",
  "Garmoth",
  "Nouver",
  "Kzarka",
  "Kzarka\nKutum",
  "Garmoth",
  "Sat",
  "Karanda",
  "Offin",
  "Nouver",
  "Kutum",
  "Nouver",
  "Garmoth",
  "-",
  "Kzarka\nKaranda",
  "-",
  "-",
  "Sun",
  "Nouver\nKutum",
  "Kzarka",
  "Kutum",
  "Nouver",
  "Kzarka",
  "Garmoth",
  "Vell",
  "Garmoth",
  "Kzarka\nNouver",
  "Garmoth",
];

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BDO Boss Timers',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.dark(
          primary: Color.fromARGB(255, 31, 35, 74),
          secondary: Color.fromARGB(255, 89, 99, 182),
          onPrimary: Colors.white,
        ),
      ),
      home: const MyHomePage(
        title: "BDO Boss Timer",
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  @override
  void initState() {
    super.initState();
    playSong();
  }

  Future playSong() async {
    audioPlayer.play(AssetSource("Test.mp3"));
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.primary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: GridView.count(
          // Number of columns in the grid
          crossAxisCount: 11,
          // Number of rows in the grid
          childAspectRatio: 1.0,
          // Spacing between the items
          crossAxisSpacing: 50.0,
          // Padding around the grid
          padding: EdgeInsets.all(10.0),
          // List of widgets to display in the grid
          children: List.generate(cetTimeSchedule.length, (index) {
            return Center(
              child: Text(
                cetTimeSchedule[index],
                style: TextStyle(
                    fontSize: 16.0, color: colorSorter(cetTimeSchedule[index])),
              ),
            );
          })),
    );
  }
}

Color colorSorter(String name) {
  switch (name) {
    case "Kutum":
      return Colors.purple;
    case "Karanda":
      return Colors.blue;
    case "Kzarka":
      return Colors.red;
    case "Offin":
      return Colors.green;
    case "Garmoth":
      return Color.fromARGB(255, 207, 97, 88);
    case "Nouver":
      return Color.fromARGB(255, 216, 126, 69);
    case "Vell":
      return Color.fromARGB(255, 71, 193, 202);
    case "Quint\nMuraka":
      return Color.fromARGB(255, 216, 95, 129);
    default:
      return Colors.white;
  }
}

// Function to calculate remaining minutes from input time in a 24-hour format
int calculateRemainingMinutes24(String inputTime) {
  // Split the input time into hours and minutes
  List<String> parts = inputTime.split(':');
  int inputHours = int.parse(parts[0]);
  int inputMinutes = int.parse(parts[1]);

  // Total minutes in a day (24 hours)
  int totalMinutesInDay = 24 * 60;
  // Convert input time to minutes
  int totalInputMinutes = (inputHours * 60) + inputMinutes;
  // Calculate remaining minutes
  int remainingMinutes = totalMinutesInDay - totalInputMinutes;
  return remainingMinutes;
}
