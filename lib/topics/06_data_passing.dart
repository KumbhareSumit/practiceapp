import 'package:flutter/material.dart';

// screen: the sender screen

class DataPassingScreenA extends StatefulWidget{
  const DataPassingScreenA({super.key});

  @override
  State<DataPassingScreenA> createState() => _DataPassingScreenAState();
}

class _DataPassingScreenAState extends State<DataPassingScreenA>{

  // controller to extract text from our input field
  final TextEditingController _textController = TextEditingController();

  @override
  void dispose(){
    // always clean up controller when the widget is destroyed to save memory
    _textController.dispose();
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
       title: const Text('Data Passing Screen A'),
       backgroundColor: Colors.blueGrey,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children:[
            TextField(
              controller: _textController,
              decoration: const InputDecoration(
              border: OutlineInputBorder(),
                labelText: 'Type secret message here ...',
                prefix: Icon(Icons.message),
              ),
            ),

            const SizedBox(height: 20,),

            ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blueGrey),
                onPressed: (){
                  //read the Text string out of the input controller
                  String dataToSend = _textController.text;
                  //Push Screen B onto the stack , passing data  directly into its constructor
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DataPassingScreenB(passedMessage: dataToSend),
                    ),
                  );
                },
                child:const Text('send data to screen B',style: TextStyle(color: Colors.white),
                ),
            ),
          ],
        ),
      ),
    );
  }
}


// Screen B: the receiver screen

class DataPassingScreenB extends StatelessWidget {
  //1. declare a final variable to hold the incoming data
  final String passedMessage;

  //2. Add the variable  as a required parameter in the constructor
  const DataPassingScreenB({super.key, required this.passedMessage});

  Widget build(BuildContext context){
    return Scaffold(
      appBar:AppBar(
        title: const Text('data passing screen B'),
        backgroundColor: Colors.blueGrey,
      ),
      body:Center(
        child: Padding(
          padding:const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Data received safely:',
              style:TextStyle(fontSize: 16, color:Colors.grey),
              ),

              const SizedBox(height: 12),

              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.blueGrey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.blueGrey),
                ),

                child: Text(
                  // 3. if the user sent nothing, show a fallback text string
                  passedMessage.isEmpty ?'[empty message]' : passedMessage,
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold,color: Colors.blueGrey),
                  textAlign: TextAlign.center,//ouick tip: ensure it handle formating properly
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton.icon(
                  onPressed: (){
                    // pop removes the top screen form the stack and goes back
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Back to screen A'),
              )
            ],
          ),
        ),
      ),
    );
  }
}