// Copyright 2024 Omkar Tapale. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import '../../utils.dart';

/// Create a widget that can display details of a single day for a given date.
///
/// A day widget can configured as selected or disabled and can restructured
/// for day details structure.
///
/// The [height] and [width] can also adjusted. The details can displayed in a row
/// or column form with configurable [isLandscape] mode.
///
/// A callback can configured with [onDayPressed] void callback.
class Day extends StatelessWidget {
  /// The date of the month that to be displayed in the day widget.
  final DateTime date;

  /// A locale code config used for formatting and parsing the date in the day
  /// widget.
  ///
  /// This property can be null. Defaults to en_US locale.
  final String? locale;

  /// A boolean value that determines whether a specific day is selected or not.
  ///
  /// This property can be null. Defaults to false.
  final bool isSelected;

  /// A boolean value that determines whether a specific day is disabled for user
  /// selection or not.
  ///
  /// This property can be null. Defaults to false.
  final bool isDisabled;

  /// A callback function that is called when the day widget is pressed.
  final VoidCallback onDayPressed;

  /// A boolean config to define if the elements of day widget to be shown in
  /// landscape fashion i.e. in a row.
  final bool isLandscape;

  /// A config that represents the structure to use for displaying the details
  /// of the selected day.
  final DayStructure dayStructure;

  /// A width value in [double] for day widget.
  ///
  /// This value will be constrained to height value if the [isLandscape] is
  /// set to true.
  final double width;

  /// A height value in [double] for day widget.
  ///
  /// This value will be constrained to width value if the [isLandscape] is
  /// set to true.
  final double height;

  /// Constructs a day widget with the specified properties.
  const Day({
    super.key,
    required this.date,
    this.locale,
    this.isSelected = false,
    this.isDisabled = false,
    this.dayStructure = DayStructure.dayDateMonth,
    this.isLandscape = false,
    this.width = 60.0,
    this.height = 120.0,
    required this.onDayPressed,
  });

  @override
  Widget build(BuildContext context) {
    // Check if the specified date is today.
    final isToday = CalendarUtils.isToday(date);

    // Adjust width and height according to lanscape mode.
    final double iWidth = isLandscape ? height : width;
    final double iHeight = isLandscape ? width : height;

    // Get the default BoxDecoration.
    BoxDecoration dayDecoration = _getDefaultDayDecoration(context);

    return InkWell(
      // If a day marked as disabled, then it should not be clickable.
      onTap: isDisabled ? null : onDayPressed,

      // splashColor: Theme.of(context).splashColor,
      // highlightColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(16),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: iWidth,
        height: iHeight,
        // margin: margin,
        decoration: dayDecoration,
        clipBehavior: Clip.hardEdge,
        child: _buildDayStructure(
          structure: dayStructure,
          isLandscape: isLandscape,
          isToday: isToday,
          context: context,
        ),
      ),
    );
  }

  /// Builds the structure of a day widget based on the selected [dayStructure].
  ///
  /// Depending on [isLandscape] mode, this method returns a [Column] or [Row]
  /// widget that contains the appropriate details for the date.
  Widget _buildDayStructure({
    required BuildContext context,
    required DayStructure structure,
    bool isLandscape = false,
    required bool isToday,
  }) {
    List<Widget> items = [];
    switch (structure) {
      case DayStructure.dateOnly:
        items = [
          _getDateElement(isToday, context),
        ];
        break;
      case DayStructure.dateDay:
        items = [
          _getDateElement(isToday, context),
          const SizedBox(
            width: 4.0,
          ),
          _getDayElement(isToday, context),
        ];
        break;
      case DayStructure.dayDate:
        items = [
          _getDayElement(isToday, context),
          const SizedBox(
            width: 4.0,
          ),
          _getDateElement(isToday, context),
        ];
        break;
      case DayStructure.dayDateMonth:
        items = [
          _getDayElement(isToday, context),
          _getDateElement(isToday, context),
          _getMonthElement(isToday, context),
        ];
        break;
      default:
        items = [
          _getMonthElement(isToday, context),
          _getDateElement(isToday, context),
          _getDayElement(isToday, context),
        ];
    }

    // Check if the day widget contains the day name, number, and month for the
    // supplied date concerning the selected DayStructure, and set the
    // mainAxisAlignment for the row or column accordingly.
    bool notDisplayedAllElements = (structure == DayStructure.dateDay ||
        structure == DayStructure.dayDate);

    return isLandscape
        ? Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: notDisplayedAllElements
                ? MainAxisAlignment.center
                : MainAxisAlignment.spaceEvenly,
            children: items,
          )
        : Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: notDisplayedAllElements
                ? MainAxisAlignment.center
                : MainAxisAlignment.spaceEvenly,
            children: items,
          );
  }

  /// Builds a widget that displays the day of the month only for a specified
  /// date in the day widget.
  Widget _getDateElement(bool isToday, BuildContext context) {
    final theme = Theme.of(context);
    final textStyle = theme.textTheme.headlineLarge!;

    // Selected day text style.
    final selectedDayNumStyle = textStyle.copyWith(
      fontWeight: FontWeight.bold,
      color: theme.colorScheme.onPrimaryContainer,
    );

    // Default day text style.
    final defaultDayNumStyle = textStyle;

    // Today's text style.
    final todayNumStyle =
        textStyle.copyWith(color: theme.colorScheme.primaryContainer);

    // Disabled day text style.
    final disabledNumStyle = textStyle.copyWith(color: theme.disabledColor);

    // Set default day text style.
    TextStyle dayNumStyle = defaultDayNumStyle;

    if (isSelected) {
      dayNumStyle = selectedDayNumStyle;
    } else if (isDisabled) {
      dayNumStyle = disabledNumStyle;
    } else if (isToday) {
      dayNumStyle = todayNumStyle;
    }

    return Flexible(
      child: FittedBox(
        alignment: Alignment.center,
        fit: BoxFit.scaleDown,
        child: Text(
          key: const Key('dateElementText'),
          CalendarFormatter.customDateFormat(date, 'dd', locale),
          style: dayNumStyle,
        ),
      ),
    );
  }

  /// Builds a widget that displays the abbreviated name of the day of the week
  /// for a specified date in the day widget.
  Widget _getDayElement(bool isToday, BuildContext context) {
    final theme = Theme.of(context);
    final textStyle = theme.textTheme.bodyMedium!;

    // Selected day text style.
    final selectedDayStrStyle =
        textStyle.copyWith(color: theme.colorScheme.onPrimaryContainer);

    // Default day text style.
    final defaultDayStrStyle = textStyle.copyWith(color: theme.hintColor);

    // Today's text style.
    final todayStrStyle =
        textStyle.copyWith(color: theme.colorScheme.primaryContainer);

    // Disabled day text style.
    final disabledStrStyle = textStyle.copyWith(color: theme.disabledColor);

    // Set default day text style.
    TextStyle dayStrStyle = defaultDayStrStyle;

    if (isSelected) {
      dayStrStyle = selectedDayStrStyle;
    } else if (isDisabled) {
      dayStrStyle = disabledStrStyle;
    } else if (isToday) {
      dayStrStyle = todayStrStyle;
    }

    return Flexible(
      child: FittedBox(
        alignment: Alignment.center,
        fit: BoxFit.scaleDown,
        child: Text(
          key: const Key('dayElementText'),
          CalendarFormatter.dayShortName(date, locale).toUpperCase(),
          style: dayStrStyle,
        ),
      ),
    );
  }

  /// The default decoration for the day widget.
  ///
  /// Returns a [BoxDecoration] instance with the appropriate default properties.
  BoxDecoration _getDefaultDayDecoration(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    // final isDarkTheme =
    //     MediaQuery.of(context).platformBrightness == Brightness.dark;

    // Check if the specified date is today.
    final isToday = CalendarUtils.isToday(date);

    // Get a default color that should be used to highlight today.
    // final todayHighlightColor =
    //     isDarkTheme ? theme.inversePrimary : theme.onPrimaryContainer;
    final todayHighlightColor = theme.onPrimaryContainer;

    // Hide the border if the date is selected or today.
    final hideBorder = isSelected || isToday;

    return BoxDecoration(
      // Use the default background color for the selected date or the highlight
      // color for today, otherwise no background color.
      color: isSelected
          // ? isDarkTheme
          //     ? theme.onPrimaryContainer
          //     : theme.inversePrimary
          ? theme.inversePrimary
          : (isToday ? todayHighlightColor : null),

      borderRadius: BorderRadius.circular(16.0),

      // Hide the border or use the border color otherwise.
      border: hideBorder ? null : Border.all(color: theme.onInverseSurface),
    );
  }

  /// Builds a widget that displays the abbreviated month name for a specified
  /// date in the day widget.
  Widget _getMonthElement(bool isToday, context) {
    final theme = Theme.of(context);
    final textStyle = theme.textTheme.bodyMedium!;
    // final isDarkTheme =
    //     MediaQuery.of(context).platformBrightness == Brightness.dark;

    // Selected day text style.
    final selectedMonthStrStyle = textStyle.copyWith(
      color: theme.colorScheme.onPrimaryContainer,
      // color: isDarkTheme
      //     ? theme.colorScheme.primaryContainer
      //     : theme.colorScheme.onPrimaryContainer,
    );

    // Default day text style.
    final defaultMonthStrStyle = textStyle.copyWith(color: theme.hintColor);

    // Today's text style.
    final todayMonthStrStyle = textStyle.copyWith(
      color: theme.colorScheme.primaryContainer,
      // color: isDarkTheme
      //     ? theme.colorScheme.onPrimaryContainer
      //     : theme.colorScheme.primaryContainer,
    );

    // Disabled day text style.
    final disabledMonthStrStyle =
        textStyle.copyWith(color: theme.disabledColor);

    // Set default day text style.
    TextStyle monthStyle = defaultMonthStrStyle;

    if (isSelected) {
      monthStyle = selectedMonthStrStyle;
    } else if (isDisabled) {
      monthStyle = disabledMonthStrStyle;
    } else if (isToday) {
      monthStyle = todayMonthStrStyle;
    }

    return Flexible(
      child: FittedBox(
        alignment: Alignment.center,
        fit: BoxFit.scaleDown,
        child: Text(
          key: const Key('monthElementText'),
          CalendarFormatter.monthShortName(date, locale).toUpperCase(),
          style: monthStyle,
        ),
      ),
    );
  }
}

/// The possible placements of elements of a date used to display as a day.
///
/// An enumeration that defines the possible structures of a date for displaying
/// a day widget.
enum DayStructure {
  /// Displays the day of the month followed by the abbreviated name of the day
  /// of the week. Example: "26 Mon".
  dateDay,

  /// Displays the day of the month only. Example: "26".
  dateOnly,

  /// Displays the abbreviated name of the day of the week followed by the day
  /// of the month. Example: "Mon 26".
  dayDate,

  /// Displays the abbreviated name of the day of the week, the day of the
  /// month, and the month's abbreviated name. Example: "Mon 26 Feb".
  dayDateMonth,

  /// Display the abbreviated month name, day of the month, and abbreviated day
  /// of the week. Example: "Feb 26 Mon".
  monthDateDay,
}
