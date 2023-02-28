import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hunt_me/Models/user_model.dart';
import 'package:hunt_me/tab/discover/repository/discover_repository.dart';

final discoverControllerProvider = Provider((ref) {
  final discoverRepositoryProvider = ref.watch(discoverRepository);
  return DiscoverController(discoverRepository: discoverRepositoryProvider);
});

class DiscoverController {
  final DiscoverRepository discoverRepository;
  DiscoverController({required this.discoverRepository});

  Stream<List<UserModel>> getService() {
    return discoverRepository.getService();
  }

  Stream<QuerySnapshot> searchQuery(String query) {
    return discoverRepository.searchQuery(query);
  }
}
