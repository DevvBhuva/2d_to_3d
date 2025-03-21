import 'package:flutter/material.dart';
import 'package:flutter_cube/flutter_cube.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CubeViewer(),
    );
  }
}

class CubeViewer extends StatefulWidget {
  @override
  _CubeViewerState createState() => _CubeViewerState();
}

class _CubeViewerState extends State<CubeViewer> {
  late Object cube;
  double scaleFactor = 2.0; // Default scale

  @override
  void initState() {
    super.initState();
    cube = Object(fileName: "assets/cube.obj");
    cube.scale.setValues(scaleFactor, scaleFactor, scaleFactor);
  }

  void _onScaleUpdate(ScaleUpdateDetails details) {
    setState(() {
      scaleFactor = (scaleFactor * details.scale).clamp(0.5, 5.0);
      cube.scale.setValues(scaleFactor, scaleFactor, scaleFactor);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("3D Cube in Flutter")),
      body: GestureDetector(
        onScaleUpdate: _onScaleUpdate,
        child: Center(
          child: Cube(
            onSceneCreated: (Scene scene) {
              scene.world.add(cube);
            },
          ),
        ),
      ),
    );
  }
}
