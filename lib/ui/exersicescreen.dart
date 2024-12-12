import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitnessapp/bloc/fitnessBloc.dart';
import 'package:fitnessapp/bloc/fitnessEvents.dart';
import 'package:fitnessapp/bloc/fitnessState.dart';
import 'package:fitnessapp/models/workoutModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_string/random_string.dart';
import '../utils/appTheme.dart';
import '../utils/typography.dart';

class Exercisescreen extends StatelessWidget {
  final String catId;
  Exercisescreen({super.key, required this.catId});
  final TextEditingController exerciseName = TextEditingController();
  final TextEditingController exerciseWeight = TextEditingController();
  final TextEditingController exerciseSets = TextEditingController();
  final TextEditingController exerciseReps = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          exerciseAdd(
            context,
            catId,
            exercise: exerciseName,
            exerciseWeight: exerciseWeight,
            exerciseSets: exerciseSets,
            exerciseReps: exerciseReps,
          );
        },
        child: const Icon(CupertinoIcons.add_circled_solid),
      ),
      appBar: AppBar(
        title: Text(
          'E X E R C I S E',
          style: appHeading(color: Apptheme.white, size: 48),
        ),
        centerTitle: true,
        backgroundColor: Apptheme.secondaryColor,
        elevation: 10,
        toolbarHeight: 90,
      ),
      body: BlocBuilder<Fitnessbloc, Fitnessstate>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('workout').where('catId',isEqualTo: catId)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        "Error",
                        style: appHeading(size: 24, color: Apptheme.white),
                      ),
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const SizedBox(
                      child: Center(
                        child: CupertinoActivityIndicator(
                          color: Apptheme.primaryColor,
                        ),
                      ),
                    );
                  }
                  if (snapshot.data!.docs.isEmpty) {
                    return Center(
                      child: Text("No Items Found",
                          style: appHeading(size: 28, color: Apptheme.white)),
                    );
                  }
                  if (snapshot.data != null) {
                    return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          final itemsData = snapshot.data!.docs[index];
                          Workoutmodel workModel = Workoutmodel(
                              workoutId: itemsData['workoutId'],
                              workoutName: itemsData['workoutName'],
                              weight: itemsData['weight'],
                              sets: itemsData['sets'],
                              reps: itemsData['reps'],
                              catId: itemsData['catId']);

                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              tileColor: Apptheme.secondaryColor.withOpacity(0.5),
                              title: Text(
                                workModel.workoutName.toUpperCase(),
                                style:
                                    appHeading(size: 32, color: Apptheme.white),
                              ),
                              subtitle: Text(
                                "Sets : ${workModel.sets}\nWeight${workModel.weight}Kg\nReps :${workModel.reps}",
                                style:
                                    appHeading(size: 24, color: Apptheme.white),
                              ),
                            ),
                          );
                        });
                  }

                  return const SizedBox();
                }),
          );
        },
      ),
    );
  }

  exerciseAdd(BuildContext context, String catId,
      {required TextEditingController exercise,
      required TextEditingController exerciseWeight,
      required TextEditingController exerciseSets,
      required TextEditingController exerciseReps}) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
              backgroundColor: Apptheme.black,
              content: SizedBox(
                width: MediaQuery.of(context).size.width - 50,
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Add Exercise',
                        style: appHeading(
                            size: 40,
                            color: Apptheme.secondaryColor,
                            weight: FontWeight.w700),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: exerciseName,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: 'Exercise Name',
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          floatingLabelStyle:
                              appHeading(size: 32, color: Apptheme.white),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(
                                width: 2, color: Apptheme.secondaryColor),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(
                                width: 2, color: Apptheme.secondaryColor),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                width: 3, color: Apptheme.primaryColor),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: TextField(
                              controller: exerciseWeight,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                suffix: Text(
                                  'KG',
                                  style: appHeading(
                                      size: 20, color: Apptheme.white),
                                ),
                                labelText: 'Weight',
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                floatingLabelStyle:
                                    appHeading(size: 32, color: Apptheme.white),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: const BorderSide(
                                      width: 2, color: Apptheme.secondaryColor),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: const BorderSide(
                                      width: 2, color: Apptheme.secondaryColor),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      width: 3, color: Apptheme.primaryColor),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            flex: 1,
                            child: TextField(
                              controller: exerciseSets,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                labelText: 'Sets',
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                floatingLabelStyle:
                                    appHeading(size: 32, color: Apptheme.white),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: const BorderSide(
                                      width: 2, color: Apptheme.secondaryColor),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: const BorderSide(
                                      width: 2, color: Apptheme.secondaryColor),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      width: 3, color: Apptheme.primaryColor),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: exerciseReps,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: 'Exercise Reps',
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          floatingLabelStyle:
                              appHeading(size: 32, color: Apptheme.white),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(
                                width: 2, color: Apptheme.secondaryColor),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(
                                width: 2, color: Apptheme.secondaryColor),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                width: 3, color: Apptheme.primaryColor),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    minimumSize: Size(
                                        MediaQuery.of(context).size.width, 50),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    backgroundColor: Apptheme.secondaryColor,
                                    shadowColor:
                                        Apptheme.secondaryColor.withOpacity(1),
                                    elevation: 10),
                                onPressed: () {
                                  Navigator.pop(ctx);
                                  exercise.clear();
                                  exerciseWeight.clear();
                                  exerciseSets.clear();
                                  exerciseReps.clear();
                                },
                                child: Text(
                                  "Cancel".toUpperCase(),
                                  style: appHeading(
                                      size: 28, color: Apptheme.white),
                                )),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            flex: 1,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    minimumSize: Size(
                                        MediaQuery.of(context).size.width, 50),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    backgroundColor: Apptheme.secondaryColor,
                                    shadowColor:
                                        Apptheme.secondaryColor.withOpacity(1),
                                    elevation: 10),
                                onPressed: () {
                                  var id = randomAlpha(15);
                                  context.read<Fitnessbloc>().add(AddWorkout(
                                      excerciseId: id,
                                      excerciseName: exercise.text,
                                      excerciseWeight: exerciseWeight.text,
                                      excerciseSets: exerciseSets.text,
                                      excerciseReps: exerciseReps.text,
                                      catId: catId));

                                  Navigator.pop(ctx);
                                  exercise.clear();
                                  exerciseWeight.clear();
                                  exerciseSets.clear();
                                  exerciseReps.clear();
                                },
                                child: Text(
                                  "Submit".toUpperCase(),
                                  style: appHeading(
                                      size: 28, color: Apptheme.white),
                                )),
                          ),
                        ],
                      )
                    ]),
              ));
        });
  }
}
