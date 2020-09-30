import 'dart:convert' as convert;

import 'package:http/http.dart' as http;

import '../model/form.dart';

/// FormController is a class which does work of saving FeedbackForm in Google Sheets using
/// HTTP GET request on Google App Script Web URL and parses response and sends result callback.
class FormController {
  // Google App Script Web URL.
  static const String URL ="https://script.google.com/macros/s/AKfycbxLydBoPo6yN_bcpZz_rPAed3rzVLqeZkWL4tAX6a8XDjpE0d8/exec";

  // Success Status Message
  static const STATUS_SUCCESS = "SUCCESS";


  /// Async function which loads feedback from endpoint URL and returns List.
  Future<List<DataForm>> getDataList() async {
    return await http.get(URL).then((response) {
      var jsonFeedback = convert.jsonDecode(response.body) as List;
      return jsonFeedback.map((json) => DataForm.fromJson(json)).toList();
    });
  }
}
