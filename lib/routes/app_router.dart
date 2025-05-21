import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../screens/home_screen.dart';
import '../screens/dog_list_screen.dart';
import '../screens/liked_list_screen.dart';
import '../screens/compare_screen.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        name: 'home',
        path: '/',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        name: 'dogs',
        path: '/dogs',
        builder: (context, state) => const DogListScreen(),
      ),
      GoRoute(
        name: 'liked',
        path: '/liked',
        builder: (context, state) => const LikedListScreen(),
      ),
      GoRoute(
        name: 'compare',
        path: '/compare',
        builder: (context, state) => const CompareScreen(),
      ),
    ],
  );
});
