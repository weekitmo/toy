import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:toy/pages/home.dart';
import 'package:toy/pages/ping.dart';
import 'package:toy/vendors/ping/dart_ping_ios.dart';

void main() {
  DartPingIOS.register();
  runApp(App());
}

class App extends StatelessWidget {
  App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationProvider: _router.routeInformationProvider,
      routeInformationParser: _router.routeInformationParser,
      routerDelegate: _router.routerDelegate,
      title: 'Toy',
    );
  }

  final GoRouter _router = GoRouter(
    routes: <GoRoute>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const HomePage();
        },
      ),
      GoRoute(
        path: '/ping-page',
        builder: (BuildContext context, GoRouterState state) {
          return const PingPage();
        },
      ),
    ],
  );
}
