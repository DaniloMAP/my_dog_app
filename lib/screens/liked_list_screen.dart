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
          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            itemCount: images.length,
            itemBuilder: (context, index) {
              final dog = images[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: DogImageItem(
                  dog: dog,
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Erro: $e')),
      ),
    );
  }
}
