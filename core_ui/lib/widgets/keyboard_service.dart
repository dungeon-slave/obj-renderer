import 'package:core_ui/enums/allowed_actions.dart';
import 'package:data/data.dart';
import 'package:flutter/services.dart';

class KeyboardService {
  static double _translationStep = 10;
  static double _rotationStep = 0.1;
  static double _scaleStep = 1.05;

  static const Map<AllowedActions, List<LogicalKeyboardKey>> _keyActionMap =
      <AllowedActions, List<LogicalKeyboardKey>>{
    AllowedActions.translation: <LogicalKeyboardKey>[
      LogicalKeyboardKey.keyA,
      LogicalKeyboardKey.keyD,
      LogicalKeyboardKey.keyW,
      LogicalKeyboardKey.keyS,
      LogicalKeyboardKey.keyQ,
      LogicalKeyboardKey.keyE,
    ],
    AllowedActions.scaling: <LogicalKeyboardKey>[
      LogicalKeyboardKey.arrowUp,
      LogicalKeyboardKey.arrowDown,
    ],
    AllowedActions.rotation: <LogicalKeyboardKey>[
      LogicalKeyboardKey.keyF,
      LogicalKeyboardKey.keyH,
      LogicalKeyboardKey.keyT,
      LogicalKeyboardKey.keyG,
      LogicalKeyboardKey.keyR,
      LogicalKeyboardKey.keyY,
    ],
  };

  static void keyHandler(
    LogicalKeyboardKey key,
    Map<AllowedActions, Vector3> objectParameters,
  ) {
    try {
      AllowedActions action = _keyActionMap.entries
          .firstWhere(
            (MapEntry<AllowedActions, List<LogicalKeyboardKey>> element) =>
                element.value.contains(key),
          )
          .key;

      switch (action) {
        case AllowedActions.scaling:
          {
            _scaleHandler(key, objectParameters[action]!);
            break;
          }
        case AllowedActions.translation:
          {
            _translationHandler(key, objectParameters[action]!);
            break;
          }
        case AllowedActions.rotation:
          {
            _rotationHandler(key, objectParameters[action]!);
            break;
          }
      }
    } on StateError {
      return;
    }
  }

  static void _rotationHandler(LogicalKeyboardKey key, Vector3 vector) {
    switch (key) {
      case LogicalKeyboardKey.keyF:
        {
          vector.x = vector.x + _rotationStep;
          break;
        }
      case LogicalKeyboardKey.keyH:
        {
          vector.x = vector.x - _rotationStep;
          break;
        }
      case LogicalKeyboardKey.keyT:
        {
          vector.y = vector.y + _rotationStep;
          break;
        }
      case LogicalKeyboardKey.keyG:
        {
          vector.y = vector.y - _rotationStep;
          break;
        }
      case LogicalKeyboardKey.keyR:
        {
          vector.z = vector.z + _rotationStep;
          break;
        }
      case LogicalKeyboardKey.keyY:
        {
          vector.z = vector.z - _rotationStep;
          break;
        }
    }
  }

  static void _scaleHandler(LogicalKeyboardKey key, Vector3 vector) {
    switch (key) {
      case LogicalKeyboardKey.arrowUp:
        {
          double newValue = vector.x * _scaleStep;

          vector.x = newValue;
          vector.y = newValue;
          vector.z = newValue;

          break;
        }
      case LogicalKeyboardKey.arrowDown:
        {
          double newValue = vector.x / _scaleStep;

          vector.x = newValue;
          vector.y = newValue;
          vector.z = newValue;

          break;
        }
    }
  }

  static void _translationHandler(LogicalKeyboardKey key, Vector3 vector) {
    switch (key) {
      case LogicalKeyboardKey.keyA:
        {
          vector.x = vector.x + _translationStep;
          break;
        }
      case LogicalKeyboardKey.keyD:
        {
          vector.x = vector.x - _translationStep;
          break;
        }
      case LogicalKeyboardKey.keyW:
        {
          vector.y = vector.y + _translationStep;
          break;
        }
      case LogicalKeyboardKey.keyS:
        {
          vector.y = vector.y - _translationStep;
          break;
        }
      case LogicalKeyboardKey.keyQ:
        {
          vector.z = vector.z + _translationStep;
          break;
        }
      case LogicalKeyboardKey.keyE:
        {
          vector.z = vector.z - _translationStep;
          break;
        }
    }
  }
}
