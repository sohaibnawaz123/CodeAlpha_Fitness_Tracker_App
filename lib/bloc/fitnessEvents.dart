// ignore_for_file: file_names, must_be_immutable

import 'package:equatable/equatable.dart';

abstract class Fitnessevents extends Equatable {
  const Fitnessevents();
  @override
  List<Object?> get props => [];
}

class AddCategory extends Fitnessevents {
  String catId;
  String catName;
  AddCategory({required this.catId, required this.catName});
  @override
  List<Object?> get props => [catId, catName];
}

class AddWorkout extends Fitnessevents {
  String excerciseName;
  String excerciseWeight;
  String excerciseSets;
  String excerciseReps;
  String excerciseId;
  String catId;
  AddWorkout({required this.excerciseId,required this.excerciseName,required this.excerciseWeight,required this.excerciseSets,required this.excerciseReps,required this.catId,});

  @override
  List<Object?> get props => [excerciseId,excerciseName,excerciseWeight,excerciseSets,excerciseReps,catId];
}
