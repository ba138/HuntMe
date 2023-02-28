import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hunt_me/auth/repository/auth_repository.dart';

import '../../Models/user_model.dart';

final authControllerProvider = Provider((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AuthController(
    authRepository: authRepository,
    ref: ref,
  );
});
final getDataProvider = FutureProvider((ref) {
  final authController = ref.watch(authControllerProvider);
  return authController.getData();
});

class AuthController {
  final AuthRepository authRepository;
  ProviderRef ref;
  AuthController({required this.authRepository, required this.ref});

  void saveData(
    String name,
    String bio,
    String email,
    String phoneNumber,
    File? profile,
    BuildContext context,
    String password,
  ) {
    authRepository.saveDataToFireStore(
      name: name,
      bio: bio,
      email: email,
      phoneNumber: phoneNumber,
      profile: profile,
      context: context,
      ref: ref,
      password: password,
    );
  }

  void loginUser(String password, String email, BuildContext context) {
    authRepository.loginUser(email, password, context);
  }

  Future<UserModel?> getData() async {
    UserModel? user = await authRepository.checkUser();
    return user;
  }
}
