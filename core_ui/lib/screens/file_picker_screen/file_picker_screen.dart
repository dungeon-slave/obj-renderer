import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:core_ui/app_colors.dart';
import 'package:core_ui/app_text_style.dart';
import 'package:core_ui/core_ui.dart';
import 'package:data/parser/obj_parser.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class FilePickerScreen extends StatelessWidget {
  const FilePickerScreen({super.key});

  void _tapHandler(NavigatorState navigatorState) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      Uint8List bytes = result.files.first.bytes == null
          ? await File(result.files.first.path!).readAsBytes()
          : result.files.first.bytes!;

      navigatorState.push(
        MaterialPageRoute(
          builder: (_) => RenderScreen(
            defaultFaces:
                ObjParser().parseContent(utf8.decode(bytes).split('\n')),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    NavigatorState navigatorState = Navigator.of(context);
    Size size = MediaQuery.sizeOf(context);

    return Stack(
      children: <Widget>[
        SizedBox(
          width: size.width,
          height: size.height,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.backGroundColor,
            ),
            onPressed: () => _tapHandler(navigatorState),
            child: const Text(
              'Tap to select .obj file',
              style: appTextStyle,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(size.width / 25),
          child: Text(
            'Esc - exit from render screen\n\n'
            'SCALING\n\n'
            'ArrowUp - scale plus\n'
            'ArrowDown - scale minus\n\n'
            'ROTATION\n\n'
            'F - rotate by X (plus)\n'
            'H - rotate by X (minus)\n'
            'T - rotate by Y (plus)\n'
            'G - rotate by Y (minus)\n'
            'R - rotate by Z (plus)\n'
            'Y - rotate by Z (minus)\n\n'
            'TRANSLATION\n\n'
            'A - translate by X (plus)\n'
            'D - translate by X (minus)\n'
            'W - translate by Y (plus)\n'
            'S - translate by Y (minus)\n'
            'Q - translate by Z (plus)\n'
            'E - translate by Z (minus)\n',
            style: appTextStyle.copyWith(fontSize: 20),
          ),
        ),
      ],
    );
  }
}
