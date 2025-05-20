import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/dog_image.dart';
import '../repositories/dog_repository.dart';

final dogRepositoryProvider = Provider<DogRepository>((ref) {
  return DogRepository();
});

//testar ui sem 'autoDispose'
final dogImagesProvider = FutureProvider.autoDispose<List<DogImage>>((
  ref,
) async {
  final repo = ref.watch(dogRepositoryProvider);

  return repo.fetchDogImages();
});
