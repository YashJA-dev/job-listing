part of "favorite_jobs_bloc.dart";

abstract class FavoriteJobsEvent extends Equatable {
  const FavoriteJobsEvent();

  @override
  List<Object> get props => [];
}

class LoadFavoriteJobsData extends FavoriteJobsEvent {}

class SearchJobs extends FavoriteJobsEvent {
  final String query;

  const SearchJobs(this.query);

  @override
  List<Object> get props => [query];
}

class UpdateJob extends FavoriteJobsEvent {
  final int index;
  const UpdateJob(this.index);
  @override
  List<Object> get props => [index];
}

class FavoriteJobsDataError extends FavoriteJobsEvent {
  final String error;

  const FavoriteJobsDataError(this.error);

  @override
  List<Object> get props => [error];
}
