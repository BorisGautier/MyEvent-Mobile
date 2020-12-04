import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:myevent/simpleAppObserver.dart';
import 'package:myevent/src/app.dart';
import 'package:myevent/src/bloc/auth/auth_bloc.dart';
import 'package:myevent/src/di/di.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build();
  Bloc.observer = SimpleBlocObserver();
  await di.init();

  // runApp(MyApp());

  runApp(BlocProvider(
      create: (_) => di.getIt<AuthBloc>()..add(AuthStarted()), child: MyApp()));
}
