import 'package:flutter/material.dart';

//Topic 4: Multi-Screen Grid Architecture (GridView.builder).
//Key Technique: GridView.builder() is Flutter's specialized widget for creating efficient, scrollable grid layouts.
//t works similarly to ListView.builder() by generating only the widgets visible on screen,
//aking it ideal for apps with many grid items like dashboards or product catalogs.


class GridLayoutScreen extends StatelessWidget{
    const GridLayoutScreen({super.key});

    @override
    Widget build(BuildContext context){
        // 1. generating a dummy list of 24 items for our grid tiles
        final List<String> dashboardItems = List.generate(24,(index) => 'Lab Module ${index + 1}');

        // 2. defining a distinct color list to give each grid card a unique appearance
        final List<Color> cardColors = [
            Colors.blue,
            Colors.red,
            Colors.green,
            Colors.yellow,
            Colors.purple,
            Colors.orange,
            Colors.teal,
            Colors.pink,
        ];

        return Scaffold(
            appBar: AppBar(
                title: const Text('grid architure'),
                backgroundColor: Colors.indigo,
            ),
        
        // 3. using the grid bulder constructor for highly efficient grid structure ho
        body:GridView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: dashboardItems.length,
            // the delegate controls how many colums exist and how they are spaced
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                   crossAxisCount: 2,// sets exactly 2 columns across the screen
                   crossAxisSpacing:16.0,
                   mainAxisSpacing:16.0,
                   childAspectRatio: 1.0,
            ),
            itemBuilder: (BuildContext context, int index){
                //Cycle through our color list using the modulo opertor(%)
                final Color standardColor = cardColors[index % cardColors.length];

                return InkWell(
                        onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                             SnackBar(content: Text('launched ${dashboardItems[index]}')),
                            );
                        },
                        borderRadius: BorderRadius.circular(16.0),
                        child: Card(
                            color:standardColor.withValues(alpha: 0.15),
                            elevation:0,
                            shape:RoundedRectangleBorder(
                                side:BorderSide(color: standardColor,width: 2),
                                borderRadius:BorderRadius.circular(16.0),
                            ),
                            child:Column(
                                mainAxisAlignment:MainAxisAlignment.center,
                                children:[
                                    Icon(Icons.dashboard_customize, size:40, color: standardColor),

                                    const SizedBox(height:12),
                                    Text(
                                        dashboardItems[index],
                                        style:TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize:16,
                                            color:standardColor,
                                        ),
                                    ),
                                ],
                                
                            ),
                        ),
                );
                
            },
            ),
        );
    }
}