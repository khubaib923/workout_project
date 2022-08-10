
import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:workout_project/database/database_helper.dart';

import 'package:workout_project/provider/work_provider.dart';

// ignore: must_be_immutable
class ExerciseScreen extends StatefulWidget {
  String appTitle;
  String day;
   ExerciseScreen({required this.appTitle,required this.day,Key? key}) : super(key: key);

  @override
  State<ExerciseScreen> createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  String dateFormat= DateFormat('EEEE').format(DateTime.now());








  TextEditingController textEditingController1=TextEditingController();
  TextEditingController textEditingController2=TextEditingController();
  List<Map<String,dynamic>>? row;
  // List<Map<String,dynamic>>? valueBack;
  var contain;
  static var task;








  Future<void> getFromUsers()async{

    int id=await DatabaseHelper.instance.insert({
      DatabaseHelper.columnName:textEditingController1.text,
      DatabaseHelper.columnProperty:textEditingController2.text,
      DatabaseHelper.columnDate:widget.day,

    });
    log(id.toString());
    List<Map<String,dynamic>>query=await DatabaseHelper.instance.queryAll();
    log(query.toString());


    //await DatabaseHelper.instance.delete();
    // ignore: use_build_context_synchronously
    Navigator.pop(context,query);
    textEditingController1.clear();
    textEditingController2.clear();
  }


  Widget buildUserList(data){
    return Expanded(
      child: FutureBuilder(
        future: data,
        builder: (context,AsyncSnapshot<List<Map<String,dynamic>>> snapshot){

          if(snapshot.hasData){
            task=snapshot.requireData.where((element) =>element["date"]==widget.day).map((e) => e).toList();
            return ListView.builder(
                itemCount:task.length ,
                itemBuilder: (BuildContext context,index){

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                        children: [
                          SizedBox(
                              width: 120,
                              child: Text(task[index]["name"])),
                          SizedBox(
                              width: 60,
                              child: Text("${task[index]["property"]}"))

                        ],
                      ),
                      const SizedBox(height: 10,),
                    ],
                  );



                }
            );
          }
          else{
            return SizedBox();
          }
        },

      ),
    );
  }

  Widget rowTextField({required String title,required TextEditingController controller}){
    return   Row(
      children: [
         SizedBox(
           width: 40,
           child: FittedBox(
             child: Text(title),
           ),
         ),
        const SizedBox(width: 10,),
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
      ],
    );
  }





  @override
  Widget build(BuildContext context) {
    final workProvider=Provider.of<WorkProvider>(context);
   //  if(row!=null){
   //    // var contain=row!.map((element)=> element["date"]==widget.day);
   //   // log(contain);
   //   contain=row!.where((element) =>element["date"]==widget.day).map((e) => e).toList();
   //   log(contain.toString());
   //   setState(() {
   //
   //   });
   //
   // }
   //  // log(queryRows.toString());
   //  //log(value.toString());
   //  log(widget.day.toString());
    //log(row.toString());
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.grey[500],
        appBar:  AppBar(
          title:  Text(widget.appTitle,style: const TextStyle(color: Colors.black),),
          centerTitle: true,
          elevation: 0,
          backgroundColor:Colors.transparent,
        ),
        body: Column(
          children: [
            Center(
              child: TextButton(onPressed: () async{
                showDialog<List<Map<String,dynamic>>>(context: context, builder: (context){


                 return SingleChildScrollView(
                   child: AlertDialog(
                   backgroundColor: Colors.grey,
                     actions: [
                       SizedBox(
                         height: 600,
                         width: double.infinity,
                         child: Column(
                           //mainAxisAlignment: MainAxisAlignment.center,
                           //crossAxisAlignment: CrossAxisAlignment.center,
                           children: [
                             const Spacer(),
                             rowTextField(title: "Name",controller: textEditingController1),
                             const SizedBox(height: 20,),
                             rowTextField(title: "Sets",controller: textEditingController2),
                             const Spacer(
                               flex: 2,
                             ),
                             TextButton(onPressed: (){
                               getFromUsers();
                             },

                                 style: ButtonStyle(
                                   backgroundColor: MaterialStateProperty.all(Colors.grey[300]),
                                   padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 25,vertical:12)),
                                 ),
                                 child:const Text("Add exercise",style: TextStyle(color: Colors.black),),

                             )
                           ],
                         ),
                       )
                     ],
                   ),
                 );
               }).then((value){
                 if(value==null || value.isEmpty)return;
                 else{
                   setState(() {
                     row=value;
                   });
                 }
               });
                //if(row ==null || row!.isEmpty)return;

              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.grey[300]),
                padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 25,vertical:12)),
              ),
                child: const Text("Add Exercise",style: TextStyle(color: Colors.black),),
              ),
            ),
          const SizedBox(height: 20,),

          //if(row!=null) buildUserList()
            // ignore: unnecessary_null_comparison
            if(workProvider.getData()!=null)buildUserList(workProvider.getData())
          ],
        ),

      ),
    );
  }




}
