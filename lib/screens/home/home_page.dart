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

import 'boc/home_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static Widget build() {
    return BlocProvider(
      create: (context) => HomeBloc(
        mockApiRepo: MockApiRepo(),
        jobsRepo: JobRepository(),
      )..add(LoadHomeData()),
      child: const HomePage(),
    );
  }

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithSearchSwitch(
        onChanged: (text) {
          context.read<HomeBloc>().add(SearchJobs(text));
        },
        appBarBuilder: (context) {
          return AppBar(
            title: Text("Jobs Listing"),
            actions: [
              AppBarSearchButton(),
              IconButton(
                  onPressed: () {
                    GoRouter.of(context).pushNamed(RoutesName.favoriteJobs);
                  },
                  icon: Icon(Icons.favorite)),
              IconButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(AuthLoggedOut());
                  },
                  icon: const Icon(Icons.logout))
            ],
          );
        },
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeInitial || state is HomeLoading) {
            return const Center(
              child: AdaptiveCircularLoading(),
            );
          } else if (state is HomeLoaded) {
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
                  trailing: IconButton(
                    onPressed: () {
                      context.read<HomeBloc>().add(UpdateJob(index));
                    },
                    icon: Icon(
                      (state.jobs[index].fav ?? false)
                          ? Icons.favorite
                          : Icons.favorite_border,
                    ),
                    color: (state.jobs[index].fav ?? false)
                        ? AppColors.red
                        : AppColors.black,
                  ),
                );
              },
            );
          }

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text((state is HomeError)
                  ? state.message
                  : "SomeThing Went Wrong"),
              IconButton(
                onPressed: () {
                  context.read<HomeBloc>().add(LoadHomeData());
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
