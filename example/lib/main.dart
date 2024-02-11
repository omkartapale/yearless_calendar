// Copyright 2024 Omkar Tapale. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:yearless_calendar/yearless_calendar.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Yearless Calendar Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final calculator = Calculator();
    return Scaffold(
      appBar: AppBar(
        title: const Text('yearless_calendar example'),
        elevation: 4,
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Adds one to input values',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          ListTile(
            title: const Text('Calculate addOne on 2'),
            subtitle: Text('Answer is ${calculator.addOne(2)}'),
          ),
          ListTile(
            title: const Text('Calculate addOne on -7'),
            subtitle: Text('Answer is ${calculator.addOne(-7)}'),
          ),
          ListTile(
            title: const Text('Calculate addOne on 0'),
            subtitle: Text('Answer is ${calculator.addOne(0)}'),
          ),
        ],
      ),
    );
  }
}
