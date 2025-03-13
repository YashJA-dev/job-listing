import 'package:app_bar_with_search_switch/app_bar_with_search_switch.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:joblisting/bloc/auth_bloc/auth_bloc.dart';
import 'package:joblisting/components/adaptive_circular_loading.dart';
import 'package:joblisting/configs/app_colors.dart';
import 'package:joblisting/extentions/list_extension.dart';
import 'package:joblisting/repository/base_api_repo.dart';
import 'package:joblisting/repository/cache/hive_repo.dart';
import 'package:joblisting/router/routes_name.dart';
import 'package:joblisting/screens/authentication/login/login_page.dart';
import 'package:joblisting/screens/authentication/signup/signup_page.dart';

import 'boc/favorite_jobs_bloc.dart';

class FavoriteJobsPage extends StatefulWidget {
  const FavoriteJobsPage({super.key});

  static Widget build() {
    return BlocProvider(
      create: (context) => FavoriteJobsBloc(
        mockApiRepo: MockApiRepo(),
        jobsRepo: JobRepository(),
      )..add(LoadFavoriteJobsData()),
      child: const FavoriteJobsPage(),
    );
  }

  @override
  State<FavoriteJobsPage> createState() => _FavoriteJobsPageState();
}

class _FavoriteJobsPageState extends State<FavoriteJobsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithSearchSwitch(
        onChanged: (text) {
          context.read<FavoriteJobsBloc>().add(SearchJobs(text));
        },
        appBarBuilder: (context) {
          return AppBar(
            title: Text("Favorite Jobs"),
            actions: [
              AppBarSearchButton(),
            ],
          );
        },
      ),
      body: BlocBuilder<FavoriteJobsBloc, FavoriteJobsState>(
        builder: (context, state) {
          if (state is FavoriteJobsInitial || state is FavoriteJobsLoading) {
            return const Center(
              child: AdaptiveCircularLoading(),
            );
          } else if (state is FavoriteJobsLoaded) {
            if (state.jobs.isEmpty) {
              return const Center(
                child: Text("No Favorite Jobs Found"),
              );
            }
            return ListView.builder(
              itemCount: state.jobs.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    GoRouter.of(context)
                        .pushNamed(RoutesName.jobDetails, queryParameters: {
                      "id": state.jobs[index].id,
                    });
                  },
                  leading: CircleAvatar(
                    foregroundImage:
                        CachedNetworkImageProvider(state.jobs[index].image!),
                  ),
                  title: Text(state.jobs[index].name ?? ""),
                  subtitle: Text(state.jobs[index].companyname ?? ""),
                );
              },
            );
          }

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text((state is FavoriteJobsError)
                  ? state.message
                  : "SomeThing Went Wrong"),
              IconButton(
                onPressed: () {
                  context.read<FavoriteJobsBloc>().add(LoadFavoriteJobsData());
                },
                icon: const Icon(Icons.refresh_rounded),
              ),
            ].separator(8),
          );
        },
      ),
    );
  }
}
