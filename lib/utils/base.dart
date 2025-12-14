import 'package:intl/intl.dart';

abstract class Base {
  static const String url = "http://127.0.0.1:8000";
  static getCustomFormattedDateTime(String givenDateTime, String dateFormat) {
    final DateTime docDateTime = DateTime.parse(givenDateTime);
    return DateFormat(dateFormat).format(docDateTime);
  }
}
