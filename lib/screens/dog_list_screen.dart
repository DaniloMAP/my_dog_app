import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/dog_image.dart';
import '../providers/dog_provider.dart';

class DogListScreen extends ConsumerWidget {
  const DogListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imagesAsync = ref.watch(dogImagesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Cachorros')),
      body: imagesAsync.when(
        data: (List<DogImage> images) {
          return ListView.builder(
            itemCount: images.length,
            itemBuilder: (context, index) {
              final dog = images[index];
              return Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 16.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Image.network(dog.url, height: 200, fit: BoxFit.cover),
                    const SizedBox(height: 8),
                    Text(
                      'ID: ${dog.id}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error:
            (error, stack) => Center(child: Text('Erro ao carregar: $error')),
      ),
    );
  }
}
