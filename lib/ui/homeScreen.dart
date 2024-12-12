// ignore_for_file: file_names

import 'package:fitnessapp/ui/workoutscreem.dart';
import 'package:flutter/material.dart';
import '../utils/appTheme.dart';
import '../utils/typography.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: MediaQuery.of(context).size.width / 5,
              backgroundColor: Apptheme.white,
              child: Image.asset(
                'assest/images/logo2.png',
                width: MediaQuery.of(context).size.width / 3,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Your Workout\nCompanion',
              style: appHeading(
                  color: Apptheme.white,
                  size: MediaQuery.of(context).size.width / 12,
                  weight: FontWeight.w900),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize:
                        Size(MediaQuery.of(context).size.width / 2, 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    backgroundColor: Apptheme.secondaryColor,
                    shadowColor: Apptheme.secondaryColor.withOpacity(1),
                    elevation: 10),
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (_) => WorkoutScreen()));
                },
                child: Text(
                  "Get Started".toUpperCase(),
                  style: appHeading(size: 24, color: Apptheme.white),
                ))
          ],
        ),
      ),
    );
  }
}
