import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:halleys_comet/models/apod_model.dart';
import 'package:halleys_comet/orrery_screen.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<APODModel> imgOfDay;

  @override
  void initState() {
    super.initState();
    imgOfDay = _getDayImage();
  }

  Future<APODModel> _getDayImage() async {
    const apiKey = "aUhRrxzMSd8YlKOqh2kZnmiGph9nBmvAL8XIyEeP";
    final url =
        Uri.parse("https://api.nasa.gov/planetary/apod?api_key=$apiKey");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return APODModel.fromJson(data);
    } else {
      throw Exception('Failed to load image');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextButton(
          style: const ButtonStyle(
            overlayColor: WidgetStatePropertyAll(Colors.transparent),
          ),
          onPressed: () {},
          child: const Text(
            "Haley's Comet",
            style: TextStyle(fontSize: 30),
          ),
        ),
        actions: [
          TextButton(
              style: const ButtonStyle(
                overlayColor: WidgetStatePropertyAll(Colors.transparent),
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => OrreryScreen(),
                ));
              },
              child: const Text("Solar System")),
          IconButton(onPressed: () {}, icon: const Icon(Icons.more)),
        ],
      ),
      body: Center(
        child: FutureBuilder<APODModel>(
          future: imgOfDay,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator(); // Show loading spinner
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              print(snapshot.data); // Check the structure of your data
              print(snapshot.data!.url); // Print the image URL

              if (snapshot.data!.mediaType == 'image') {
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          // Background image
                          Image.network(
                            snapshot.data!.url,
                            fit: BoxFit.cover,
                            height: double.infinity,
                            width: double.infinity,
                          ),
                          // Vignette effect overlay
                          Container(
                            decoration: BoxDecoration(
                              gradient: RadialGradient(
                                center: Alignment.center,
                                radius: 1.0,
                                colors: [
                                  Colors.black.withOpacity(0), // Darker in the center
                                  Colors.transparent, // Transparent at the edges
                                ],
                                stops: [0.7, 1.0], // Control the transition
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text('Date: ${snapshot.data!.date}'),
                      Text(snapshot.data!.mediaType)
                    ],
                  ),
                );
              } else {
                return const Text('APOD media is a video');
              }
            } else {
              return const Text('No data available');
            }
          },
        ),
      ),
    );
  }
}
