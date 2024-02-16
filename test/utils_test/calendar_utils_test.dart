// Copyright 2024 Omkar Tapale. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:yearless_calendar/utils.dart';

void main() {
  final date = DateTime(2025, 11, 12);
  final dateSecond = DateTime(2024, 8);
  final dateLeapYear = DateTime(2024, 2);
  final dateNonLeapYear = DateTime(2023, 2);
  // leap year tests
  group('Calendar utility functions.', () {
    group('convertDateToCalendarMonth Tests:', () {
      test('Should return CalendarMonth instance in default en_US locale.', () {
        final calendarMonth = CalendarUtils.convertDateToCalendarMonth(date);
        expect(calendarMonth.name, 'November');
        expect(calendarMonth.monthNum, 11);
      });
      test('Should return CalendarMonth instance in fr_FR locale.', () {
        initializeDateFormatting('fr_FR', null).then((_) {
          final calendarMonth =
              CalendarUtils.convertDateToCalendarMonth(dateSecond, 'fr_FR');
          expect(calendarMonth.name, 'août');
          expect(calendarMonth.monthNum, 8);
        });
      });
      test(
          'Should return CalendarMonth instance with shortened month name in default en_US locale.',
          () {
        final calendarMonth =
            CalendarUtils.convertDateToCalendarMonth(dateSecond, null, true);
        expect(calendarMonth.name, 'Aug');
        expect(calendarMonth.monthNum, 8);
      });
      test(
          'Should return CalendarMonth instance with shortened month name in pt_BR locale.',
          () {
        initializeDateFormatting('pt_BR', null).then((_) {
          final calendarMonth = CalendarUtils.convertDateToCalendarMonth(
              dateSecond, 'pt_BR', true);
          expect(calendarMonth.name, 'ago.');
          expect(calendarMonth.monthNum, 8);
        });
      });
    });
    group('getDaysInMonth Tests:', () {
      test('Should return correct number of days in November.', () {
        final days = CalendarUtils.getDaysInMonth(date);
        expect(days, 30);
      });
      test('Should return correct number of days in August.', () {
        final days = CalendarUtils.getDaysInMonth(dateSecond);
        expect(days, 31);
      });
      test('Should return correct number of days in February for Leap Year.',
          () {
        final days = CalendarUtils.getDaysInMonth(dateLeapYear);
        expect(days, 29);
      });
      test(
          'Should return correct number of days in February for non Leap Year.',
          () {
        final days = CalendarUtils.getDaysInMonth(dateNonLeapYear);
        expect(days, 28);
      });
    });
    group('getYearMonths Tests:', () {
      test(
          'Should return list of CalendarMonth objects in default en_US locale.',
          () {
        final yearMonths = CalendarUtils.getYearMonths(date);
        expect(yearMonths.length, 12);
        expect(yearMonths[0].name, 'January');
        expect(yearMonths[0].monthNum, 1);
        expect(yearMonths[11].name, 'December');
        expect(yearMonths[11].monthNum, 12);
      });
      test(
          'Should return list of CalendarMonth objects with shortened month name in default en_US locale.',
          () {
        final yearMonths = CalendarUtils.getYearMonths(date, null, true);
        expect(yearMonths.length, 12);
        expect(yearMonths[0].name, 'Jan');
        expect(yearMonths[0].monthNum, 1);
        expect(yearMonths[11].name, 'Dec');
        expect(yearMonths[11].monthNum, 12);
      });

      test(
          'Should return list of CalendarMonth objects in default mr_IN locale.',
          () {
        initializeDateFormatting('mr_IN', null).then((_) {
          final yearMonths = CalendarUtils.getYearMonths(date, 'mr_IN', true);
          expect(yearMonths.length, 12);
          expect(yearMonths[0].name, 'जाने');
          expect(yearMonths[0].monthNum, 1);
          expect(yearMonths[11].name, 'डिसें');
          expect(yearMonths[11].monthNum, 12);
        });
      });
    });
    group('isSameDay Tests:', () {
      test('Should return true for same day.', () {
        final dateA = DateTime(2022);
        final dateB = DateTime(2022);
        final isSame = CalendarUtils.isSameDay(dateA, dateB);
        expect(isSame, true);
      });
      test('Should return false for different days.', () {
        final isSame = CalendarUtils.isSameDay(date, dateSecond);
        expect(isSame, false);
      });
    });
    group('isToday Tests:', () {
      test('Should return true for current day.', () {
        final date = DateTime.now();
        final today = CalendarUtils.isToday(date);
        expect(today, true);
      });
      test('Should return false for non-current date.', () {
        final today = CalendarUtils.isToday(dateNonLeapYear);
        expect(today, false);
      });
    });
  });
}
