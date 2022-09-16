import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: true,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                color: Colors.white,
              ),
            ),
            const Center(
              child: Text(
                'HomePage',
                style: TextStyle(fontSize: 10, color: Colors.black87),
              ),
            ),
            OutlinedButton(
              onPressed: () {
                GoRouter.of(context).go('/ping-page');
              },
              child: const Text(
                '测试网络延迟',
                style: TextStyle(fontSize: 10, color: Colors.black87),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
