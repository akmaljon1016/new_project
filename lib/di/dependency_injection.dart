import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:new_project/cubit/post_cubit.dart';
import 'package:new_project/network_info.dart';

final di = GetIt.instance;

Future<void> init() async {
  final Dio dio = Dio();
  di.registerLazySingleton(() => dio);

  InternetConnectionChecker internetConnectionChecker =
      InternetConnectionChecker();
  di.registerLazySingleton(() => internetConnectionChecker);
  di.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(internetConnectionChecker: di()));

  di.registerFactory(() => PostCubit(dio: di(), networkInfo: di()));
}
