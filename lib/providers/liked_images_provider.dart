import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_dog_app/providers/dog_provider.dart';
import '../models/dog_image.dart';
import '../providers/liked_provider.dart';

final likedImagesProvider =
    FutureProvider.autoDispose<List<DogImage>>((ref) async {
  final likedIds = ref.watch(likedProvider);
  if (likedIds.isEmpty) {
    return [];
  }

  final repo = ref.watch(dogRepositoryProvider);

  final images = await Future.wait(
    likedIds.map((id) => repo.fetchDogImageById(id)),
  );
  return images;
});
