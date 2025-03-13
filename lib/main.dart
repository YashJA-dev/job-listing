import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:joblisting/bloc/auth_bloc/auth_bloc.dart';
import 'package:joblisting/configs/app_colors.dart';
import 'package:joblisting/firebase_options.dart';
import 'package:joblisting/repository/google_auth_repo.dart';
import 'package:flutter/material.dart';
import 'package:joblisting/router/routes_generator.dart';

import 'model/job_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // NotificationHandler().init();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final authBloc = AuthBloc(
    googleAuthRepo: GoogleAuthRepo(
      auth: FirebaseAuth.instance,
      googleSignIn: GoogleSignIn(),
    ),
  )..add(AuthCheckLoggedIn());

  await authBloc.stream.firstWhere((state) => state is! AuthInitial);
  await Hive.initFlutter();
  Hive.registerAdapter(JobModelAdapter());

  await Hive.openBox<JobModel>('jobs');

  runApp(
    MultiBlocProvider(
      providers: [BlocProvider(create: (create) => authBloc)],
      child: const JobsListingApp(),
    ),
  );
}

class JobsListingApp extends StatefulWidget {
  const JobsListingApp({super.key});

  @override
  State<JobsListingApp> createState() => _JobsListingAppState();
}

class _JobsListingAppState extends State<JobsListingApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: true,
      theme: ThemeData(
        primaryColor: AppColors.primary,
        textTheme: GoogleFonts.robotoTextTheme(),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            backgroundColor: MaterialStateProperty.all(AppColors.primary),
          ),
        ),
      ),
      routerConfig: RoutesGenerator(context).getRoute(),
    );
  }
}
