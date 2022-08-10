

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:workout_project/screen/add_exercise.dart';
import 'package:intl/intl.dart';
import 'package:workout_project/screen/end_workout.dart';
import 'package:workout_project/screen/finish_workout.dart';

class HomeScreen extends StatefulWidget {
   HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<String>dayName=["Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"];


  String dateFormat= DateFormat('EEEE').format(DateTime.now());
    Widget getDayName(String title){
      return TextButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) =>  EndWorkout(dayName: dateFormat,title: title ,)));
      }, child:const  Text("Log Workout",style: TextStyle(color: Colors.black),));
    }







TextEditingController textEditingController1=TextEditingController()..text="Chest";
    TextEditingController textEditingController2=TextEditingController()..text="Back and Biceps";

TextEditingController textEditingController3=TextEditingController()..text="Rest";

TextEditingController textEditingController4=TextEditingController()..text="Rest";

TextEditingController textEditingController5=TextEditingController()..text="Legs";

TextEditingController textEditingController6=TextEditingController()..text="Chest";

TextEditingController textEditingController7=TextEditingController()..text="Rest";



  Widget getTextField({required String day,required BuildContext context,required TextEditingController controller}){
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
    Row(
      children: [
    SizedBox(
        width: 75,
        child: Text(day,style: const TextStyle(fontWeight: FontWeight.w400))
    ),
    const SizedBox(width: 5,),
    Expanded(
    child: TextField(
      controller: controller,

    decoration: InputDecoration(
    contentPadding: const EdgeInsets.all(8),
    filled: true,
    fillColor: Colors.grey[300],
    border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(5),
    borderSide: BorderSide.none
    ),
    enabledBorder:  OutlineInputBorder(
    borderRadius: BorderRadius.circular(5),
    borderSide: BorderSide.none
    ),

    ),
    )
    ),
    if(dateFormat==day)getDayName(controller.text),

    TextButton(onPressed: (){
      Navigator.push(context, MaterialPageRoute(builder: (context)=> ExerciseScreen(appTitle: controller.text,day:day),

      )
      ).then((value){
        //controller.clear();
      });

    },
        child:const  Text("Set workout",style: TextStyle(color:Colors.black),
    )
    )
    ],
    ),
        const SizedBox(height: 15,),
      ],
    );
  }
@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    textEditingController1.dispose();
    textEditingController2.dispose();
    textEditingController3.dispose();
    textEditingController4.dispose();
    textEditingController5.dispose();
    textEditingController6.dispose();
    textEditingController7.dispose();


  }
  @override
  Widget build(BuildContext context) {
    log(dateFormat);

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.grey[500],
        appBar: AppBar(
          title: const Text("Workout Log",style: TextStyle(color: Colors.black),),
          centerTitle: true,
          elevation: 0,
          backgroundColor:Colors.transparent,
        ),
        body: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              getTextField(day:dayName[0],context: context,controller: textEditingController1),
              getTextField(day: dayName[1],context: context,controller: textEditingController2),
              getTextField(day: dayName[2],context: context,controller: textEditingController3),
              getTextField(day: dayName[3],context: context,controller: textEditingController4),
              getTextField(day: dayName[4],context: context,controller: textEditingController5),
              getTextField(day: dayName[5],context: context,controller: textEditingController6),
              getTextField(day: dayName[6],context: context,controller: textEditingController7),

            ],
          ),
        ),
      ),
    );
  }
}

