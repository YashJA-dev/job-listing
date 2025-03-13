import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joblisting/app/api/api_response.dart';
import 'package:joblisting/model/job_model.dart';
import 'package:joblisting/repository/base_api_repo.dart';
import 'package:joblisting/repository/cache/hive_repo.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final MockApiRepo mockApiRepo;
  final JobRepository jobsRepo;
  HomeBloc({
    required this.mockApiRepo,
    required this.jobsRepo,
  }) : super(HomeInitial()) {
    on<LoadHomeData>(_loadHome);
    on<SearchJobs>(_onSearchJobs);
    on<UpdateJob>(_updateJob);
  }

  FutureOr<void> _loadHome(LoadHomeData event, Emitter<HomeState> emit) async {
    try {
      emit(HomeLoading());
      final List<ConnectivityResult> connectivityResult =
          await (Connectivity().checkConnectivity());
      APIResponse? response;
      List<JobModel> jobs = [];
      if (connectivityResult.contains(ConnectivityResult.mobile) ||
          connectivityResult.contains(ConnectivityResult.wifi)) {
        response = await mockApiRepo.getJobs();
        if (response is SuccessResponse) {
          jobs = (response.rawData as List<dynamic>)
              .map(
                (e) => JobModel.fromMap(e),
              )
              .toList();
          List<JobModel> tempJob = await jobsRepo.getJobs();
          Map<String, bool> favoriteMap = {
            for (var job in tempJob)
              if (job.fav ?? false) job.id!: true
          };
          jobs = jobs.map((job) {
            return job.copyWith(fav: favoriteMap.containsKey(job.id));
          }).toList();
          jobsRepo.saveJobs(jobs);
        } else {
          emit(HomeError("SomeThing Went Wrong!"));
          return;
        }
      } else {
        jobs = await jobsRepo.getJobs();
      }
      emit(HomeLoaded(jobs: jobs));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  void _onSearchJobs(SearchJobs event, Emitter<HomeState> emit) async {
    if (state is HomeLoaded) {
      final currentState = state as HomeLoaded;
      List<JobModel> jobs = await jobsRepo.getJobs();
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

  FutureOr<void> _updateJob(UpdateJob event, Emitter<HomeState> emit) async {
    try {
      List<JobModel> jobs = await jobsRepo.getJobs();
      JobModel updatedModel =
          jobs[event.index].copyWith(fav: !(jobs[event.index].fav ?? false));
      await jobsRepo.updateJob(updatedModel.id!, updatedModel);
      jobs = await jobsRepo.getJobs();
      emit(HomeLoaded(jobs: jobs));
    } catch (e) {
      emit(HomeError("Some Thing Went Wrong"));
    }
  }
}
