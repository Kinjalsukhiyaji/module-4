import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Internet',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text('Internet Flutter Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                final web = Uri.parse(
                  'https://codoweb.com/',
                );
                if (await canLaunchUrl(web)) {
                  launchUrl(web);
                } else {
                  throw 'Could not launch $web';
                }
              },
              child: const Text('Web'),
            ),
            ElevatedButton(
              onPressed: () async {
                final email = Uri(
                  scheme: 'mailto',
                  path: 'kinjal.sukhiyaji12@gmail.com',
                  query: 'subject=Hello&body=Test',
                );
                if (await canLaunchUrl(email)) {
                  launchUrl(email);
                } else {
                  throw 'Could not launch $email';
                }
              },
              child: const Text('Email'),
            ),
            ElevatedButton(
              onPressed: () async {
                final call = Uri.parse('tel:+91 8141233169');
                if (await canLaunchUrl(call)) {
                  launchUrl(call);
                } else {
                  throw 'Could not launch $call';
                }
              },
              child: const Text('Call'),
            ),
            ElevatedButton(
              onPressed: () async {
                final sms = Uri.parse('sms:8141233169');
                if (await canLaunchUrl(sms)) {
                  launchUrl(sms);
                } else {
                  throw 'Could not launch $sms';
                }
              },
              child: const Text('SMS'),
            ),
          ],
        ),
      ),
    );
  }
}