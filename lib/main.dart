import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/view/screens/login_screen/login.dart';
import 'bloc/login_bloc/login_cubit.dart';
import 'bloc/news_home_bloc/news_home_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'bloc/sign_up_bloc/sign_up_cubit.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<FetchNewsCubit>(
          create: (BuildContext context) => FetchNewsCubit(),
        ),
        BlocProvider<SignUpCubit>(
          create: (BuildContext context) => SignUpCubit(),
        ),
        BlocProvider<LogInCubit>(
          create: (BuildContext context) => LogInCubit(),
        ),
      ],
      child: const MaterialApp(
        title: 'News App',
        home: LogInScreen(),
      ),
    );
  }
}
