import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitnessapp/bloc/fitnessBloc.dart';
import 'package:fitnessapp/bloc/fitnessEvents.dart';
import 'package:fitnessapp/bloc/fitnessState.dart';
import 'package:fitnessapp/models/fitnessCategoryModel.dart';
import 'package:fitnessapp/ui/exersicescreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_string/random_string.dart';
import '../utils/appTheme.dart';
import '../utils/typography.dart';

class WorkoutScreen extends StatelessWidget {
  WorkoutScreen({super.key});
  final TextEditingController categoryNamecontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          bottomSheet(context, categoryNamecontroller);
        },
        child: const Icon(CupertinoIcons.add_circled_solid),
      ),
      appBar: AppBar(
        title: Text(
          'W O R K O U T',
          style: appHeading(color: Apptheme.white, size: 48),
        ),
        centerTitle: true,
        backgroundColor: Apptheme.secondaryColor,
        elevation: 10,
        toolbarHeight: 100,
      ),
      body: BlocBuilder<Fitnessbloc, Fitnessstate>(
        builder: (context, state) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(
                decelerationRate: ScrollDecelerationRate.fast),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  //header
                  Container(
                    width: double.maxFinite,
                    height: MediaQuery.of(context).size.width / 2.5,
                    decoration: BoxDecoration(
                        color: Apptheme.secondaryColor.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(20)),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          'https://www.healthdigest.com/img/gallery/the-male-celebrity-workout-routine-people-are-most-likely-to-try-exclusive-survey/intro-1663175120.jpg',
                          width: double.maxFinite,
                          fit: BoxFit.cover,
                          alignment: Alignment.topCenter,
                        )),
                  ),

                  const SizedBox(
                    height: 20,
                  ),
                  //heading
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                        color: Apptheme.secondaryColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      'E X E R C I S E',
                      style: appHeading(size: 32, color: Apptheme.white),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                      height: 500,
                      child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('categories')
                              .snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasError) {
                              return Center(
                                child: Text(
                                  "Error",
                                  style: appHeading(
                                      size: 24, color: Apptheme.white),
                                ),
                              );
                            }
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
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
                                    style: appHeading(
                                        size: 28, color: Apptheme.white)),
                              );
                            }
                            if (snapshot.data != null) {
                              return ListView.builder(
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (context, index) {
                                    final itemsData =
                                        snapshot.data!.docs[index];
                                    Fitnesscategorymodel catModel =
                                        Fitnesscategorymodel(
                                            catId: itemsData['catId'],
                                            catName: itemsData['catName'],
                                            createdAt: itemsData['createdAt']);
                                            
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ListTile(
                                        onTap: () => Navigator.push(context,MaterialPageRoute(builder: (_)=>Exercisescreen(catId: catModel.catId))),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10)
                                        ),
                                        tileColor: Apptheme.secondaryColor.withOpacity(0.5),
                                        title: Text(catModel.catName.toUpperCase(),style: appHeading(size: 40, color:Apptheme.white),),
                                        trailing: const Icon(CupertinoIcons.arrow_right_circle_fill,color: Apptheme.white,size: 32,),
                                      ),
                                    );
                                  });
                            }

                            return const SizedBox();
                          })),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  bottomSheet(
      BuildContext context, TextEditingController textEditingController) {
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
                        'Add Workout Type',
                        style: appHeading(
                            size: 40,
                            color: Apptheme.secondaryColor,
                            weight: FontWeight.w700),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: categoryNamecontroller,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: 'WorkOut Type',
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
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              minimumSize:
                                  Size(MediaQuery.of(context).size.width, 50),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              backgroundColor: Apptheme.secondaryColor,
                              shadowColor:
                                  Apptheme.secondaryColor.withOpacity(1),
                              elevation: 10),
                          onPressed: () {
                            var id = randomAlpha(10);
                            context.read<Fitnessbloc>().add(AddCategory(
                                catId: id,
                                catName: categoryNamecontroller.text));
                          },
                          child: Text(
                            "Submit".toUpperCase(),
                            style: appHeading(size: 28, color: Apptheme.white),
                          ))
                    ]),
              ));
        });
  }
}
