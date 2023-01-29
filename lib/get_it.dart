import 'package:local_assignment/controller/person_bloc.dart';
import 'package:local_assignment/data/shared_pref/shared_pref.dart';
import 'package:get_it/get_it.dart';


final getIt = GetIt.instance;

void setup() {
  getIt.registerLazySingleton<SharedPrefHelper>(() => SharedPrefHelper());
  getIt.registerLazySingleton<PersonBloc>(() => PersonBloc());
}