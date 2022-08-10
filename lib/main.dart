import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_project/provider/work_provider.dart';
import 'package:workout_project/screen/finish_workout.dart';
import 'package:workout_project/screen/home_screen.dart';


void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   ChangeNotifierProvider(create: (context)=>WorkProvider(),
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    ),
    );
  }
}
