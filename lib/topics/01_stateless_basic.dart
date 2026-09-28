import 'package:flutter/material.dart';

class StaticLayoutScreen extends StatelessWidget{
    const StaticLayoutScreen({super.key});
    
    @override
    Widget build(BuildContext context){
        return Scaffold(
            appBar: AppBar(
                title: const Text('Static Layout lab'),
            ),
            body: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                    // Column arrages itmes vertically from top to bottom
                    crossAxisAlignment:CrossAxisAlignment.start,
                    children:[
                        const Text(
                            'Layout Demonstration',
                            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height:20),

                        // Row arranges items horizontally from left to right
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children:[
                                Container(
                                    width:80,
                                    height:80,
                                    color: Colors.red,
                                    child: const Center(child:Text('Box 1',style:TextStyle(color:Colors.white))),
                                ),
                                Container(
                                    width:80,
                                    height:80,
                                    color:Colors.green,
                                    child:const Center(child:Text('Box 2',style:TextStyle(color:Colors.white))),
                                ),
                            ],
                        ),
                    ],
                ),
            ),
        );
    }
}