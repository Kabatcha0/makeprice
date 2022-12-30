import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makeprice/layout/cubit/cubit.dart';
import 'package:makeprice/layout/cubit/states.dart';
import 'package:makeprice/modules/addbranches.dart';
import 'package:makeprice/modules/splash.dart';
import 'package:makeprice/shared/local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PriceCubit()..create(),
      child: BlocConsumer<PriceCubit, PriceStates>(
        builder: (context, state) => MaterialApp(
          theme: ThemeData(),
          title: 'Make Price',
          debugShowCheckedModeBanner: false,
          home: const Splash(),
        ),
        listener: (context, state) {},
      ),
    );
  }
}
