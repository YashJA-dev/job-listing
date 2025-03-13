
part of 'jobs_detail_bloc.dart';

@immutable
abstract class JobDetailEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadJobDetail extends JobDetailEvent {
  final String jobId;

  LoadJobDetail(this.jobId);

  @override
  List<Object?> get props => [jobId];
}

class ToggleFavorite extends JobDetailEvent {
  final JobModel job;

  ToggleFavorite(this.job);

  @override
  List<Object?> get props => [job];
}
