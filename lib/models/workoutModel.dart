// ignore_for_file: file_names

class Workoutmodel {
  final String workoutId;
  final String workoutName;
  final String weight;
  final String sets;
  final String reps;
  final String catId;

  Workoutmodel(
      {required this.workoutId,
      required this.workoutName,
      required this.weight,
      required this.sets,
      required this.reps,
      required this.catId});

  Map<String, dynamic> toMap() {
    return {
      'workoutId': workoutId,
      'workoutName': workoutName,
      'weight': weight,
      'sets': sets,
      'reps': reps,
      'catId': catId,
    };
  }

  factory Workoutmodel.fromMap(Map<String, dynamic> json) {
    return Workoutmodel(
        workoutId: json['workoutId'],
        workoutName: json['workoutName'],
        weight: json['weight'],
        sets: json['sets'],
        reps: json['reps'],
        catId: json['catId']);
  }
}
