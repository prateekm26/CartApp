import 'package:cartapp/src/business_layer/util/helper/util_helper.dart';
import 'package:intl/intl.dart';

class DateTimeHelper {
  /// Method used to get date in this (Dec 8, 2022) format
  static String getDate(DateTime? date) {
    if (date == null) return "";
    DateFormat dateFormat = DateFormat.yMMMEd(UtilHelper.instance.languageCode);
    try {
      return dateFormat.format(date.toLocal());
    } catch (e) {
      return "";
    }
  }

  static String getDateFromString(String? date) {
    if (date == null) return "";
    DateTime dateTime = DateTime.parse(date);
    DateFormat dateFormat = DateFormat.yMMMEd(UtilHelper.instance.languageCode);
    try {
      return dateFormat.format(dateTime.toLocal());
    } catch (e) {
      return "";
    }
  }

  static String getDashboardDayAndDate(String? date) {
    if (date == null) return "";
    DateTime? dateTime = DateTime.tryParse(date)?.toLocal();
    if (dateTime == null) return "";
    return "${DateFormat.EEEE(UtilHelper.instance.languageCode).format(dateTime)}, ${DateFormat.MMMMd(UtilHelper.instance.languageCode).format(dateTime)}";
  }
}
