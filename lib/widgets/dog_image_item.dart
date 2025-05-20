import 'package:flutter/material.dart';
import '../models/dog_image.dart';

class DogImageItem extends StatelessWidget {
  final DogImage dog;
  final double height;

  const DogImageItem({
    super.key,
    required this.dog,
    this.height = 200,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Image.network(
          dog.url,
          height: height,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return SizedBox(
              height: height,
              child: const Center(child: CircularProgressIndicator()),
            );
          },
          errorBuilder: (context, error, stack) => SizedBox(
            height: height,
            child: const Center(child: Icon(Icons.error)),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'ID: ${dog.id}',
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 12, color: Colors.black54),
        ),
      ],
    );
  }
}
