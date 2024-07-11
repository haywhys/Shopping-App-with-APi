import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

const String urls = "https://api.timbu.cloud/products?organization_id=36eae0c595164606b4b07fc19a3b81b2&reverse_sort=false&page=1&size=10&Appid=0D0B0KRIQXDV7MD&Apikey=c38cae8523ce482f8946951e938a2ce420240706192550521635";
Map mapResponse = {};
String stringResponse = '';
List dataResponse = [];

class MyDisplays extends StatefulWidget {
  const MyDisplays({super.key});

  @override
  State<MyDisplays> createState() => _MyDisplaysState();
}

class _MyDisplaysState extends State<MyDisplays> {

  Future fetchMyDetails() async {
    final response = await http.get(Uri.parse(urls));

    try {
      if (response.statusCode == 200) {
        setState(() {
          stringResponse = response.body;
          mapResponse = jsonDecode(response.body);
          dataResponse = mapResponse['items'];
        });
      } else {
        throw Exception("Failed to load API");
      }
    } catch (e) {
      setState(() {
        e.toString();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchMyDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white54,
      appBar: AppBar(
        title: const Text("Shopping App"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.shopping_cart),
          ),
        ],
      ),
      body: dataResponse.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: dataResponse.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.7, // Adjusted for better aspect ratio
            mainAxisSpacing: 15,
            crossAxisSpacing: 15,
          ),
          itemBuilder: (BuildContext context, int index) {
            var item = dataResponse[index];
            final price = item['current_price']?[0]["USD"]?[0] ?? 'N/A';
            return Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: SizedBox(
                      width: double.infinity,
                      child: Image.network(
                        "http://api.timbu.cloud/images/${item['photos'][0]['url']}",
                        width: MediaQuery.of(context).size.width*0.50,
                        fit: BoxFit.cover,

                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item['name'],
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item['description'],
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Price: \$$price',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
