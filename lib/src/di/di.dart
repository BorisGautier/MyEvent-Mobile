import 'package:chopper/chopper.dart';
import 'package:get_it/get_it.dart';
import 'package:myevent/sharedPreference.dart';
import 'package:myevent/src/api/apiService.dart';
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

  //Utils
  getIt.registerLazySingleton<NetworkInfo>(() => NetworkInfo());
  getIt.registerLazySingleton<SharedPreferencesHelper>(
      () => SharedPreferencesHelper());
}
