import 'package:core_ui/widgets/app_custom_painter.dart';
import 'package:data/data.dart';
import 'package:flutter/material.dart';

class AppCustomPaint extends StatefulWidget {
  final Map<int, List<Vector4>> _entities;

  const AppCustomPaint({
    required Map<int, List<Vector4>> entities,
    super.key,
  })  : _entities = entities;

  @override
  _AppCustomPaintState createState() => _AppCustomPaintState();
}

class _AppCustomPaintState extends State<AppCustomPaint> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);

    return Container(
      decoration: BoxDecoration(border: Border.all()),
      child: CustomPaint(
        size: size,
        painter: AppCustomPainter(
          entities: widget._entities,
        ),
      ),
    );
  }
}
