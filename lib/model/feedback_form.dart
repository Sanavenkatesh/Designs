/// FeedbackForm is a data class which stores data fields of Feedback.
class FeedbackForm {
  String type;
  String feedback;

  FeedbackForm(this.type, this.feedback);

  factory FeedbackForm.fromJson(dynamic json) {
    return FeedbackForm(
        "${json['type']}",
        "${json['feedback']}"
    );
  }

  // Method to make GET parameters.
  Map toJson() => {
        'type': type,
        'feedback': feedback
      };
}
