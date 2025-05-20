import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectedNotifier extends StateNotifier<List<String>> {
  SelectedNotifier() : super([]);

  void toggle(String id) {
    final list = [...state];
    if (list.contains(id)) {
      list.remove(id);
    } else if (list.length < 2) {
      list.add(id);
    }
    state = list;
  }

  void clear() => state = [];
}

final selectedProvider =
    StateNotifierProvider<SelectedNotifier, List<String>>((ref) {
  return SelectedNotifier();
});
