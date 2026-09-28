import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkCallScreen extends StatefulWidget {
        const NetworkCallScreen({super.key});

        @override
        State<NetworkCallScreen> createState() =>_NetworkCallScreenState();
}

class _NetworkCallScreenState extends State<NetworkCallScreen> {
    // A Future represents a value that will arrive somtime in the future(async data)
    late Future <List<dynamic>> _usersFuture;

    @override
    void initState() {
        super.initState();
        // initialize the network request immediately when the screen loads into memory
        _usersFuture = _fetchUsers();
    }   
    
    //Asynchrounous function that fetch mock user data from a free public API
    Future<List<dynamic>> _fetchUsers() async {
        final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

        if (response.statusCode == 200){
            //200 means HTTP success. decode the raw response text string into a list array
            return jsonDecode(response.body);
        }
        else {
            // throw an exception if the serve returns a error code like 404 or 500
            throw Exception('Failed to load users from the server');
        }
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar:AppBar(
                title: Text('Network Request Lab'),
                backgroundColor:Colors.teal,
            ),
            // FutureBulider List to the network status and updates the UI automatically
            body : FutureBuilder<List<dynamic>>(
                future: _usersFuture,
                builder: (BuildContext context, AsyncSnapshot<List<dynamic>> sanpshot){

                    // state 1: data is still loading across the internet network
                    if (sanpshot.connectionState == ConnectionState.waiting){
                        return const Center(
                            child: CircularProgressIndicator(),
                        );
                    }

                    // state 2: an error occured (e.g, no internet or invaild server URL)
                    if (sanpshot.hasError){
                        return Center(
                            child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text('error : ${sanpshot.error}',
                                style: TextStyle(color: Colors.red, fontSize: 16),
                               textAlign: TextAlign.center, 
                                ),
                            ),
                        );
                    }

                    // state 3: data successfully downloaded from the serve API
                    if(sanpshot.hasData){
                        final users = sanpshot.data!;

                        return ListView.builder(
                            itemCount: users.length,   //number of rows to render
                            itemBuilder: (context, index) {
                                final user = users[index];

                                return Card(
                                    margin: const EdgeInsets.symmetric(horizontal:16.0, vertical:8),
                                    child: ListTile(
                                        leading:const CircleAvatar(
                                            backgroundColor:Colors.teal,
                                            child: Icon(Icons.person, color:Colors.white),
                                        ),
                                        title: Text(
                                            user['name'],
                                            style:const TextStyle(fontWeight:FontWeight.bold),
                                                
                                            ),
                                            subtitle:Text('${user['email']}\ncompany: ${user['company']['name']}',),
                                            isThreeLine: true,
                                        ),   // ← Missing closing parenthesis here!
                                    );
                                }, // ← Missing closing brace here!
                        );
                        }
                         //fallback state if no conditon matches
                    return const Center(child:Text('no data found'));
                    },
                   
                ),

            );
        
    }

}
