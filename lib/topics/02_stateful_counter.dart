import 'package:flutter/material.dart';

// 1. the widget configurtion class 

class InteractiveLabScreen extends StatefulWidget {
    const InteractiveLabScreen({super.key});

    @override
    State<InteractiveLabScreen> createState() => _InteractivelLabScreenState();
}

// 2. the state class where all your changing variables live
class _InteractivelLabScreenState extends State<InteractiveLabScreen>{
 // ---State Variable---
 int _counter = 0;
 bool _isSwitchedOn = false;
 String _userInput ='';

 //--- Methods to Modify State ---
 void _incrementCounter(){
    // setstate tells flutter: "data changed,please redraw this widget!"

    setState((){
        _counter++;
    });
 } 
 @override
 Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
            title:const Text('Stateful Interactivity lab'),
            backgroundColor:Colors.teal,
        ),
        body: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:[
                    // ---Section 1: the counter ---
                    const Text(
                        '1.Interaction counter',
                        style:TextStyle(fontSize:18, fontWeight:FontWeight.bold),
                    ),
                    Text(
                        'Button pressed $_counter times.',
                        style:const TextStyle(fontSize:15),
                    ),
                    ElevatedButton(
                        onPressed: _incrementCounter,
                        child: const Text('Add 1'),
                    ),

                    const Divider(height:40), // Visual separator line

                    //---Section 2: the toggle switch---
                    const Text(
                        '2. Toggle state switch',
                        style: TextStyle(fontSize:18, fontWeight: FontWeight.bold),
                    ),
                    Row(
                        mainAxisAlignment:MainAxisAlignment.spaceBetween,
                        children:[
                            Text(
                                _isSwitchedOn ? 'the switch is on' : 'the switch is off', // Ternary operator used to change the text based on the value of _isSwitchedOn.
                                style:TextStyle(
                                    color: _isSwitchedOn ? Colors.green : Colors.red,
                                    fontWeight:FontWeight.bold,
                                ),
                            ),
                            Switch(
                                value: _isSwitchedOn,
                                //'value' inside onchanged is the new state (true or false)
                                onChanged:(bool newValue){
                                    setState((){
                                        _isSwitchedOn = newValue;
                                    });
                                },
                            ),
                        ],
                    ),
                    const Divider(height:40),

                    // ---Section 3: Text Input ---
                    const Text(
                        '3. Live Text input',
                        style:TextStyle(fontSize:18, fontWeight:FontWeight.bold),
                    ),
                    TextField(
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Type sometihng here...',// Textfield widget used for user text input.
                        ),

                        // Trigger automatically every time the user presses a key
                        onChanged:(String text){
                            setState((){
                                _userInput = text;
                            });
                        },
                    ),
                    const SizedBox(height:10),
                    Text(
                        'Live Mirror:$_userInput',
                        style:TextStyle(fontStyle: FontStyle.italic, color:Colors.grey), 
                    ),
                ],
            ),
        ),
    );
 }
}