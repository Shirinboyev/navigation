import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: _ImageFiltererState(),
  ));
}

class _ImageFiltererState extends StatefulWidget {
  const _ImageFiltererState({super.key});

  @override
  __ImageFiltererStateState createState() => __ImageFiltererStateState();
}

class __ImageFiltererStateState extends State<_ImageFiltererState> {
  double _sigmaX = 0, _sigmaY = 0;
  double _rotZ = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(4),
        children: [
          ImageFiltered(
            // Compose two image filters: result = outer(inner(source)).
            // ImageFilter.compose(...)
            // ! -- ImageFilter.compose Doesn't work??
            // ! https://dartpad.dev/?id=a39eeefa873b62f63e4f3516c2d04b09
            imageFilter: ImageFilter.blur(sigmaX: _sigmaX, sigmaY: _sigmaY),
            child: Image.asset('images/friends.png'),
          ),
          ImageFiltered(
            imageFilter: ImageFilter.matrix(Matrix4.rotationZ(_rotZ).storage),
            child: const Text(
              'Not only can images be "filtered", in fact any widget '
              'can be placed under ImageFiltered!',
            ),
          ),
          const Divider(),
          ..._controlWidgets(),
        ],
      ),
    );
  }

  /// Widgets to control the parameters.
  List<Widget> _controlWidgets() {
    return [
      Row(
        children: [
          const Text('sigmaX:'),
          Expanded(
            child: Slider(
              max: 20,
              value: _sigmaX,
              onChanged: (val) {
                setState(() => this._sigmaX = val);
              },
            ),
          ),
          Text(_sigmaX.toStringAsFixed(1)),
        ],
      ),
      Row(
        children: [
          const Text('sigmaY:'),
          Expanded(
            child: Slider(
              max: 20,
              // min: 20,
              value: _sigmaY,
              onChanged: (val) {
                setState(() => this._sigmaY = val);
              },
            ),
          ),
          Text(_sigmaY.toStringAsFixed(1)),
        ],
      ),
      Row(
        children: [
          const Text('rotationZ:'),
          Expanded(
            child: Slider(
              min: -1.6,
              max: 1.6,
              value: _rotZ,
              onChanged: (val) {
                setState(() => this._rotZ = val);
              },
            ),
          ),
          Text(_rotZ.toStringAsFixed(1)),
        ],
      ),
    ];
  }
}
