import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:todo_app/screens/add_page.dart';
import 'package:http/http.dart' as http;

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To Do List'),
      ),

      floatingActionButton: FloatingActionButton.extended(
        label: Text('Add ToDo'),
        onPressed: navigateToAddPage,
        ),
    );
  }

  void  navigateToAddPage(){

    final route = MaterialPageRoute(
      builder: (context) => AddPageScreen(),
    );

    Navigator.push(context, route);


  }


    Future<void> fetchData() async{

        final url ='https://api.nstack.in/v1/todos?page=1&limit=10';
        final uri = Uri.parse(url);
        final response = await http.get(uri);

        print(response);
        print(response.statusCode);
        print(response.body);

      //  final json = jsonDecode(re)



    }


}