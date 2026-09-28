import 'package:flutter/material.dart';

class FormValidationScreen extends StatefulWidget{
    const FormValidationScreen({super.key});

    @override
    State<FormValidationScreen> createState() => _FormValidationScreenState();
}
class _FormValidationScreenState extends State<FormValidationScreen>{
    // 1. the form key tracks the state of the form and runs validation checks
    final _formKey = GlobalKey<FormState>();

    // 2. local variable to clean input text
    String _userEmail ='';
    String _UserPassword ='';

    void _submitForm() {
    // 3. trigger validation across all text field within the Form container
    if(_formKey.currentState!.validate()){
        //if vaild, save the inputs
        _formKey.currentState!.save();

        //clear or process data safely
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Processing data... Validation successful!'),
                backgroundColor:Colors.green,
            ),
        );
    }else{
        // validation failed; error warning flags appear automatically below the fields
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content:Text('Please correct the validation errors.'),
                backgroundColor:Colors.red,
            ),
        );
    }
    }

    @override
    Widget build(BuildContext context){
        return Scaffold(
            appBar: AppBar(
                title:const Text('Form validation Lab'),
                backgroundColor:Colors.orange,//note: use Colors.orange if orangeDeep throws error

            ),

            body:Padding(
                padding:const EdgeInsets.all(16.0),
                // 4. wrapping input widget inside a form conatiner linked to our unique key
                child: Form(
                key:_formKey,
                child:ListView(
                    children: [
                                const Text(
                                'Account Registration',
                                style: TextStyle(fontSize:22, fontWeight:FontWeight.bold),
                                ),

                                const SizedBox(height:20),

                                // ----Email Field ----
                                TextFormField(
                                    decoration: const InputDecoration(
                                        labelText:'Email Address',
                                        border:OutlineInputBorder(),
                                        prefixIcon:Icon(Icons.email),
                                    ),
                                    keyboardType:TextInputType.emailAddress,
                                    // the validator function evaluates input value dynamically
                                    validator: (value){
                                        if (value == null || value.trim().isEmpty){
                                            return'Please enter an email address';
                                        }
                                        if(!value.contains('@')){
                                            return 'please enter a vaild email address containing @';
                                        }
                                        return null;//reurn null if validation passes perfectly
                                    },
                                    onSaved: (value) => _userEmail = value ?? '',
                                ),
                                const SizedBox(height:20),

                                // ------password------
                                TextFormField(
                                    decoration:const InputDecoration(
                                        labelText:'Password',
                                        border: OutlineInputBorder(),
                                        prefixIcon:Icon(Icons.lock),
                                        
                                    ),
                                    obscureText: true,//hides typed text characters safely
                                    validator:(value){
                                        if (value == null || value.isEmpty){
                                            return 'please enter a password';
                                        }
                                        if (value.length < 6){
                                            return 'password must be at least 6 characters long';
                                        }
                                        return null;
                                    },
                                    onSaved: (value) => _UserPassword = value ?? '',  
                                ),
                                const SizedBox(height:30),

                                //---Submit button ----
                                ElevatedButton(
                                    onPressed: _submitForm,
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.orange,
                                        padding: const EdgeInsets.symmetric(vertical:16.0),
                                    ),
                                    child:const Text('Submit registration',
                                        style:TextStyle(fontSize:16, color:Colors.white),
                                    ),
                                ),
                            ],  
                        ),         
                ),
            ),
        );
        
    }
    
}