// ignore_for_file: file_names

class Fitnesscategorymodel {
  final String catId;
  final String catName;
  final dynamic createdAt;

  Fitnesscategorymodel(
      {required this.catId, required this.catName, required this.createdAt});

  Map<String, dynamic> tomap() {
    return {'catId': catId, 'catName': catName, 'createdAt': createdAt};
  }

  factory Fitnesscategorymodel.fromMap(Map<String, dynamic> json) {
    return Fitnesscategorymodel(
        catId: json['catId'],
        catName: json['catName'],
        createdAt: json['createdAt']);
  }
}
