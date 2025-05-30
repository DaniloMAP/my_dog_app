import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/dog_image.dart';
import '../providers/dog_provider.dart';
import '../widgets/dog_image_item.dart';

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
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            itemCount: images.length,
            itemBuilder: (context, index) {
              final dog = images[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DogImageItem(dog: dog),
                  ),
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
