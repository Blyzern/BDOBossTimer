import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:async';
import 'package:intl/intl.dart';

import 'variables_functions.dart';

void main() {
  runApp(const MyApp());
}

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
      home: MyHomePage(
        title: "BDO Boss Timer",
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title});

  final String title;
  final audioPlayer = AudioPlayer();

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isPlaying = true;
  String settings = defaultSettings;
  // Used to save Timer periodic in a variable and then use it
  // late Timer _timer;
  late String _lastMinute;

  @override
  void initState() {
    super.initState();
    // this is to avoid perma reloading or calling the function inside the builder so we make the instance of the callFunction
    _setSettings();
    _lastMinute = _getCurrentMinute();
    _startTimer();
  }

  Future _setSettings() async {
    settings = await runCheckSettings();
    setState(() {
      isPlaying = setIsPlaying(settings);
    });
    playWelcomeBackAudio(widget.audioPlayer, isPlaying);
  }

  void _startTimer() {
    Timer.periodic(Duration(seconds: 1), (Timer timer) {
      String currentMinute = _getCurrentMinute();
      if (currentMinute != _lastMinute) {
        // Minute has changed, call your function here
        sortAudioToPlay(widget.audioPlayer, isPlaying);
        setState(() {});
        _lastMinute = currentMinute;
      }
    });
  }

  String _getCurrentMinute() {
    return DateFormat('mm').format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          centerTitle: true,
          title: Text(widget.title),
          actions: [
            IconButton(
              padding: EdgeInsets.all(8.0),
              onPressed: () => {
                setState(() {
                  isPlaying ? isPlaying = false : isPlaying = true;
                  isPlaying
                      ? writeSetting("isPlaying=true;")
                      : writeSetting("isPlaying=false;");
                  if (!isPlaying) {
                    stopAudio(isPlaying, widget.audioPlayer);
                  }
                })
              },
              icon: isPlayingCheck(isPlaying),
            )
          ]),
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
            return Container(
              decoration: setNextBossCell(index),
              child: Center(
                child: Text(
                  cetTimeSchedule[index],
                  style: TextStyle(
                      fontSize: 16.0,
                      color: colorSorter(cetTimeSchedule[index])),
                ),
              ),
            );
          })),
    );
  }
}
