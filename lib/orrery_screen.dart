import 'package:flutter/material.dart';
import 'package:halleys_comet/services/neo_service.dart';
import 'package:three_dart/three_dart.dart' as THREE;
import 'dart:html' as html;


class OrreryScreen extends StatefulWidget {
  const OrreryScreen({super.key});

  @override
  _OrreryScreenState createState() => _OrreryScreenState();
}

class _OrreryScreenState extends State<OrreryScreen> {
  late Future<List<dynamic>> futureNes;

  @override
  void initState() {
    super.initState();
    futureNes = NeoService().fetchNearEarthObjects();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orrery - Near-Earth Objects'),
      ),
      body: Center(
        child: FutureBuilder<List<dynamic>>(
          future: futureNes,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Text('No Near-Earth Objects found.');
            } else {
              final List<dynamic> neos = snapshot.data!;
              return Neo3DViewer(neos: neos);
            }
          },
        ),
      ),
    );
  }
}

class Neo3DViewer extends StatefulWidget {
  final List<dynamic> neos;

  const Neo3DViewer({super.key, required this.neos});

  @override
  _Neo3DViewerState createState() => _Neo3DViewerState();
}

class _Neo3DViewerState extends State<Neo3DViewer> {
  

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
