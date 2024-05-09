import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:async';

List<String> bossTimers = [
  "00:15",
  "02:00",
  "05:00",
  "09:00",
  "12:00",
  "14:00",
  "16:00",
  "19:00",
  "22:15",
  "23:15"
];

List<int> bossHoursTimers = [0, 02, 05, 09, 12, 14, 16, 19, 22, 23];

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

// This function is used for tests only

// Future playAudio(bool isPlaying, AudioPlayer audioPlayer) async {
//   if (isPlaying) {
//     await audioPlayer.play(AssetSource("Test.mp3"));
//   }
// }

Future playWelcomeBackAudio(AudioPlayer audioPlayer) async {
  await audioPlayer.play(AssetSource("welcome_back.m4a"));
}

Future stopAudio(bool isPlaying, AudioPlayer audioPlayer) async {
  if (!isPlaying) {
    await audioPlayer.stop();
  }
}

Icon isPlayingCheck(bool isPlaying) {
  return isPlaying ? Icon(Icons.volume_up) : Icon(Icons.volume_off);
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

Future sortAudioToPlay(AudioPlayer audioPlayer, bool isPlaying) async {
  if (isPlaying) {
    for (int i = 0; i < bossTimers.length; i++) {
      // The timer reads 29:59 - 14:59 - 04:59 which is basically 30 minutes and so on
      switch (calculateRemainingMinutes24(bossTimers[i])) {
        case 29:
          await audioPlayer
              .play(AssetSource("the_boss_will_spawn_in_30min_2.m4a"));
        case 14:
          await audioPlayer
              .play(AssetSource("the_boss_will_spawn_in_15min.m4a"));
        case 4:
          await audioPlayer.play(AssetSource("the_boss_will_spawn_soon.m4a"));
        default:
          break;
      }
    }
  }
}

int calculateRemainingMinutes24(String inputTime) {
  // Get the current local time
  DateTime now = DateTime.now();

  // Split the input time into hours and minutes
  List<String> parts = inputTime.split(':');
  int inputHours = int.parse(parts[0]);
  int inputMinutes = int.parse(parts[1]);

  // Convert the input time to a DateTime object using today's date
  DateTime inputDateTime =
      DateTime(now.year, now.month, now.day, inputHours, inputMinutes);

  // Calculate the difference in minutes between the current time and the input time
  Duration difference = inputDateTime.difference(now);

  // Convert the difference to minutes
  int remainingMinutes = difference.inMinutes;
  return remainingMinutes;
}

bool isCurrentHourLessThan(String inputHour) {
  // Get the current date and time
  DateTime now = DateTime.now();

  // Parse the input hour string to get the hour and minute components
  List<String> parts = inputHour.split(':');
  int inputHourInt = int.parse(parts[0]);
  int inputMinuteInt = int.parse(parts[1]);

  // Create a DateTime object for the input hour
  DateTime inputDateTime =
      DateTime(now.year, now.month, now.day, inputHourInt, inputMinuteInt);

  // Compare the current time with the input time
  if (now.isBefore(inputDateTime)) {
    print(inputDateTime);
    return true;
  }
  return false;
}

bool isCurrentHourGreaterThan() {
  // Get the current date and time
  DateTime now = DateTime.now();
  String inputHour = "23:15";

  // Parse the input hour string to get the hour and minute components
  List<String> parts = inputHour.split(':');
  int inputHourInt = int.parse(parts[0]);
  int inputMinuteInt = int.parse(parts[1]);

  // Create a DateTime object for the input hour
  DateTime inputDateTime =
      DateTime(now.year, now.month, now.day, inputHourInt, inputMinuteInt);

  // Compare the current time with the input time
  return now.isAfter(inputDateTime);
}

int getCurrentHour() {
  int currentHour = 0;
  DateTime now = DateTime.now();

  // Get the hour component from the DateTime object
  currentHour = now.hour;
  print(currentHour);
  return currentHour;
}

BoxDecoration setNextBossCell(int cellNumber) {
  if (getCurrentBossCellNumber() == cellNumber) {
    return BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            Color.fromARGB(10, 73, 173, 255),
            Color.fromARGB(76, 73, 173, 255)
          ], // Define your gradient colors
          center: Alignment.center, // Center of the gradient
          radius: 0.85, // Radius of the gradient
        ));
  }
  // return Color.fromARGB(29, 73, 173, 255);
  return BoxDecoration();
}

int getCurrentBossCellNumber() {
  // Get the current date and time
  DateTime now = DateTime.now();

  // Get the weekday as an integer (1 for Monday, 2 for Tuesday, ..., 7 for Sunday)
  int weekday = now.weekday;
  int weekLine = _getWeekdayPosition(weekday);
  for (int i = 0; i < bossTimers.length; i++) {
    if (isCurrentHourLessThan(bossTimers[i])) {
      return weekLine + i;
    }
  }

  if (isCurrentHourGreaterThan()) {
    return weekLine + 11;
  }
  return weekLine;
}

// Function to convert weekday integer to string representation
int _getWeekdayPosition(int weekday) {
  switch (weekday) {
    case 1:
      return 12;
    case 2:
      return 23;
    case 3:
      return 34;
    case 4:
      return 45;
    case 5:
      return 56;
    case 6:
      return 67;
    case 7:
      return 78;
    default:
      return 0;
  }
}
