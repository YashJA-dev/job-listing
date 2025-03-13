part of 'jobs_detail_bloc.dart';

@immutable
abstract class JobDetailState extends Equatable {
  @override
  List<Object?> get props => [];
}

class JobDetailInitial extends JobDetailState {}

class JobDetailLoading extends JobDetailState {}

class JobDetailLoaded extends JobDetailState {
  final JobModel job;

  JobDetailLoaded(this.job);

  @override
  List<Object?> get props => [job];
}

class JobDetailError extends JobDetailState {
  final String message;

  JobDetailError(this.message);

  @override
  List<Object?> get props => [message];
}
