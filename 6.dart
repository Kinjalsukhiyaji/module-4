//Listview with crud operation without database
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  List<String> _cityNames = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('City List'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _textEditingController,
            decoration: InputDecoration(labelText: 'Enter a Cityname'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _cityNames.add(_textEditingController.text);
                _textEditingController.clear();
              });
            },
            child: Text('Add to List'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _cityNames.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    _showNameDialog(_cityNames[index]);
                  },
                  onLongPress: () {
                    _showContextMenu(_cityNames[index], index);
                  },
                  child: ListTile(
                    title: Text(_cityNames[index]),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showNameDialog(String cityName) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Selected cityName'),
          content: Text(cityName),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showContextMenu(String cityName, int index) async {
    await Future.delayed(Duration(seconds: 2));

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Wrap(
          children: [
            ListTile(
              title: Text('Delete Item'),
              onTap: () {
                Navigator.pop(context);
                _showDeleteConfirmationDialog(cityName, index);
              },
            ),
            ListTile(
              title: Text('Edit Item'),
              onTap: () {
                Navigator.pop(context);
                _editItem(cityName, index);
              },
            ),
          ],
        );
      },
    );
  }

  void _showDeleteConfirmationDialog(String cityName, int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete Item'),
          content: Text('Are you sure you want to delete "$cityName"?'),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  _cityNames.removeAt(index);
                });
                Navigator.pop(context);
              },
              child: Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('No'),
            ),
          ],
        );
      },
    );
  }

  void _editItem(String oldCityName, int index) {
    _textEditingController.text = oldCityName;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Item'),
          content: TextField(
            controller: _textEditingController,
            decoration: InputDecoration(labelText: 'Edit the city name'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  _cityNames[index] = _textEditingController.text;
                  _textEditingController.clear();
                });
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }
}