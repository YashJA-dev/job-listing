part of 'hive_repo.dart';

class JobRepository {
  static const String _boxName = 'jobs';

  Future<void> saveJobs(List<JobModel> jobs) async {
    final box = await Hive.openBox<JobModel>(_boxName);
    await box.clear(); // Clear existing data before saving new ones
    await box.addAll(jobs);
  }

  Future<List<JobModel>> getJobs() async {
    final box = await Hive.openBox<JobModel>(_boxName);
    return box.values.toList();
  }

  Future<void> addJob(JobModel job) async {
    final box = await Hive.openBox<JobModel>(_boxName);
    await box.add(job);
  }

  Future<void> clearJobs() async {
    final box = await Hive.openBox<JobModel>(_boxName);
    await box.clear();
  }

  Future<void> updateJob(String id, JobModel updatedJob) async {
    final box = await Hive.openBox<JobModel>(_boxName);
    final jobs = box.values.toList();

    for (int i = 0; i < jobs.length; i++) {
      if (jobs[i].id == id) {
        await box.putAt(i, updatedJob);
        break;
      }
    }
  }

  Future<List<JobModel>> getFavoriteJobs() async {
    final box = await Hive.openBox<JobModel>(_boxName);
    return box.values.where((job) => job.fav ?? false).toList();
  }
}
