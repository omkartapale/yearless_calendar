// Copyright 2024 Omkar Tapale. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import '../../utils.dart';

/// A widget that displays selected date in specified formatting and parsing
/// based on the locale.
class SelectedDate extends StatelessWidget {
  /// The selected date of the month.
  final DateTime date;

  /// The formatter used to display the selected date in the widget.
  ///
  /// If not specified, defaults to [SelectedDateFormat.dayDate]
  final SelectedDateFormat format;

  /// If non-null, the style to be used for the selected date.
  ///
  /// If the style's "inherit" property is true, the style will be merged with
  /// the closest enclosing [DefaultTextStyle]. Otherwise, the style will
  /// replace the closest enclosing [DefaultTextStyle].
  final TextStyle? style;

  /// A locale code config used for formatting and parsing the selected date.
  ///
  /// This property can be null. Defaults to en_US locale.
  final String? locale;

  /// Constructs a selected date widget with the specified properties.
  const SelectedDate({
    super.key,
    required this.date,
    this.format = SelectedDateFormat.dayDate,
    this.style,
    this.locale,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      _getFormattedDate(),
      style: style ?? Theme.of(context).textTheme.headlineSmall,
    );
  }

  /// Returns formatted date representing the selected [date] with the
  /// specified [locale].
  String _getFormattedDate() {
    // TODO: Known Bug / Limitation:
    //
    // No worries as of now. We'll investigate further once we reach to
    // completion of final yearless calendar widget.
    //
    // What if user's device currently (at the time of execution of app) is in
    // non-leap year but selects to show leap year calendar for february month,
    // this will lead to provide wrong day name or wrong date, as we are planning
    // to show day according to current calendar year but dates according to
    // configured leap-year setting in yearless calendar widget.
    //
    // Here need to handle such events, as day names will be shown for current
    // year and this will result in flaw in yearless widget.
    //
    // Also we're going to create a configuration to control leap year setting in
    // main widget, which can also be used to check here.
    //
    // If we set date to 2023/02/29 which doesn't exist as non-leap year, and
    // used SelectedDateFormat, then the result will be 1 March.
    // It's changing the date as in parent as DateTime doesn't take this date
    // and adds 1 day to it so it becomes 1 March.
    //
    // Our expectation is to set day name to empty and provide formatted date.
    // We can overrride formatting function to check such event and alternate
    // formatting function for such case.
    //
    return CalendarFormatter.customDateFormat(
      date,
      format.pattern,
      locale,
    );
  }
}

/// Formatting options for selected date.
///
/// Available formats:
/// ```
/// Format Options      Output
/// date:               1 January
/// day:                Monday
/// dayDate:            Monday, 1 January (default)
/// dayShortDate:       Monday, 1 Jan
/// shortDate:          1 Jan
/// shortDay:           Mon
/// shortDayDate:       Mon, 1 January
/// shortDayShortDate:  Mon, 1 Jan
/// ````
enum SelectedDateFormat {
  /// Shows only the day of week representing selected date.
  ///
  /// e.g. `2024-02-01 00:00:00.000Z` will be formatted to `Thursday`.
  day("EEEE"),

  /// Shows only abbreviated name of a day of week representing selected date.
  ///
  /// e.g. `2024-02-01 00:00:00.000Z` will be formatted to `Thu`.
  shortDay("E"),

  /// Shows only date and month representing selected date as "date month" format.
  ///
  /// e.g. `2024-02-01 00:00:00.000Z` will be formatted to `1 February`.
  date('d MMMM'),

  /// Shows only date and abbreviated month representing selected date as
  /// "date month" format.
  ///
  /// e.g. `2024-02-01 00:00:00.000Z` will be formatted to `1 Feb`.
  shortDate('d MMM'),

  /// Shows the date representing selected date as "day, date month" format.
  ///
  /// e.g. `2024-02-01 00:00:00.000Z` will be formatted to `Thursday, 1 February`.
  dayDate("EEEE, d MMMM"),

  /// Shows the date representing the selected date that includes the day, date
  /// and an abbreviated version of the month, like "day, date month".
  ///
  /// e.g. `2024-02-01 00:00:00.000Z` will be formatted to `Thursday, 1 Feb`.
  dayShortDate("EEEE, d MMM"),

  /// Shows the date representing the selected date that includes an abbreviated
  /// version of the day of week, the date and month, like "day, date month".
  ///
  /// e.g. `2024-02-01 00:00:00.000Z` will be formatted to `Thu, 1 February`.
  shortDayDate("E, d MMMM"),

  /// Shows the date representing the selected date that includes an abbreviated
  /// version of the day of week, the date and an abbreviated version of the
  /// month, like "day, date month".
  ///
  /// e.g. `2024-02-01 00:00:00.000Z` will be formatted to `Thu, 1 Feb`.
  shortDayShortDate("E, d MMM");

  /// The formatter pattern string.
  final String pattern;

  /// Constructs a selected date format enum with formatter string.
  const SelectedDateFormat(this.pattern);
}
