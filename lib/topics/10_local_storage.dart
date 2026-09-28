import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageScreen extends StatefulWidget   {
    const LocalStorageScreen({super.key});

    @override
    State<LocalStorageScreen> createState() => _LocalStorageScreenState();
}

    class _LocalStorageScreenState extends State<LocalStorageScreen>{

        // final TextEditingController _noteController = TextEditingController();

        //Controller to extract text from  our note input box
        final TextEditingController _noteController = TextEditingController();
        String _savedNoteText = 'No Notes saved yet.';

        @override 
        void initState(){
            super.initState();
            _loadSavedData(); // automaitcally fetch the saved staring when the screen loads
        }

        @override
        void dispose(){
            _noteController.dispose();
            super.dispose();
        }
        //1. Asynchronous fuction to read data from divce disk
        Future<void> _loadSavedData() async{
            final prefs = await SharedPreferences.getInstance();
            // use the setState to update the visual display on screen
            setState ((){

                //user_memo is our uniqe key name. if it doesn't exist , fallback to default text.
                _savedNoteText = prefs.getString('user_memo') ?? 'No notes saved yet.';
            
            });
        }
        //2. Asynchronus function to write data onto the devie disk
        Future<void> _saveData() async {
            final prefs = await SharedPreferences.getInstance();
            await prefs.setString('user_memo', _noteController.text);

            _noteController.clear(); // clear the text input field area
            _loadSavedData();// refresh the visible screen state content

            //if (!mounted) return;
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('Data successfully written to persistent disk!'),
                    backgroundColor:Colors.green,
                ),
            );
        }
        @override
        Widget build(BuildContext context){
            return Scaffold(
                appBar:AppBar(
                    title: const Text('Locsl stronge lab'),
                    backgroundColor:Colors.brown,
                ),
                body: Padding(
                    padding:const EdgeInsets.all(16.0),
                    child:Column(
                        crossAxisAlignment:CrossAxisAlignment.stretch,
                        children:[
                            const Text(
                                'Persistent Notepad Manual',
                                style: TextStyle(fontSize:20,fontWeight:FontWeight.bold),
                            ),
                            const SizedBox(height:20),
                            TextField(
                                controller: _noteController,
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText:'Write a note to save permanently...',
                                    prefixIcon: Icon(Icons.note_alt),
                                ),
                            ),
                            const SizedBox(height:10),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(backgroundColor:Colors.brown),
                                onPressed: _saveData,
                                child:const Text('write datato disk', style:TextStyle(color:Colors.white)),
                            ),
                            const Divider(height:40),
                            const Text(
                                'currently Stored value on disk:',
                                style:TextStyle(fontSize:14, color:Colors.grey, fontWeight:FontWeight.bold),
                            ),
                            const SizedBox(height:10),
                            Container(
                                padding: const EdgeInsets.all(16.0),
                                decoration: BoxDecoration(
                                 color: Colors.brown.withValues(alpha:0.1),
                                 borderRadius:BorderRadius.circular(8),
                                 border: Border.all(color:Colors.brown),
                                ),
                                child: Text(
                                    _savedNoteText,
                                    style: TextStyle(fontSize:16,fontStyle:FontStyle.italic),
                                ),
                            ),
                        ],
                    ),
                ),
            );
        }

    }