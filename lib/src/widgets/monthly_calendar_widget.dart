// Copyright 2024 Omkar Tapale. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import '../utils/calendar_utils.dart';
import '../widgets/day_widget.dart';

/// Signature for [MonthlyCalendar.onSelectedDateChanged].
///
/// The callback takes a [DateTime] instance representing the selected date
/// as a parameter.
///
/// Used by [YearlessCalendar] for detecting changes in the selected date.
typedef DateChangedCallback = void Function(DateTime selectedDate);

/// A widget class that renders calendar days for the specified the month.
///
/// Monthly Calendar widget shows a list of days for the requested month, using
/// [Day] widget to make available for user interaction.
///
/// The widget can be configured for leap year using [isLeapyear], which enables
/// extra leap day in the month of February. Other configurations like initial
/// [selectedDate], [month] to render days from, list of [disabledDates] and
/// [dayStructure] are available.
///
/// The optional callback [onSelectedDateChanged] can be configured to get the
/// new selected date when the selection is changed.
///
/// The day of month is represented with three main elements wiz. Day of Week,
/// Date, and Month name. As this widget is a part Yearless Calendar, so it is
/// engineered to display Day of Week with respect to current year.
///
/// If representation of Day of Week is enabled, it will show the day name
/// assuming requested for current year.
///
/// If a scenario where user's system is in the non-leap year and widget is
/// configured to show Day of Week and isLeapyear set to true then the day name
/// for 29th Feb (Leap day) will be of the nearest leap year, otherwise it will
/// show current year's Leap day name if isLeapyear set to true.
// If a scenario where app system is in non-leap year and widget is configured
// to show Day of Week and isLeapyear set to true then the day name for 29th Feb
// will be an empty string, otherwise it will show current year's 29th Feb day name.
class MonthlyCalendar extends StatefulWidget {
  /// A month to displays calendar days for.
  ///
  /// Example:
  /// ```dart
  /// MonthCalendar(
  ///   month: DateTime.february,
  /// )
  /// ```
  final int month;

  /// A boolean config to specify if the year is leap year or not.
  final bool isLeapyear;

  /// Initial selected date of the month.
  ///
  /// The date is marked as selected and identified on the basis of only date
  /// and month, regardless of its year, though it is of [DateTime] type.
  ///
  /// This is an optional property. If no date is supplied, widget will not
  /// mark or highlight any date as selected.
  final DateTime? selectedDate;

  /// List of dates those needs to be disabled.
  ///
  /// This will disable matching days for the supplied month regardless of its
  /// year. Means it will only validate for date and month of dates supplied
  /// in the list while rendering days for the requested month.
  ///
  /// This is an optional property. If no disabled dates are supplied then all
  /// dates in the calendar will be active and can be selected by user.
  final List<DateTime>? disabledDates;

  /// A locale code config used for formatting and parsing the date in the day
  /// widget.
  ///
  /// This property can be null. Defaults to en_US locale.
  final String? locale;

  /// Determines if the elements of day widget to be shown in landscape fashion
  /// i.e. horizontally.
  final bool isLandscape;

  /// A width value in [double] for day widget.
  ///
  /// This value will be constrained to height value if the [isLandscape] is
  /// set to true.
  final double dayWidth;

  /// A height value in [double] for day widget.
  ///
  /// This value will be constrained to width value if the [isLandscape] is
  /// set to true.
  final double dayHeight;

  /// A config that represents the structure to use for displaying the details
  /// of the selected day.
  final DayStructure dayStructure;

  /// Empty space to surround the widget.
  final EdgeInsetsGeometry? margin;

  /// The amount of space by which to inset the list of days.
  final EdgeInsetsGeometry? padding;

  /// Separator space between two dates.
  final double daySeparatorMargin;

  /// A optional callback that is invoked when the day is tapped, to report the
  /// change in the selected date.
  ///
  /// The callback takes a [DateTime] instance as its parameter, which represents
  /// the new selected date. It's preferred to use [DateChangedCallback] to get
  /// new selected date through a callback provided [DateTime] instance parameter.
  final DateChangedCallback? onSelectedDateChanged;

  /// Constructs a month calendar widget with the specified properties.
  const MonthlyCalendar({
    super.key,
    required this.month,
    this.isLeapyear = true,
    this.selectedDate,
    this.disabledDates,
    this.locale,
    this.margin = const EdgeInsets.all(8.0),
    this.padding,
    this.isLandscape = false,
    this.dayStructure = DayStructure.dayDateMonth,
    this.dayWidth = 60.0,
    this.dayHeight = 120.0,
    this.daySeparatorMargin = 8.0,
    this.onSelectedDateChanged,
  });

  // TODO: Assert selected Date for leap day if non-leap year.
  // If isLeapyear set to false and selected date supplied is 29th of Feb then
  // Invalid date. Non leap year\'s February have 28 days only.
  //
  // In production code, assertions are ignored, and the arguments to assert
  // aren’t evaluated.
  //
  // Ref:
  // * https://dart.dev/language/error-handling#assert
  // * https://stackoverflow.com/questions/57833399/whats-the-recommended-way-in-dart-asserts-or-throw-errors
  // * https://stackoverflow.com/questions/56537718/what-assert-do-in-dart

  // TODO: Dive into scenario where any of disabled dates matches selected date.
  //
  // Example: Right now if 29th feb is selected but also requested to disable,
  // then first time rendering the day will be shown selected. But when user
  // selects another day then the 29th feb Day will be disabled, user can't
  // select this day again. Which seems right behaviour.

  // TODO: Showing day name for leap day when system date in non-leap year.
  //
  // If user's device at the time of execution is in non-leap year but
  // configured to show leap year calendar, the leap day is shown for
  // nearest leap year. Here the day name will be shown according to that date
  // for respected leap year. But the other days will render day name with
  // respect to current year. This is making little bit disturbing view for
  // user.
  //
  // For case where system date is in leap year everything works perfectly.
  //
  // Example: System is in 2023 and widget configured to show leap year's
  // Feb's monthly calendar. So with current logic Day widgets will be rendered
  // correctly till 28th, for 29th day it will render leap day with 29/02/2024.
  // So here 28th day shows dayname 'Tue' and 29th day shows dayname 'Thu'
  // because it's from another year. Same when selected, SelectedDate will show
  // 'Thu, 29 Feb', which is not incorrect but little bit inconsistent view for
  // user as 28th is Thuesday and 29th is Thursday, then where is Wednesday.
  //
  // Here need to handle such events, as day names will be shown for current
  // year and this will result in flaw in yearless widget.
  //
  // Possible Resolution:
  // We can overrride requested date formatting option and use alternate
  // formatting function in Day and SelectedDate widget. Identify leap day to
  // indentify such events. If leap year is same as current system year then
  // render normally else use alternate date formatting function.
  // The preferrable format should be matching requested format only exclude
  // showing day.
  // If possible show year in Day widget instead of day name.
  //
  // But still with all these efforts and implementation it will provide
  // incosistent look, because all other Day widgets will show day name and but
  // the leap Day widget will not show day name or year displayed in place of
  // day name.

  @override
  State<MonthlyCalendar> createState() => _MonthlyCalendarState();
}

class _MonthlyCalendarState extends State<MonthlyCalendar> {
  late DateTime? _selectedDate;

  /// Get the day count for the month.
  int get _daysInMonth {
    // Return days for February with respect to leap year config.
    if (widget.month == DateTime.february) return widget.isLeapyear ? 29 : 28;

    // Return days for any other month.
    return CalendarUtils.getDaysInMonth(
        DateTime.now().copyWith(month: widget.month));
  }

  /// The nearest leap day.
  DateTime get _leapDay {
    final int leapyear = CalendarUtils.nearestLeapYear();
    return DateTime(leapyear, 2, 29);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin,
      height: widget.isLandscape ? widget.dayWidth : widget.dayHeight,
      child: ClipRRect(
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: widget.padding,
          itemBuilder: (context, index) {
            final DateTime currentDate;
            bool isDisabledDay = false;

            // Calculate and set leap day.
            //
            // Rendering days for Feb might need to calculate nearest leap year.
            // As the case may be current year is non-leap and widget set to
            // leapYear, then 29 feb will fail while displaying day, returning
            // selected day as callback value, and marking as selected or disabled.
            //
            // Reference: Leap year problem (Leap year bug)
            // https://en.wikipedia.org/wiki/Leap_year_problem
            // https://en.wikipedia.org/wiki/Time_formatting_and_storage_bugs

            // Seed current day as leap day only when
            // if configured for leap year and if current month is February and
            // if the iterated day is last day of the month.
            // Check iteration for leap day
            if (widget.isLeapyear &&
                widget.month == DateTime.february &&
                index == _daysInMonth - 1) {
              // seed currentDate as leap day.
              currentDate = _leapDay;
            } else {
              // seed normal day of month for current year.
              currentDate =
                  DateTime(DateTime.now().year, widget.month, index + 1);
            }

            // Check if current iterated day is marked as selected.
            final isSelectedDay = (_selectedDate != null)
                ? (_selectedDate!.month == currentDate.month &&
                    _selectedDate!.day == currentDate.day)
                : (DateTime.now().month == currentDate.month &&
                    DateTime.now().day == currentDate.day);

            // Check if current iterated day should be disabled.
            if (widget.disabledDates != null) {
              for (DateTime disabledDate in widget.disabledDates!) {
                if (disabledDate.month == currentDate.month &&
                    disabledDate.day == currentDate.day) {
                  isDisabledDay = true;
                  break;
                }
              }
            }

            return Day(
              key: Key('${currentDate.day}-${currentDate.month}'),
              date: currentDate,
              locale: widget.locale,
              isSelected: isSelectedDay,
              isDisabled: isDisabledDay,
              dayStructure: widget.dayStructure,
              isLandscape: widget.isLandscape,
              width: widget.dayWidth,
              height: widget.dayHeight,
              onPressed: () => {
                setState(() {
                  _selectedDate = currentDate;
                }),
                widget.onSelectedDateChanged?.call(currentDate),
              },
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(
              width: widget.daySeparatorMargin,
            );
          },
          itemCount: _daysInMonth,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.selectedDate;
  }
}
