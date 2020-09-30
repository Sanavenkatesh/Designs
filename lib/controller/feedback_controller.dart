import 'dart:convert' as convert;

import 'package:Designs/model/feedback_form.dart';
import 'package:http/http.dart' as http;



class FeedbackController {
  // Google App Script Web URL.
  static const String URL ="https://script.google.com/macros/s/AKfycbzY-WORCh9SRZNvpwyLGiav0RypzN2yZ8yhJZL7qMwGSoqONCg/exec";

  // Success Status Message
  static const STATUS_SUCCESS = "SUCCESS";

  void submitForm(
      FeedbackForm feedbackForm, void Function(String) callback) async {
    try {
      await http.post(URL, body: feedbackForm.toJson()).then((response) async {
        if (response.statusCode == 302) {
          var url = response.headers['location'];
          await http.get(url).then((response) {
            callback(convert.jsonDecode(response.body)['status']);
          });
        } else {
          callback(convert.jsonDecode(response.body)['status']);
        }
      });
    } catch (e) {
      print(e);
    }
  }

  /// Async function which loads feedback from endpoint URL and returns List.
  // Future<List<FeedbackForm>> getFeedbackList() async {
  //   return await http.get(URL).then((response) {
  //     var jsonFeedback = convert.jsonDecode(response.body) as List;
  //     return jsonFeedback.map((json) => FeedbackForm.fromJson(json)).toList();
  //   });
  // }
}
