// Copyright 2024 Omkar Tapale. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:yearless_calendar/utils.dart';
import 'package:yearless_calendar/yearless_calendar.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Yearless Calendar Demo',
      theme: ThemeData(
        colorSchemeSeed: const Color(0x9f4376f8),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late CalendarMonth? selectedMonth;

  @override
  void initState() {
    super.initState();

    // Init yearless calendar locale
    initializeDateFormatting();
    selectedMonth =
        CalendarUtils.convertDateToCalendarMonth(DateTime.now(), "mr_IN");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('yearless_calendar example'),
        elevation: 4,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Calendar Month Switcher',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            Text(
              'Same horizontal width'.toUpperCase(),
              style: Theme.of(context).textTheme.labelSmall,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                      child: Text(
                    selectedMonth!.name,
                    style: Theme.of(context).textTheme.headlineSmall,
                  )),
                  Expanded(
                    child: MonthSwitcher(
                      selectedMonth: selectedMonth,
                      locale: "mr",
                      onMonthChange: (month) => setState(() {
                        selectedMonth = month;
                      }),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 20.0),
            Text(
              'Fixed width aligned space between'.toUpperCase(),
              style: Theme.of(context).textTheme.labelSmall,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    selectedMonth!.name,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  SizedBox(
                    width: 170.0,
                    child: MonthSwitcher(
                      selectedMonth: selectedMonth,
                      locale: "mr",
                      onMonthChange: (month) => setState(() {
                        selectedMonth = month;
                      }),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 20.0),
            Text('Full width widget'.toUpperCase(),
                style: Theme.of(context).textTheme.labelSmall),
            const MonthSwitcher(),
            const Divider(height: 20.0),
            Text(
              'Fixed width widget'.toUpperCase(),
              style: Theme.of(context).textTheme.labelSmall,
            ),
            const SizedBox(
              width: 170.0,
              child: MonthSwitcher(),
            ),
          ],
        ),
      ),
    );
  }
}
