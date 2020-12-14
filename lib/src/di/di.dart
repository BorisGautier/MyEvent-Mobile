import 'package:chopper/chopper.dart';
import 'package:get_it/get_it.dart';
import 'package:myevent/sharedPreference.dart';
import 'package:myevent/src/api/apiService.dart';
import 'package:myevent/src/api/user/userApiService.dart';
import 'package:myevent/src/api/user/userApiServiceFactory.dart';
import 'package:myevent/src/bloc/auth/auth_bloc.dart';
import 'package:myevent/src/bloc/login/login_bloc.dart';
import 'package:myevent/src/bloc/register/register_bloc.dart';
import 'package:myevent/src/bloc/tab/tab_bloc.dart';
import 'package:myevent/src/repositories/user/userRepository.dart';
import 'package:myevent/src/repositories/user/userRepositoryImpl.dart';
import 'package:myevent/src/utils/networkInfo.dart';
import 'package:myevent/src/utils/strings.dart';

final GetIt getIt = GetIt.instance;

Future<void> init() async {
  final chopper = ChopperClient(
    baseUrl: baseUrl,
    services: [
      // the generated service
      ApiService.create()
    ],
    converter: JsonConverter(),
  );

  final apiService = ApiService.create(chopper);

  //ApiService
  getIt.registerLazySingleton<UserApiService>(
      () => UserApiServiceFactory(apiService: apiService));

  //Utils
  getIt.registerLazySingleton<NetworkInfo>(() => NetworkInfo());
  getIt.registerLazySingleton<SharedPreferencesHelper>(
      () => SharedPreferencesHelper());

  //Repository
  getIt.registerFactory<UserRepository>(
    () => UserRepositoryImpl(
      userApiService: getIt(),
      networkInfo: getIt(),
      sharedPreferencesHelper: getIt(),
    ),
  );

  //Bloc
  getIt.registerFactory<AuthBloc>(() =>
      AuthBloc(userRepository: getIt(), sharedPreferencesHelper: getIt()));
  getIt.registerFactory<LoginBloc>(() => LoginBloc(
        userRepository: getIt(),
        sharedPreferencesHelper: getIt(),
      ));
  getIt.registerFactory<RegisterBloc>(() => RegisterBloc(
        userRepository: getIt(),
        sharedPreferencesHelper: getIt(),
      ));
  getIt.registerFactory<TabBloc>(() => TabBloc());
}
