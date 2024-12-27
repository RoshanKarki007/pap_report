import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:pap_report/feature/home/home_screen.dart';
import 'package:pap_report/feature/outlet/bloc/outlet_bloc.dart';
import 'package:pap_report/feature/outlet/repository/repo.dart';
import 'package:pap_report/feature/transaction/bloc/transaction_bloc.dart';
import 'package:pap_report/feature/transaction/repository/repo.dart';
import 'package:pap_report/widgets/custom_safe_area.dart';

final getIt = GetIt.instance;
void configureDependencies() {
  getIt.registerLazySingleton<OutletRepo>(() => OutletRepo());
  getIt.registerLazySingleton<TransactionRepo>(() => TransactionRepo());
}

void main() {
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<OutletBloc>(
          create: (context) => OutletBloc(getIt<OutletRepo>()),
        ),
        BlocProvider<TransactionBloc>(
          create: (context) => TransactionBloc(getIt<TransactionRepo>()),
        ),
      ],
      child: ScreenUtilInit(
          designSize: Size(MediaQuery.sizeOf(context).width,
              MediaQuery.sizeOf(context).height),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, _) {
            return MaterialApp(
              title: 'Flutter Demo',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                useMaterial3: true,
              ),
              home: const Homescreen(),
              builder: (context, child) => CustomSafeArea(
                child: child!,
              ),
            );
          }),
    );
  }
}
