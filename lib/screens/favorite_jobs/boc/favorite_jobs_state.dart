part of "favorite_jobs_bloc.dart";

abstract class FavoriteJobsState extends Equatable {
  const FavoriteJobsState();

  @override
  List<Object> get props => [];
}

class FavoriteJobsInitial extends FavoriteJobsState {}

class FavoriteJobsLoading extends FavoriteJobsState {}

class FavoriteJobsLoaded extends FavoriteJobsState {
  final List<JobModel> jobs;

  const FavoriteJobsLoaded({required this.jobs});

  @override
  List<Object> get props => [jobs];

  FavoriteJobsLoaded copyWith({List<JobModel>? jobs}) {
    return FavoriteJobsLoaded(
      jobs: jobs ?? this.jobs,
    );
  }
}

class FavoriteJobsError extends FavoriteJobsState {
  final String message;

  const FavoriteJobsError(this.message);

  @override
  List<Object> get props => [message];
}
