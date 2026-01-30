# colaxy_adaptive_scaffold

[![GitHub](https://img.shields.io/github/license/normidar/colaxy_adaptive_scaffold.svg)](https://github.com/normidar/colaxy_adaptive_scaffold/blob/main/LICENSE)
[![pub package](https://img.shields.io/pub/v/colaxy_adaptive_scaffold.svg)](https://pub.dartlang.org/packages/colaxy_adaptive_scaffold)
[![GitHub Stars](https://img.shields.io/github/stars/normidar/colaxy_adaptive_scaffold.svg)](https://github.com/normidar/colaxy_adaptive_scaffold/stargazers)
[![Twitter](https://img.shields.io/twitter/url/https/twitter.com/normidar.svg?style=social&label=Follow%20%40normidar)](https://twitter.com/normidar)
[![Github-sponsors](https://img.shields.io/badge/sponsor-30363D?logo=GitHub-Sponsors&logoColor=#EA4AAA)](https://github.com/sponsors/normidar)

A simple adaptive scaffold that switches between a `NavigationBar` (bottom) and a `NavigationRail` (side) based on screen width.

## Features

- **Adaptive Navigation**: Automatically switches between `BottomNavigationBar` and `NavigationRail`.
- **Simple API**: Easy to drop in as a replacement for standard `Scaffold` when you need navigation.
- **Customizable Breakpoint**: Define when the switch happens.

## Getting Started

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  colaxy_adaptive_scaffold:
    git:
      url: https://github.com/normidar/colaxy_adaptive_scaffold.git
```

## Usage

```dart
import 'package:flutter/material.dart';
import 'package:colaxy_adaptive_scaffold/colaxy_adaptive_scaffold.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
      selectedIndex: _selectedIndex,
      onDestinationSelected: (index) {
        setState(() {
          _selectedIndex = index;
        });
      },
      destinations: const [
        NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
        NavigationDestination(icon: Icon(Icons.settings), label: 'Settings'),
      ],
      body: Center(
        child: Text('Selected Index: $_selectedIndex'),
      ),
    );
  }
}
```
