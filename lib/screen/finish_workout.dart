import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:workout_project/provider/work_provider.dart';
import 'package:workout_project/screen/add_exercise.dart';

// ignore: must_be_immutable
class FinishWorkoutScreen extends StatefulWidget {
  String dayName;
  String workOutName;
   FinishWorkoutScreen({required this.dayName,required this.workOutName,Key? key}) : super(key: key);

  @override
  State<FinishWorkoutScreen> createState() => _FinishWorkoutScreenState();
}

class _FinishWorkoutScreenState extends State<FinishWorkoutScreen> {
  final List<TextEditingController> _controllers = [];
  List<bool> isChecked = List.generate(3, (index) => false);

  String dateFormat= DateFormat('EEEE').format(DateTime.now());
  var task;


  @override
  Widget build(BuildContext context) {
    final finishProvider=Provider.of<WorkProvider>(context);



    // log(widget.dayName);
    // log(widget.workOutName);
    return Scaffold(
    body: SafeArea(
      child: Column(
        children: [
          Text("$dateFormat  log",style: const TextStyle(fontSize: 20),),
          Text(widget.workOutName,style: const TextStyle(fontSize: 20),),
          const SizedBox(height: 60,),
          Expanded(
            child: FutureBuilder(
              future: finishProvider.getData(),
              builder: (context,AsyncSnapshot<List<Map<String,dynamic>>> snapshot){
            if(snapshot.hasData){
              task=snapshot.requireData.where((element) =>element["date"]==dateFormat).map((e) => e).toList();
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Expanded(
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.zero,

                        itemCount: 3,
                        itemBuilder: (context,index){
                          _controllers.add(TextEditingController());
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("Set$index"),
                              Row(
                                children: [

                                  //Text("Set1"),
                                  Checkbox(

                                      shape: const CircleBorder(),
                                      splashRadius: 20,
                                      value: isChecked[index], onChanged: (checked){
                                    setState(() {
                                      isChecked[index]=checked!;
                                    });
                                  }),

                                  SizedBox(
                                    width: 50,
                                    child: TextField(

                                      controller: _controllers[index],
                                    ),
                                  ),
                                  Text("kg")

                                ],
                              )
                            ],
                          );

                        }
                    ),
                  ),
                ],
              );
            }
            else{
              // ignore: prefer_const_constructors
              return SizedBox();
            }
              },

            ),
          ),
        ],
      ),
    )
    );
  }
}
