import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contador de Puntos',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: Colors.black,
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Contador de Puntos'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _points = 0;
  int _pointsPerSecond = 1;
  int _upgradeCost = 10;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      setState(() {
        _points += _pointsPerSecond;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _upgradePointsPerSecond() {
    if (_points >= _upgradeCost) {
      setState(() {
        _points -= _upgradeCost;
        _pointsPerSecond++;
        _upgradeCost = (_upgradeCost * 1.5).round(); // Increase cost for next upgrade
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Puntos:',
              style: TextStyle(fontSize: 24),
            ),
            Text(
              '$_points',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Puntos por segundo: $_pointsPerSecond',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: _points >= _upgradeCost ? _upgradePointsPerSecond : null,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
              child: Text('Mejorar (+1 p/s) - Costo: $_upgradeCost'),
            ),
          ],
        ),
      ),
    );
  }
}
