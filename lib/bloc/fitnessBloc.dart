// ignore_for_file: file_names

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitnessapp/bloc/fitnessEvents.dart';
import 'package:fitnessapp/bloc/fitnessState.dart';
import 'package:fitnessapp/models/fitnessCategoryModel.dart';
import 'package:fitnessapp/models/workoutModel.dart';

class Fitnessbloc extends Bloc<Fitnessevents, Fitnessstate> {
  Fitnessbloc() : super(Fitnessstate()) {
    on<AddCategory>(addCategory);
    on<AddWorkout>(addExercise);
  }

  addCategory(AddCategory event, Emitter<Fitnessstate> emit) {
    Fitnesscategorymodel catmodel = Fitnesscategorymodel(
        catId: event.catId, catName: event.catName, createdAt: DateTime.now());
    addData(catmodel);
  }

  addExercise(AddWorkout event, Emitter<Fitnessstate> emit) {
    Workoutmodel exerciseModel = Workoutmodel(
        workoutId: event.excerciseId,
        workoutName: event.excerciseName,
        weight: event.excerciseWeight,
        sets: event.excerciseSets,
        reps: event.excerciseReps,
        catId: event.catId);
    addexercise(exerciseModel);
  }

  Future<void> addData(Fitnesscategorymodel model) async {
    final FirebaseFirestore firestor = FirebaseFirestore.instance;
    try {
      await firestor
          .collection('categories')
          .doc(model.catId)
          .set(model.tomap());
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> addexercise(Workoutmodel workout) async {
    final FirebaseFirestore firestor = FirebaseFirestore.instance;
    try {
      await firestor.collection('workout').doc(workout.workoutId).set(workout.toMap());
    } catch (e) {
      throw Exception(e);
    }
  }
}
