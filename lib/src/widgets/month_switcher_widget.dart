// Copyright 2024 Omkar Tapale. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import '../../utils.dart';

/// Signature for [MonthSwitcher.onChanged].
///
/// The callback takes an optional [CalendarMonth] instance representing the
/// selected month as a parameter.
///
/// Used by [YearlessCalendar] for detecting changes in the selected month.
typedef MonthChangedCallback = void Function(CalendarMonth? month);

/// A widget that displays selected month and buttons for switching through
/// previous or next month.
class MonthSwitcher extends StatefulWidget {
  /// A locale code config used for formatting and parsing the months.
  ///
  /// This property can be null. Defaults to en_US locale.
  final String? locale;

  /// The optional [CalendarMonth] object to current selected month for the
  /// switcher.
  ///
  /// Defaults to first month of year in specified locale.
  final CalendarMonth? selectedMonth;

  /// If non-null, the style to use for the month name.
  ///
  /// If the style's "inherit" property is true, the style will be merged with
  /// the closest enclosing [DefaultTextStyle]. Otherwise, the style will
  /// replace the closest enclosing [DefaultTextStyle].
  final TextStyle? style;

  /// The optional control to display the month name in shortened form.
  ///
  /// If this property is null or false, the full month name is shown based on
  /// specified locale otherwise, if true, the abbreviated month name is
  /// displayed.
  final bool? shortenedName;

  /// An optional callback that is invoked when the selected month changes, to
  /// report the change in the selected month.
  ///
  /// The callback takes an optional [CalendarMonth] instance as its parameter,
  /// which represents the new selected month. It's preferred to use
  /// [MonthChangedCallback] to get new selected month through a callback's
  /// [CalendarMonth] instance parameter.
  final MonthChangedCallback? onChanged;

  /// Constructs a month switcher widget with the specified properties.
  const MonthSwitcher({
    super.key,
    this.locale,
    this.selectedMonth,
    this.style,
    this.shortenedName,
    this.onChanged,
  });

  @override
  State<MonthSwitcher> createState() => _MonthSwitcherState();
}

class _MonthSwitcherState extends State<MonthSwitcher> {
  late List<CalendarMonth> _yearMonths = [];
  late int _currentMonth = 0;

  /// Getter method to detect current month is first month of year.
  bool get _isFirstMonth => _currentMonth == 0;

  /// Getter method to detect current month is last month of year.
  bool get _isLastMonth => _currentMonth == _yearMonths.length - 1;

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.horizontal,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          key: const Key('prevButton'),
          onPressed: () {
            if (_isFirstMonth) {
              return;
            }
            setState(() {
              _currentMonth--;
            });
            widget.onChanged?.call(_yearMonths[_currentMonth]);
          },
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: _isFirstMonth ? Theme.of(context).disabledColor : null,
          ),
        ),
        Expanded(
          child: Text(
            _yearMonths[_currentMonth].name,
            textAlign: TextAlign.center,
            style: widget.style,
            softWrap: false,
            overflow: TextOverflow.fade,
          ),
        ),
        IconButton(
          key: const Key('nextButton'),
          onPressed: () {
            if (_isLastMonth) {
              return;
            }
            setState(() {
              _currentMonth++;
            });
            widget.onChanged?.call(_yearMonths[_currentMonth]);
          },
          icon: Icon(
            Icons.arrow_forward_ios_rounded,
            color: _isLastMonth ? Theme.of(context).disabledColor : null,
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();

    // initialize months of calendar
    _yearMonths = CalendarUtils.getYearMonths(
        DateTime.now(), widget.locale, widget.shortenedName ?? false);
    // initialize current month according to selected month param
    _currentMonth = widget.selectedMonth != null
        ? ((widget.selectedMonth!.monthNum - 1))
        : 0;
  }
}
