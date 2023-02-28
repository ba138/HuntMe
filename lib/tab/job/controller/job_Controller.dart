// ignore_for_file: file_names

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hunt_me/Models/user_model.dart';
import '../../../Models/job_model.dart';
import '../repository/job_post_repository.dart';

final jobController = Provider((ref) {
  final jobRepositoryProvider = ref.watch(jobRepository);
  return JobController(jobRepository: jobRepositoryProvider);
});

class JobController {
  final JobRepository jobRepository;
  JobController({required this.jobRepository});
  void postJob(
    String gigs,
    String title,
    String jobType,
    String location,
    String industry,
    String discrption,
  ) {
    jobRepository.postJob(
      gigs,
      title,
      jobType,
      location,
      industry,
      discrption,
    );
  }

  Stream<UserModel> getUserData() {
    return jobRepository.getUserData();
  }

  Stream<List<JobModel>> getMyJob() {
    return jobRepository.myPost();
  }
}
