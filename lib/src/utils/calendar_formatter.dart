// Copyright 2024 Omkar Tapale. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:intl/intl.dart' show DateFormat;

/// A utility class that offers frequently used calendar formatting and parsing
/// functions based on the locale.
abstract class CalendarFormatter {
  /// Returns a string that represents a [date] formatted according to the
  /// specified [locale] and [format].
  static String customDateFormat(DateTime date,
      [String? format, String? locale]) {
    return DateFormat(format, locale).format(date);
  }

  /// Returns a string that represents a [date] formatted in the `dd/MM/yyyy`
  /// format and the specified [locale].
  static String fullDate(DateTime date, [String? locale]) {
    return DateFormat("dd/MM/yyyy", locale).format(date);
  }

  /// Returns the abbreviated name of month representing [date] in the
  /// specified [locale].
  static String monthShortName(DateTime date, [String? locale]) {
    return DateFormat("MMM", locale).format(date);
  }

  /// Returns the month's full name representing the [date] in the specified
  /// [locale].
  static String monthName(DateTime date, [String? locale]) {
    return DateFormat("MMMM", locale).format(date);
  }

  /// Returns the abbreviated name of a day based on the [date] and the
  /// specified [locale].
  static String dayShortName(DateTime date, [String? locale]) {
    return DateFormat("E", locale).format(date);
  }

  /// Returns the name of a day based on the [date] and the specified [locale].
  static String dayName(DateTime date, [String? locale]) {
    return DateFormat("EEEE", locale).format(date);
  }
}
