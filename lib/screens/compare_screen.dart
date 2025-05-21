import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/liked_images_provider.dart';
import '../providers/selected_provider.dart';

class CompareScreen extends ConsumerWidget {
  const CompareScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final likedAsync = ref.watch(likedImagesProvider);
    final selected = ref.watch(selectedProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Comparação')),
      body: likedAsync.when(
        data: (allImages) {
          final selectedImages = allImages
              .where((img) => selected.contains(img.id))
              .toList();

          if (selectedImages.length < 2) {
            return const Center(
              child: Text('Selecione 2 cachorros para comparar.'),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: selectedImages.map((dog) {
                      return Flexible(
                        child: Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                AspectRatio(
                                  aspectRatio: 1,
                                  child: Image.network(
                                    dog.url,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  dog.breedName,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        ref.read(selectedProvider.notifier).clear();
                        Navigator.pop(context);
                      },
                      child: const Text('OK'),
                    ),
                    TextButton(
                      onPressed: () {
                        ref.read(selectedProvider.notifier).clear();
                      },
                      child: const Text('Limpar Seleção'),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Erro: $e')),
      ),
    );
  }
}
