import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('MyDogApp')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () => context.goNamed('dogs'),
              child: const Text('Ver Cachorros'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.goNamed('liked'),
              child: const Text('Comparar Curtidos'),
            ),
          ],
        ),
      ),
    );
  }
}
