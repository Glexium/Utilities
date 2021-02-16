import 'package:intl/intl.dart';
import 'package:universal_io/prefer_universal/io.dart';

class DateUtil {
  static String getUSToLocalDate(String value) {
    if (value == "") return "0";
    DateTime date = DateFormat("yyyy-MM-dd").parse(value).toLocal();
    String localFormat = localFormatWithoutHour();
    return DateFormat(localFormat).format(date); //date!=null?sdf.format(date):"0";
  }

  static String getUSDate(String value) {
    if (value == "") return "0";
    DateTime date = DateFormat("yyyy-MM-dd").parse(value).toLocal();
    return DateFormat("yyyy-MM-dd").format(date); //date!=null?sdf.format(date):"0";
  }

  static String getDateFormatted(String value, {String localFormatVal, String locale, bool ignoreTCheck=false}) {
    if (value == '' || value == 'null' || value == '0000-00-00 00:00:00')
      return '0';
    DateTime dateFormatted;
    if (!ignoreTCheck && value.toLowerCase().contains("t"))
      dateFormatted = DateFormat("yyyy-MM-ddTHH:mm:ss").parse(value);
    else
      dateFormatted = DateFormat("yyyy-MM-dd HH:mm:ss").parse(value);
    String format = localFormatVal??localFormat();
    return DateFormat(format, locale??getLocale()).format(dateFormatted);
  }

  static String getDay(String value, {String locale, bool ignoreTCheck=false}) {
    if (value == '' || value == 'null' || value == '0000-00-00 00:00:00')
      return '0';
    DateTime dateFormatted;
    if (!ignoreTCheck && value.toLowerCase().contains("t"))
      dateFormatted = DateFormat("yyyy-MM-ddTHH:mm:ss").parse(value);
    else
      dateFormatted = DateFormat("yyyy-MM-dd HH:mm:ss").parse(value);
    return DateFormat('dd', locale??getLocale()).format(dateFormatted);
  }

  static String getDateNowWithoutHour() {
    var now = DateTime.now();
    var dateFormatted = DateFormat("yyyy-MM-dd").format(now);
    return dateFormatted;
  }

  static String getDateNowUTC() {
    var now = DateTime.now();
    var dateFormatted = DateFormat("yyyy-MM-ddTHH:mm").format(now);
    return dateFormatted;
  }

  static String subtractDateFromNow(int days) {
    DateTime date = DateTime.now().subtract(new Duration(days: days));
    var dateFormatted = DateFormat("yyyy-MM-ddTHH:mm").format(date);
    return dateFormatted;
  }

  static String subtractDaysFromNowWithoutHour(int days) {
    DateTime date = DateTime.now().subtract(Duration(days: days));
    var dateFormatted = DateFormat("yyyy-MM-dd").format(date);
    return dateFormatted;
  }

  String subtractFromNowWithoutHour({int years, int months, int days, bool dayOne, bool monthOne}) {
    var date = DateTime.now();
    int day = dayOne==true?1:date.day-days??0;
    int month = monthOne==true?1:date.month - (months??0);
    var newDate = new DateTime(date.year-(years??0), month, day);
    var dateFormatted = DateFormat("yyyy-MM-dd").format(newDate);
    return dateFormatted;
  }

  static String getFullDateFormatted(String value) {
    if (value == "") return "0";
    DateTime date =
    new DateFormat("yyyy-MM-dd HH:mm:ss").parse(value).toLocal();
    return date != null ? date.toString() : "0";
  }

  static String getDateTextFormatted(DateTime date) {
    String pattern = getLocale() == 'en_us'
        ? 'EEE MMMM dd yyyy, HH:mm:ss'
        : 'EEE dd MMMM yyyy, HH:mm:ss';
    return DateFormat(pattern, getLocale()).format(date);
  }

  static DateTime convertToDateFormat(String dateTime) {
    return DateFormat("yyyy-MM-dd HH:mm:ss").parse(dateTime);
  }

  static int lastDayOfTheMonth()
  {
    var now = new DateTime.now(); // Find the last day of the month.
    var lastDayDateTime = (now.month < 12) ? new DateTime(now.year, now.month + 1, 0) : new DateTime(now.year + 1, 1, 0);
    return lastDayDateTime.day;
  }

  static String getLocale() {
    String country;
    if (Platform.localeName.length < 4)
      country = "en_us";
    else if(Platform.isAndroid || Platform.isIOS) {
      String languageCode = Platform.localeName.split('_')[0];
      String countryCode = Platform.localeName.split('_')[1];
      country = (languageCode + "_" + countryCode).toLowerCase();
    }
    else
      return Platform.localeName;
    return country;
  }

  static String localFormat() {
    switch (getLocale()) {
      case "en_us":
        return "yyyy-MM-dd HH:mm:ss";
      case "es-419":
      case "es_mx":
      case "de_de":
      default:
        return "dd-MM-yyyy HH:mm:ss";
    }
  }

  static String localFormatWithoutHour() {
    switch (getLocale()) {
      case "en_us":
        return "yyyy-MM-dd";
      case "es_mx":
      case "de_de":
      default:
        return "dd-MM-yyyy";
    }
  }
}
