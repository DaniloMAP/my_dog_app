import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/dog_image.dart';
import '../providers/liked_images_provider.dart';
import '../providers/selected_provider.dart';
import '../widgets/dog_image_item.dart';

class CompareScreen extends ConsumerWidget {
  const CompareScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final likedAsync = ref.watch(likedImagesProvider);
    final selected = ref.watch(selectedProvider);
    final selNotifier = ref.read(selectedProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Comparar Curtidos')),
      body: likedAsync.when(
        data: (List<DogImage> all) {
          return Column(
            children: [
              // grid com os curtidos clicáveis
              Expanded(
                flex: 2,
                child: GridView.builder(
                  padding: const EdgeInsets.all(12),
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.8,
                  ),
                  itemCount: all.length,
                  itemBuilder: (ctx, i) {
                    final dog = all[i];
                    final isSel = selected.contains(dog.id);
                    final disabled = !isSel && selected.length >= 2;
                    return GestureDetector(
                      onTap: disabled ? null : () => selNotifier.toggle(dog.id),
                      child: Stack(
                        children: [
                          Opacity(
                            opacity: disabled ? 0.5 : 1,
                            child: DogImageItem(dog: dog),
                          ),
                          if (isSel)
                            Positioned(
                              top: 4,
                              left: 4,
                              child: CircleAvatar(
                                radius: 12,
                                backgroundColor: Colors.blue,
                                child: Text(
                                  '${selected.indexOf(dog.id) + 1}',
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              const Divider(),

              // preview lado a lado
              Expanded(
                flex: 1,
                child: Center(
                  child: selected.length == 2
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: selected.map((id) {
                            final dog =
                                all.firstWhere((d) => d.id == id, orElse: () => all.first);
                            return SizedBox(
                              width: MediaQuery.of(context).size.width * .4,
                              child: DogImageItem(dog: dog, height: 150),
                            );
                          }).toList(),
                        )
                      : const Text('Selecione 2 cachorros para comparar'),
                ),
              ),

              // botões de ação para comparar/fechar
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: selected.length == 2
                          ? () {
                              showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                  title: const Text('Comparação'),
                                  content: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: selected.map((id) {
                                      final dog =
                                          all.firstWhere((d) => d.id == id);
                                      return SizedBox(
                                        width: 100,
                                        height: 100,
                                        child: Image.network(
                                          dog.url,
                                          fit: BoxFit.cover,
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('Fechar'),
                                    ),
                                  ],
                                ),
                              );
                            }
                          : null,
                      child: const Text('Comparar'),
                    ),

                    // botão pra limpar seleção
                    ElevatedButton(
                      onPressed: selNotifier.clear,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey),
                      child: const Text('Limpar Seleção'),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
        loading: () =>
            const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Erro: $e')),
      ),
    );
  }
}
