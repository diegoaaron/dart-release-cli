#! /usr/bin/env dcli

import 'dart:io';

import 'package:dcli/dcli.dart';
import 'package:yaml/yaml.dart';

void main() {
  // Mostrando una consola de entrada
  print('''# --------------------------
  # 🚀 Release new version
  # ----------------------------------- ''');

  // Preguntando por un usaurio de entrada
  final newVersion = ask(
    'Ingrese una nueva version:',
    validator: Ask.regExp(
      r'^\d+\.\d+\.\d+$',
      error: 'Debes ingresar un version del tipo X.Y.Z',
    ),
  );

  try {
    // Leyendo el archivo
    final pubspec = File('./pubspec.yaml').readAsStringSync();

    // Parseando el contenido del archivo yaml con su version actual
    final currentVersion = loadYaml(pubspec)['version'];

    print('# Updating from version $currentVersion to version $newVersion...');

    // Escribiendo un archivo

    'pubspec.yaml'.write(pubspec.replaceFirst(
        'version: $currentVersion', 'version: $newVersion'));

    print('# ✅ Pubspec updated to version $newVersion');
  } catch (e) {
    printerr('# ❌ Failed to update pubspec to version $newVersion\nError: $e');
  }
}
