import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_dog_app/screens/compare_screen.dart';
import '../providers/liked_images_provider.dart';
import '../providers/selected_provider.dart';
import '../widgets/dog_image_item.dart';

class LikedListScreen extends ConsumerWidget {
  const LikedListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final likedAsync = ref.watch(likedImagesProvider);
    final selected = ref.watch(selectedProvider);
    final selNotifier = ref.read(selectedProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Seus Curtidos')),
      body: likedAsync.when(
        data: (images) {
          if (images.isEmpty) {
            return const Center(
              child: Text('Você ainda não curtiu nenhum cachorro.'),
            );
          }
          return Column(
            children: [
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 12,
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.75,
                  ),
                  itemCount: images.length,
                  itemBuilder: (ctx, i) {
                    final dog = images[i];
                    final isSel = selected.contains(dog.id);
                    final disabled = !isSel && selected.length >= 2;

                    return GestureDetector(
                      onTap: disabled ? null : () => selNotifier.toggle(dog.id),
                      child: Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Stack(
                            children: [
                              Opacity(
                                opacity: disabled ? 0.5 : 1,
                                child: DogImageItem(dog: dog),
                              ),
                              if (isSel)
                                Positioned(
                                  top: 8,
                                  left: 8,
                                  child: CircleAvatar(
                                    radius: 12,
                                    backgroundColor: Colors.blue,
                                    child: Text(
                                      '${selected.indexOf(dog.id) + 1}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              const Divider(height: 1),
              
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 16,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed:
                      selected.length == 2
                          ? () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const CompareScreen(),
                                ),
                              );
                            }
                          : null,
                      child: const Text('Comparar'),
                    ),
                    TextButton(
                      onPressed: selNotifier.clear,
                      child: const Text('Limpar Seleção'),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Erro: $e')),
      ),
    );
  }
}
