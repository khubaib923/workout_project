import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:workout_project/provider/work_provider.dart';
import 'package:workout_project/screen/home_screen.dart';

// ignore: must_be_immutable
class EndWorkout extends StatefulWidget {
  String dayName;
  String title;
  EndWorkout({required this.dayName,required this.title,Key? key}) : super(key: key);

  @override
  State<EndWorkout> createState() => _EndWorkoutState();
}

class _EndWorkoutState extends State<EndWorkout> {
 // final List<TextEditingController> _controllers = [];
  //List<bool> isChecked = List.generate(3, (index) => false);
  String dateFormat= DateFormat('EEEE').format(DateTime.now());
  bool value=false;
  var task;
  var x=1;
  //List<TextEditingController> controller=[TextEditingController()];
  List<TextEditingController> _controllers = [];
List<bool>selected=[];

isSelected(){
  for(int i=0;i<10;i++){
    selected.insert(i, false);
  }

}

@override
  void initState() {
  // TODO: implement initState
  super.initState();
  isSelected();
}




  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.of(context).size.width;
    final height=MediaQuery.of(context).size.height;
    final finishProvider=Provider.of<WorkProvider>(context);
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           Center(
             child: Column(
               children: [
                 Text("$dateFormat log",style: const TextStyle(fontSize: 20),),
                 Text(widget.title,style: const TextStyle(fontSize: 20),),
               ],
             ),
           ),

            SizedBox(height : height*0.02,),
            FutureBuilder(
              future: finishProvider.getData(),
                builder: (context,AsyncSnapshot<List<Map<String,dynamic>>> snapshot){
                  if(snapshot.hasData){
                    task=snapshot.requireData.where((element) =>element["date"]==dateFormat).map((e) => e).toList();
                    return Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        //physics: NeverScrollableScrollPhysics(),
                        itemCount: task.length,
                          itemBuilder: (context,index){
                          //List<bool>isChecked=List.generate(int.parse(task[index]["property"]), (index) => false);
                            return  Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  child: Text(task[index]["name"],style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                                ),
                                const SizedBox(height: 10,),

                                SizedBox(
                                  height:70,
                                  width:double.infinity,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                  physics: const ClampingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                   //physics: NeverScrollableScrollPhysics(),
                                    //shrinkWrap: true,
                                    //itemCount: int.parse(task[index]["property"].length),
                                    itemCount: int.tryParse(task[index]["property"]),
                                      itemBuilder: (context,indexx){
                                      _controllers.add(TextEditingController());

                                      //  List<bool> isChecked = List.generate(int.parse(task[index]["property"]), (int pro)=>false);

                                      return Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Row(
                                            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text("Set$indexx"),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Checkbox(

                                                  shape: const CircleBorder(),
                                                  splashRadius: 20,
                                                  value: selected[indexx], onChanged: (checked){
                                                setState(() {
                                                  selected[indexx]=checked!;
                                                });
                                              }),
                                                SizedBox(
                                                  width:50,
                                                  child: TextField(controller: _controllers[indexx],)),
                                              const Text("kg"),
                                            ],
                                          ),
                                        ],
                                      );

                                  }),
                                ),

                                const SizedBox(height: 20,)
                              ],
                            );
                          }
                      ),
                    );

                  }
                  else{
                   return SizedBox();
                  }
                }

            ),
            //Spacer(),

            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: Colors.black,

                ),
                child:  Center(
                  child: InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                      },
                      child: const Text("FINISH WORKOUT",style: TextStyle(color: Colors.white,fontSize: 20),)),
                ),
              ),
            )




          ],
        ),
      ),
    );
  }
}
