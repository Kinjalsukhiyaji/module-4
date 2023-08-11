import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sum App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => InputScreen(),
        '/sum': (context) => SumScreen(),
      },
    );
  }
}

class InputScreen extends StatefulWidget {
  @override
  _InputScreenState createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  TextEditingController _number1Controller = TextEditingController();
  TextEditingController _number2Controller = TextEditingController();

  void _calculateSum(BuildContext context) {
    int number1 = int.tryParse(_number1Controller.text) ?? 0;
    int number2 = int.tryParse(_number2Controller.text) ?? 0;
    int sum = number1 + number2;

    Navigator.pushNamed(
      context,
      '/sum',
      arguments: {'number1': number1, 'number2': number2, 'sum': sum},
    );
  }

  @override
  void dispose() {
    _number1Controller.dispose();
    _number2Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sum App')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _number1Controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Number 1'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _number2Controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Number 2'),
              ),
            ),
            ElevatedButton(
              onPressed: () => _calculateSum(context),
              child: Text('Calculate Sum'),
            ),
          ],
        ),
      ),
    );
  }
}

class SumScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final int number1 = arguments['number1'];
    final int number2 = arguments['number2'];
    final int sum = arguments['sum'];

    return Scaffold(
      appBar: AppBar(title: Text('Sum Result')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Number 1: $number1'),
            Text('Number 2: $number2'),
            SizedBox(height: 20),
            Text('Sum: $sum'),
          ],
        ),
      ),
    );
  }
}
