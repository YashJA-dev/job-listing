part of "home_bloc.dart";

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<JobModel> jobs;

  const HomeLoaded({required this.jobs});

  @override
  List<Object> get props => [jobs];

  HomeLoaded copyWith({List<JobModel>? jobs}) {
    return HomeLoaded(
      jobs: jobs ?? this.jobs,
    );
  }
}

class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);

  @override
  List<Object> get props => [message];
}
