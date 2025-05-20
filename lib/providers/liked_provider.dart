import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _prefsKey = 'liked_ids';

class LikedNotifier extends StateNotifier<Set<String>> {
  LikedNotifier() : super({}) {
    _loadLikedIds();
  }

  Future<void> _loadLikedIds() async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_prefsKey) ?? [];
    state = list.toSet();
  }

  Future<void> toggleLike(String id) async {
    final newSet = {...state};
    if (!newSet.remove(id)) {
      newSet.add(id);
    }
    state = newSet;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_prefsKey, state.toList());
  }

  Future<void> clearLikes() async {
    state = {};
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_prefsKey);
  }
}

final likedProvider =
    StateNotifierProvider<LikedNotifier, Set<String>>((ref) {
  return LikedNotifier();
});
