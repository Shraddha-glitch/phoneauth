import 'package:autohiringapp/bloc/auth_cubit/auth_cubit.dart';
import 'package:autohiringapp/bloc/auth_cubit/auth_state.dart';
import 'package:autohiringapp/views/screens/home_screen.dart';
import 'package:autohiringapp/views/screens/sign_in_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:autohiringapp/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: BlocBuilder<AuthCubit, AuthState>(
          buildWhen: (oldState, newState) {
            return oldState is AuthInitialState;
          },
          builder: (context, state) {
            if (state is AuthLoggedInState) {
              return HomeScreen();
            } else if (state is AuthLoggedOutState) {
              return SignInScreen();
            } else {
              return Scaffold();
            }
          },
        ),
      ),
    );
  }
}
