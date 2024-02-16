// Copyright 2024 Omkar Tapale. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import '../models/models.dart';
import 'calendar_formatter.dart';

/// A utility class that provides frequently used calendar functions.
abstract class CalendarUtils {
  /// Returns a list of [CalendarMonth] objects for the 12 months of the
  /// calendar year based on the [date] and the specified [locale].
  static List<CalendarMonth> getYearMonths(
    DateTime date, [
    String? locale,
    bool shortenedName = false,
  ]) {
    final List<CalendarMonth> months = [];
    for (int month = 1; month <= 12; month++) {
      months.add(
        CalendarMonth(
          name: shortenedName
              ? CalendarFormatter.monthShortName(
                  DateTime(date.year, month), locale)
              : CalendarFormatter.monthName(DateTime(date.year, month), locale),
          // name: CalendarFormatter.monthShortName(
          //     DateTime(date.year, month), locale),
          monthNum: month,
        ),
      );
    }
    return months;
  }

  /// Converts a [date] into a [CalendarMonth] object for a specific [locale].
  static CalendarMonth convertDateToCalendarMonth(
    DateTime date, [
    String? locale,
    bool shortenedName = false,
  ]) {
    return CalendarMonth(
      name: shortenedName
          ? CalendarFormatter.monthShortName(
              DateTime(date.year, date.month), locale)
          : CalendarFormatter.monthName(
              DateTime(date.year, date.month), locale),
      // name: CalendarFormatter.monthShortName(
      //     DateTime(date.year, date.month), locale),
      monthNum: date.month,
    );
  }

  /// Calculates the number of days in a month based on a specified [date].
  static int getDaysInMonth(DateTime date) {
    return DateUtils.getDaysInMonth(date.year, date.month);
  }

  /// Returns true if the two [DateTime] objects have the same day, month,
  /// and year.
  static bool isSameDay(DateTime dateA, DateTime dateB) {
    return DateUtils.isSameDay(dateA, dateB);
  }

  /// Returns whether a given [DateTime] object corresponds to the current date.
  static bool isToday(DateTime date) {
    DateTime now = DateTime.now();
    return isSameDay(now, date);
  }
}
