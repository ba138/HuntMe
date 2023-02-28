import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hunt_me/Models/job_model.dart';

import '../repository/notification_repository.dart';

final notificationControllerProvider = Provider((ref) {
  final notificationRepository = ref.watch(notificationProvider);
  return NotificationController(
    notificationRepository: notificationRepository,
  );
});

class NotificationController {
  final NotificationRepository notificationRepository;
  NotificationController({required this.notificationRepository});
  Stream<List<JobModel>> getNotification() {
    return notificationRepository.getNotification();
  }

  Stream<JobModel> getNotificationData(String postId) {
    return notificationRepository.getNotificationData(postId);
  }
}
