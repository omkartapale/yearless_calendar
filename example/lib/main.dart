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
        // brightness: Brightness.dark,
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
    const bool landscapeMode = false;
    const DayStructure dayStructure = DayStructure.dayDateMonth;
    late String? dayLocale;
    dayLocale = 'en';

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
                'Month Date Widget',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              height: 120,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Day(
                    date: DateTime.now().subtract(const Duration(days: 3)),
                    locale: dayLocale,
                    isLandscape: landscapeMode,
                    isDisabled: true,
                    dayStructure: dayStructure,
                    onDayPressed: () {},
                  ),
                  const SizedBox(width: 8.0),
                  Day(
                    date: DateTime.now().subtract(const Duration(days: 2)),
                    locale: dayLocale,
                    isLandscape: landscapeMode,
                    dayStructure: dayStructure,
                    onDayPressed: () {},
                  ),
                  const SizedBox(width: 8.0),
                  Day(
                    date: DateTime.now().subtract(const Duration(days: 1)),
                    locale: dayLocale,
                    isLandscape: landscapeMode,
                    isSelected: true,
                    dayStructure: dayStructure,
                    onDayPressed: () {},
                  ),
                  const SizedBox(width: 8.0),
                  Day(
                    date: DateTime.now(),
                    locale: dayLocale,
                    isLandscape: landscapeMode,
                    dayStructure: dayStructure,
                    onDayPressed: () {},
                  ),
                  const SizedBox(width: 8.0),
                  Day(
                    date: DateTime.now().add(const Duration(days: 1)),
                    locale: dayLocale,
                    isLandscape: landscapeMode,
                    dayStructure: dayStructure,
                    onDayPressed: () {},
                  ),
                  const SizedBox(width: 8.0),
                  Day(
                    date: DateTime.now().add(const Duration(days: 2)),
                    locale: dayLocale,
                    isLandscape: landscapeMode,
                    dayStructure: dayStructure,
                    onDayPressed: () {},
                  ),
                ],
              ),
            ),
            const Divider(height: 20.0),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Selected Date Widget',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            SelectedDate(
              date: DateTime(2024),
              locale: 'mr_IN',
            ),
            const SizedBox(height: 20.0),
            Text(
              'Display in a row with month switcher'.toUpperCase(),
              style: Theme.of(context).textTheme.labelSmall,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: SelectedDate(
                      // Known Bug / Limitation: Just for reference
                      //
                      // No worries as we are not changing selected date
                      // state on month switch. We'll show dates for changed
                      // month and once user selects one of those dates then
                      // only we'll update selected date state of widget.
                      //
                      // If less dates in changed month like switch from Jan 31
                      // to Feb or Jan 30 to Feb or March 31 to Apr.
                      //
                      // In such cases last date of changed month should be set.
                      //
                      // Create a function in utils that receives date, updated
                      // month and return first or last date of month param
                      // and validates date and return date in respect to params.
                      // And use this function to change date programmatically.
                      //
                      // date: DateTime(2024, 1, 31)
                      //     .copyWith(month: selectedMonth!.monthNum),
                      date: DateTime(2024, 2, 20)
                          .copyWith(month: selectedMonth!.monthNum),
                      locale: 'mr_IN',
                    ),
                  ),
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
            Text('Fluid full width widget'.toUpperCase(),
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
