import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/dog_image.dart';
import '../providers/liked_provider.dart';

class DogImageItem extends ConsumerWidget {
  final DogImage dog;

  const DogImageItem({super.key, required this.dog});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final likedIds = ref.watch(likedProvider);
    final isLiked = likedIds.contains(dog.id);

    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Image.network(
                dog.url,
                fit: BoxFit.cover,
                loadingBuilder: (c, child, prog) =>
                    prog == null ? child : const Center(child: CircularProgressIndicator()),
                errorBuilder: (c, e, s) => const Center(child: Icon(Icons.error)),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'ID: ${dog.id}',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12, color: Colors.black54),
            ),
          ],
        ),
        Positioned(
          top: 8,
          right: 8,
          child: IconButton(
            icon: Icon(
              isLiked ? Icons.favorite : Icons.favorite_border,
              color: Colors.red,
            ),
            onPressed: () {
              ref.read(likedProvider.notifier).toggleLike(dog.id);
            },
          ),
        ),
      ],
    );
  }
}
