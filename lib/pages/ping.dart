import 'package:flutter/material.dart';
import 'package:toy/vendors/ping/dart_ping.dart';

class PingPage extends StatefulWidget {
  const PingPage({Key? key}) : super(key: key);

  @override
  State<PingPage> createState() => _PingPageState();
}

class _PingPageState extends State<PingPage> {
  String std = '';
  void listenPing() {
    // Create ping object with desired args
    final ping = Ping('bilibili.com', count: 10);

    print('Running command: ${ping.command}');

    // Begin ping process and listen for output
    ping.stream.listen((event) {
      print(event);
      std += event.response.toString();
      std += '\n';
    });
  }

  @override
  void initState() {
    super.initState();

    listenPing();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [Text(std)],
        ),
      ),
    );
  }
}
