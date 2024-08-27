// ignore_for_file: library_private_types_in_public_api, use_full_hex_values_for_flutter_colors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For formatting time

void main() {
  runApp(const DigitalClockApp());
}

class DigitalClockApp extends StatelessWidget {
  const DigitalClockApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Digital Clock',
      theme: ThemeData(
        // ignore: use_full_hex_values_for_flutter_colors
        primaryColor: const Color(0xFFF9381FF),
        // Other theme properties
      ),
      home: const DigitalClockPage(),
    );
  }
}

class DigitalClockPage extends StatefulWidget {
  const DigitalClockPage({super.key});

  @override
  _DigitalClockPageState createState() => _DigitalClockPageState();
}

class _DigitalClockPageState extends State<DigitalClockPage> {
  bool _is24HourFormat = false;
  late String _formattedTime;

  @override
  void initState() {
    super.initState();
    _formattedTime = _getCurrentTime();
    // Update the time every second
    _startClock();
  }

  void _startClock() {
    // Updates the time every second
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _formattedTime = _getCurrentTime();
        });
        _startClock();
      }
    });
  }

  String _getCurrentTime() {
    final DateTime now = DateTime.now();
    final DateFormat formatter =
        DateFormat(_is24HourFormat ? 'HH:mm:ss' : 'hh:mm:ss a');
    return formatter.format(now);
  }

  void _toggleTimeFormat(bool value) {
    setState(() {
      _is24HourFormat = value;
      _formattedTime = _getCurrentTime();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9381FF),
      appBar: AppBar(
        title: const Text('Digital Clock'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _getCurrentDate(),
              style: const TextStyle(
                fontSize: 24,
                color: Colors.black, // Ensure good contrast with the background
              ),
            ),
            const SizedBox(height: 10),
            Text(
              _formattedTime,
              style: const TextStyle(
                fontSize: 54,
                fontWeight: FontWeight.bold,
                color: Colors.black, // Ensure good contrast with the background
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  '24-Hour Format',
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
                Switch(
                  value: _is24HourFormat,
                  onChanged: _toggleTimeFormat,
                  activeColor: Colors.black, // Match switch color to the theme
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

String _getCurrentDate() {
  final DateTime now = DateTime.now();
  final DateFormat formatter = DateFormat('EEEE, MMMM d, yyyy');
  return formatter.format(now);
}
