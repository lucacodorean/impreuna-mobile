// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'presentation/app.dart';

void main() {

  runApp(
    ProviderScope(child: const MyApp()),
  );
}
