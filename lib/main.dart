import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobize_app/config/routes/app_routes.dart';
import 'package:mobize_app/config/themes/app_theme.dart';
import 'package:mobize_app/features/get_%20leaderboard/presentation/cubit/get_leaderboard_cubit.dart';
import 'package:mobize_app/features/post_result/presentation/cubit/post_result_cubit.dart';
import 'package:mobize_app/features/sing_up/presentation/cubit/sing_up_cubit.dart';
import 'package:mobize_app/firebase_options.dart';
import 'package:mobize_app/injection_container/injection_container.dart' as di;
import 'package:onesignal_flutter/onesignal_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize dependency injection
  await di.init();

  WidgetsFlutterBinding.ensureInitialized();
// tests
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
  OneSignal.initialize("77a870fe-3f9f-450a-9910-5d861f12bfe9");
  OneSignal.Notifications.requestPermission(true);
  // Run the app
  runApp(const StartApp());
}

class StartApp extends StatefulWidget {
  const StartApp({super.key});

  @override
  State<StartApp> createState() => _StartAppState();
}

class _StartAppState extends State<StartApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SingUpCubit>(
          create: (context) => di.sl<SingUpCubit>(),
        ),
        BlocProvider<PostResultCubit>(
          create: (_) => di.sl<PostResultCubit>(),
        ),
        BlocProvider<GetLeaderboardCubit>(
          create: (_) => di.sl<GetLeaderboardCubit>(),
        ),
      ],
      child: MaterialApp(
        theme: appTheme(),
        initialRoute: Routes.initialRoute,
        onGenerateRoute: AppRoutes.onGenerateRoute,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
