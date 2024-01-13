import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddPageScreen extends StatefulWidget {
  const AddPageScreen({super.key});

  @override
  State<AddPageScreen> createState() => _AddPageScreenState();
}

class _AddPageScreenState extends State<AddPageScreen> {

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add ToDo'),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          TextField(
            controller: titleController,
            decoration: InputDecoration(
              hintText: 'Title'
            ),
          ),

          TextField(
            controller: descriptionController,
            decoration: InputDecoration(
              hintText: 'Description',
            ),
            maxLines: 8,
            minLines: 5,
          ),

          SizedBox(
            height: 20,
          ),

          ElevatedButton(

            onPressed: submitData, 
            child: Text('Submit',style: TextStyle(fontSize: 17),)
          )
        ],
      ),
    );
  }


  Future<void> submitData() async {
    // get the data from form

    final title = titleController.text.toString();
    final description = descriptionController.text.toString();

    final body = {
      "title": title,
      "description": description,
      "is_completed": false
    };

    // submit data to the server

    final url = 'https://api.nstack.in/v1/todos';
    final uri = Uri.parse(url);     // convert Url in to Uri
    final response = await http.post(
       uri,
       body: jsonEncode(body),
       headers: {'Content-Type': 'application/json'},
       );
   
    print(response);
    print(response.statusCode);


    //show sucess or fail message based on status

    if(response.statusCode == 201){

      titleController.text = '';
      descriptionController.text = '';

      showSuccessMessage('successfully Add');
      print(response.body);
      print('success');
    }else{
      showFailureMessage('Not successfully Add');
      print('Error');
      print(response.body);
    }
  }

  // show snack bar message ..................................

  void showSuccessMessage(String message){
    final snackBar = SnackBar(backgroundColor: Colors.green,content: Text(message,style: TextStyle(fontSize: 20)));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showFailureMessage(String message){
    final snackBar = SnackBar(backgroundColor: Colors.red,content: Text(message,style: TextStyle(fontSize: 20),));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

}