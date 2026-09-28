import 'package:flutter/material.dart';

//Topic 3: Dynamic Scrollable Lists (ListView.builder).
//Key Technique: ListView.builder() is Flutter's memory-efficient widget for displaying long scrollable lists. 
//stead of creating all list items at once, it only builds the items currently visible on the screen,
//aking it ideal for handling large or infinite lists without performance degradation.

class DynamicListScreen extends StatelessWidget{
    const DynamicListScreen({super.key});

    @override
    Widget build(BuildContext context){

        //1. generating a dummy list of 100 items to simulate real data
        final List<String> itemsList = List.generate(100,(index) =>'item number ${index+1}');

        return Scaffold(
            appBar:AppBar(
                title:const Text('Dynamic Scrollable listLab'),
                backgroundColor:Colors.deepPurple,
            ),

            //2. using the builder constructor for optimized memory management
            body: ListView.builder(
            itemCount: itemsList.length,//tells flutter exactly how many itmes exist
            itemBuilder: (BuildContext, int index){
                // this function runs automatically only for items currently visible on the screen
                return Card(
                    margin:const EdgeInsets.symmetric(horizontal:16.0,vertical:6.0),
                    elevation:2,
                    child:ListTile(
                        leading:CircleAvatar(
                            backgroundColor:Colors.deepPurpleAccent,
                            child:Text(
                                '${index + 1}',
                                style:const TextStyle(color:Colors.white),
                            ),
                        ),
                        
                        title:Text(
                            itemsList[index],
                            style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        subtitle:Text('this is the descriptive subtitle for index item $index'),
                        trailing:const Icon(Icons.drag_handle, color:Colors.grey),
                        onTap:() {
                            // showing a visual message at the bottom when an item is clicked

                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content:Text('you tapped on item ${index + 1 }'),
                                    duration:const Duration(milliseconds:500),
                                ),
                            );
                        },
                    ),
                );
            },

        ),

        );

    }

}