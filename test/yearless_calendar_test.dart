// Copyright 2024 Omkar Tapale. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter_test/flutter_test.dart';

import 'package:yearless_calendar/yearless_calendar.dart';

void main() {
  group('Calculator addOne Tests.', () {
    test('Adds 1 to 2, value should be 3', () {
      final calculator = Calculator();
      expect(calculator.addOne(2), 3);
    });
    test('Adds 1 to -7, value should be -6', () {
      final calculator = Calculator();
      expect(calculator.addOne(-7), -6);
    });
    test('Adds 1 to 0, value should be 1', () {
      final calculator = Calculator();
      expect(calculator.addOne(0), 1);
    });
  });
}
