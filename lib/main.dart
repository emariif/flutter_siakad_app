import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_siakad_app/bloc/khs/khs_bloc.dart';
import 'package:flutter_siakad_app/bloc/login/login_bloc.dart';
import 'package:flutter_siakad_app/bloc/qrcode/qrcode_bloc.dart';
import 'package:flutter_siakad_app/bloc/schedules/schedules_bloc.dart';
import 'package:flutter_siakad_app/data/datasources/auth_local_datasource.dart';
import 'package:flutter_siakad_app/pages/auth/auth_page.dart';
import 'package:flutter_siakad_app/pages/auth/splash_page.dart';
import 'package:flutter_siakad_app/pages/mahasiswa/mahasiswa_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => KhsBloc(),
        ),
        BlocProvider(
          create: (context) => SchedulesBloc(),
        ),
        BlocProvider(
          create: (context) => QrcodeBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: FutureBuilder(
          future: AuthLocalDatasource().isLogin(),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data!) {
              return BlocProvider(
                create: (context) => KhsBloc(),
                child: MahasiswaPage(),
              );
            } else {
              return const AuthPage();
            }
          },
        ),
      ),
    );
  }
}
