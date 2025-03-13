import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joblisting/model/job_model.dart';
import 'package:joblisting/repository/cache/hive_repo.dart';

part 'jobs_detail_events.dart';
part 'jobs_detail_state.dart';

class JobDetailBloc extends Bloc<JobDetailEvent, JobDetailState> {
  final JobRepository jobRepository;

  JobDetailBloc(this.jobRepository) : super(JobDetailInitial()) {
    on<LoadJobDetail>(_onLoadJobDetail);
    on<ToggleFavorite>(_onToggleFavorite);
  }

  /// Loads job details by ID
  Future<void> _onLoadJobDetail(
      LoadJobDetail event, Emitter<JobDetailState> emit) async {
    emit(JobDetailLoading());
    try {
      List<JobModel> allJobs = await jobRepository.getJobs();
      final job = allJobs.firstWhere((job) => job.id == event.jobId,
          orElse: () => JobModel(id: event.jobId));
      emit(JobDetailLoaded(job));
    } catch (e) {
      emit(JobDetailError("Job not found"));
    }
  }

  /// Toggles the favorite status of a job
  Future<void> _onToggleFavorite(
      ToggleFavorite event, Emitter<JobDetailState> emit) async {
    if (state is JobDetailLoaded) {
      final currentState = state as JobDetailLoaded;

      // Update Hive storage
      await jobRepository.updateJob(
          event.job.id!, event.job.copyWith(fav: !(event.job.fav ?? false)));

      List<JobModel> allJobs = await jobRepository.getJobs();
      final job = allJobs.firstWhere(
        (job) => job.id == event.job.id,
        orElse: () => JobModel(id: event.job.id),
      );
      emit(JobDetailLoaded(job));
    }
  }
}
