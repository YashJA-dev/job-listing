import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joblisting/components/adaptive_circular_loading.dart';
import 'package:joblisting/configs/app_colors.dart';

import 'package:joblisting/model/job_model.dart';
import 'package:joblisting/repository/cache/hive_repo.dart';
import 'package:joblisting/screens/jobs_details/bloc/jobs_detail_bloc.dart';

class JobDetailPage extends StatefulWidget {
  final String jobId;

  const JobDetailPage({Key? key, required this.jobId}) : super(key: key);

  static Widget build(String jobId) {
    return BlocProvider(
      create: (context) =>
          JobDetailBloc(JobRepository())..add(LoadJobDetail(jobId)),
      child: JobDetailPage(jobId: jobId),
    );
  }

  @override
  State<JobDetailPage> createState() => _JobDetailPageState();
}

class _JobDetailPageState extends State<JobDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Job Details")),
      body: BlocBuilder<JobDetailBloc, JobDetailState>(
        builder: (context, state) {
          if (state is JobDetailLoading) {
            return const Center(child: AdaptiveCircularLoading());
          } else if (state is JobDetailError) {
            return Center(child: Text(state.message));
          } else if (state is JobDetailLoaded) {
            final job = state.job;
            return _buildJobDetail(context, job);
          } else {
            return const Center(child: Text("Something went wrong!"));
          }
        },
      ),
    );
  }

  Widget _buildJobDetail(BuildContext context, JobModel job) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (job.image != null)
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  job.image!,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          const SizedBox(height: 16),
          Text(
            job.name ?? "No Job Title",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            job.companyname ?? "No Company Name",
            style: TextStyle(fontSize: 18, color: Colors.grey[700]),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Icon(Icons.location_on, color: Colors.red),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  job.address ?? "No Address Provided",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            "About Job",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: SingleChildScrollView(
              child: Text(
                job.about ?? "No Description Available",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: ElevatedButton.icon(
              onPressed: () {
                context.read<JobDetailBloc>().add(ToggleFavorite(job));
              },
              icon: Icon(
                job.fav == true ? Icons.favorite : Icons.favorite_border,
                color: Colors.red,
              ),
              label: Text(
                job.fav == true ? "Remove Favorite" : "Mark as Favorite",
                style: const TextStyle(color: AppColors.white),
              ),
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
