import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'bottom_nav.dart';

void main() {
  runApp(const MyApp());
}

Future<MyDetails> fetchMyDetails()async{
  final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));


  // check returned response

  if(response.statusCode == 200){
    return MyDetails.fromJson(jsonDecode(response.body));
  }
  else{
    throw Exception("Failed to load API");
  }

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Example Test',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  const CustomBottomNav(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title:const Text("API Test"),
      ),
      body: Center(
        child: Container(
          color: Colors.lightBlueAccent,
          child: TextButton(onPressed: (){
            fetchMyDetails().then((value){

            });
          },
            child: const Text("Get Response"),),
        ),
      ),
    );
  }
}

class MyDetails{
  final int userId;
  final int id;
  final String title;

  const MyDetails({required this.userId, required this.id, required this.title});


  factory MyDetails.fromJson(Map<String, dynamic>json){
    return MyDetails(userId:json['userId'], id:json['id'],title:json['title']);
  }
}