import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joblisting/app/api/api_response.dart';
import 'package:joblisting/model/job_model.dart';
import 'package:joblisting/repository/base_api_repo.dart';
import 'package:joblisting/repository/cache/hive_repo.dart';

part 'favorite_jobs_event.dart';
part 'favorite_jobs_state.dart';

class FavoriteJobsBloc extends Bloc<FavoriteJobsEvent, FavoriteJobsState> {
  final MockApiRepo mockApiRepo;
  final JobRepository jobsRepo;
  FavoriteJobsBloc({
    required this.mockApiRepo,
    required this.jobsRepo,
  }) : super(FavoriteJobsInitial()) {
    on<LoadFavoriteJobsData>(_loadFavoriteJobs);
    on<SearchJobs>(_onSearchJobs);
  }

  FutureOr<void> _loadFavoriteJobs(
      LoadFavoriteJobsData event, Emitter<FavoriteJobsState> emit) async {
    try {
      emit(FavoriteJobsLoading());
      List<JobModel> jobs = await jobsRepo.getFavoriteJobs();
      emit(FavoriteJobsLoaded(jobs: jobs));
    } catch (e) {
      emit(FavoriteJobsError(e.toString()));
    }
  }

  void _onSearchJobs(SearchJobs event, Emitter<FavoriteJobsState> emit) async {
    if (state is FavoriteJobsLoaded) {
      final currentState = state as FavoriteJobsLoaded;
      List<JobModel> jobs = await jobsRepo.getFavoriteJobs();
      if (event.query.isEmpty) {
        emit(currentState.copyWith(jobs: jobs));
      } else {
        final filteredJobs = jobs
            .where((job) =>
                job.name!.toLowerCase().contains(event.query.toLowerCase()) ||
                job.companyname!
                    .toLowerCase()
                    .contains(event.query.toLowerCase()))
            .toList();

        emit(currentState.copyWith(jobs: filteredJobs));
      }
    }
  }
}
