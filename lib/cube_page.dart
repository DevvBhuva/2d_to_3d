import 'package:flutter/material.dart';
import 'package:flutter_cube/flutter_cube.dart';

class CubePage extends StatefulWidget {
  @override
  _CubePageState createState() => _CubePageState();
}

class _CubePageState extends State<CubePage> {
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
      appBar: AppBar(title: Text("3D Cube Viewer")),
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
