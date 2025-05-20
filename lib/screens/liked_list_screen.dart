import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/dog_image.dart';
import '../providers/liked_images_provider.dart';
import '../widgets/dog_image_item.dart';

class LikedListScreen extends ConsumerWidget {
  const LikedListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final likedAsync = ref.watch(likedImagesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Seus Curtidos')),
      body: likedAsync.when(
        data: (List<DogImage> images) {
          if (images.isEmpty) {
            return const Center(child: Text('Você ainda não curtiu nenhum cachorro.'));
          }
          return GridView.builder(
            padding: const EdgeInsets.all(12),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.8,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: images.length,
            itemBuilder: (context, index) {
              final dog = images[index];
              return DogImageItem(dog: dog);
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Erro: $e')),
      ),
    );
  }
}
