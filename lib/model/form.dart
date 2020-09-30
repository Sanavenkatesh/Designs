/// FeedbackForm is a data class which stores data fields of Feedback.
class DataForm {
  String type;
  String price;
  String image;


  DataForm(this.type, this.price, this.image);

  factory DataForm.fromJson(dynamic json) {
    return DataForm(
        "${json['type']}",
        "${json['price']}",
        "${json['image']}"
    );
  }

  // Method to make GET parameters.
  Map toJson() => {
        'type': type,
        'price': price,
        'image': image,
      };
}
