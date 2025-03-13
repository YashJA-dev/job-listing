part of "home_bloc.dart";

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class LoadHomeData extends HomeEvent {}

class SearchJobs extends HomeEvent {
  final String query;

  const SearchJobs(this.query);

  @override
  List<Object> get props => [query];
}

class UpdateJob extends HomeEvent {
  final int index;
  const UpdateJob(this.index);
  @override
  List<Object> get props => [index];
}

class HomeDataError extends HomeEvent {
  final String error;

  const HomeDataError(this.error);

  @override
  List<Object> get props => [error];
}
