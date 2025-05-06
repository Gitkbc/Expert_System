import 'package:flutter/material.dart';
import 'package:flutter_cube/flutter_cube.dart';

class My3DModelView extends StatefulWidget {
  const My3DModelView({super.key});

  @override
  _My3DModelViewState createState() => _My3DModelViewState();
}

class _My3DModelViewState extends State<My3DModelView> {
  late Object _object;

  @override
  void initState() {
    super.initState();
    _object = Object(fileName: "assets/your_model.glb"); // Use the correct file path
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("3D Model Viewer")),
      body: Cube(
        onSceneCreated: (Scene scene) {
          scene.world.add(_object);
          scene.camera.zoom = 10;
        },
      ),
    );
  }
}
