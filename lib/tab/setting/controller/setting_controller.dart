import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hunt_me/tab/setting/repository/setting_repository.dart';

final settingControllerProvider = Provider((ref) {
  final settingRepository = ref.watch(settingRepositoryProvider);
  return SettingController(settingRepository: settingRepository);
});

class SettingController {
  final SettingRepository settingRepository;
  SettingController({required this.settingRepository});
  void logOutUser(BuildContext context) {
    settingRepository.logOutUser(context);
  }

  void updateUserDetails(
    String name,
    String uid,
    File? profilePic,
    String phoneNumber,
    String bio,
    String email,
    BuildContext context,
  ) {
    settingRepository.updateUserDetail(
        name, uid, profilePic, phoneNumber, bio, email, context);
  }

  void deleteUser() {
    settingRepository.deleteUser();
  }

  void deleteJob(String jobId) {
    settingRepository.deletePost(jobId);
  }
}
