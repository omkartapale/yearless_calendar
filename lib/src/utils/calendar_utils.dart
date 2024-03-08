// Copyright 2024 Omkar Tapale. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import '../models/models.dart';
import 'calendar_formatter.dart';

/// A utility class that provides frequently used calendar functions.
abstract class CalendarUtils {
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

  /// Returns true if [year] is a leap year.
  ///
  /// This function implements the Gregorian calendar leap year rules wherein
  /// a year is a leap year if it is divisible by 4, except for years divisible
  /// by 100 but including years divisible by 400.
  ///
  /// References:
  ///
  /// - https://timeanddate.com/date/leapyear.html
  /// - https://wikihow.com/Calculate-Leap-Years
  /// - https://www.vedantu.com/maths/leap-year
  /// - https://en.wikipedia.org/wiki/Leap_year
  static bool isLeapYear(int year) {
    return (year % 4 == 0) && ((year % 100 != 0) || (year % 400 == 0));
  }

  /// Finds the nearest leap year.
  ///
  /// Accepts optional [year] parameter. If not provided year, defaults to the
  /// current year. Check if the requested [year] is a leap year and then return
  /// the year. Else returns the forthcoming leap year.
  ///
  /// This function assumes the use of the Gregorian calendar or the proleptic
  /// Gregorian calendar.
  static int nearestLeapYear([int? year]) {
    int lYear = year ?? DateTime.now().year;
    while (!isLeapYear(lYear)) {
      lYear++;
    }
    return lYear;
  }
}
