import 'package:intl/intl.dart';

class Formatters {
  static final currency =
      NumberFormat.currency(symbol: 'KSh ', decimalDigits: 2);

  static String price(double value) => currency.format(value);
  static String percent(double value) => '${(value * 100).toStringAsFixed(0)}%';
}
