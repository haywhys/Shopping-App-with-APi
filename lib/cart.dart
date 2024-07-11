import 'package:flutter/material.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
      ),
    body: Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
            itemCount: 1,
            itemBuilder: (context, int index){
          return const Card(
            child: ListTile(
              leading: Text("No Item yet"),
            ),
          );
        }),
      ),
    ),
    );
  }
}
