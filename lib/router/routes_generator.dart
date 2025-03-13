import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:joblisting/bloc/auth_bloc/auth_bloc.dart';
import 'package:joblisting/screens/authentication/login/login_page.dart';
import 'package:joblisting/screens/authentication/signup/signup_page.dart';
import 'package:joblisting/screens/favorite_jobs/favorite_jobs_page.dart';
import 'package:joblisting/screens/home/home_page.dart';
import 'package:joblisting/screens/jobs_details/jobs_details_page.dart';
import 'routes_name.dart';

class RoutesGenerator {
  BuildContext context;
  RoutesGenerator(this.context);
  GoRouter getRoute() {
    final authState = context.read<AuthBloc>().state;
    return GoRouter(
      refreshListenable: GoRouterRefreshStream(context.read<AuthBloc>().stream),
      debugLogDiagnostics: true,
      initialLocation: RoutesName.logIn,
      redirect: (context, state) {
        final authState = context.read<AuthBloc>().state;
        log("Auth State: ${authState.runtimeType}");

        final bool isAuthenticated = authState is AuthAuthenticated;
        final bool isGoingToLogin = state.uri.toString() == RoutesName.logIn;
        final bool isGoingToSignup = state.uri.toString() == RoutesName.signUp;

        if (isAuthenticated && (isGoingToLogin || isGoingToSignup)) {
          return RoutesName.home;
        }
        if (!isAuthenticated &&
            protectedRoutes.contains(state.uri.toString())) {
          return RoutesName.logIn;
        }

        return null;
      },
      routes: [
        GoRoute(
          path: RoutesName.home,
          name: RoutesName.home,
          builder: (context, state) => HomePage.build(),
        ),
        GoRoute(
          path: RoutesName.logIn,
          name: RoutesName.logIn,
          builder: (context, state) => LoginPage.build(),
        ),
        GoRoute(
          path: RoutesName.signUp,
          name: RoutesName.signUp,
          builder: (context, state) => SignupPage.build(),
        ),
        GoRoute(
          path: RoutesName.favoriteJobs,
          name: RoutesName.favoriteJobs,
          builder: (context, state) => FavoriteJobsPage.build(),
        ),
        GoRoute(
          path: RoutesName.jobDetails,
          name: RoutesName.jobDetails,
          builder: (context, state) =>
              JobDetailPage.build(state.uri.queryParameters["id"] ?? ""),
        )
      ],
    );
  }

  final List<String> protectedRoutes = [
    RoutesName.home,
  ];
}

class GoRouterRefreshStream extends ChangeNotifier {
  final Stream<AuthState> stream;
  GoRouterRefreshStream(this.stream) {
    stream.listen((event) {
      notifyListeners(); // Notify GoRouter when AuthState changes
    });
  }
}
