import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_responsive_login_ui/bloc/auth/auth_bloc.dart";

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener:(context, state) {
        if (state is AuthInitial){
          Navigator.pop(context);
        }
      },
      builder:(context, state) {
        if (state is AuthLoadingState){
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        else if (state is AuthLoginSuccessState) {
          return Scaffold(
          appBar: AppBar(
            title: const Text("Home"),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Welcome to the Home Screen!\nYour email is: ${state.email}\nYour password is: ${state.password}"),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<AuthBloc>(context).add(AuthLogoutEvent());
                  },
                  child: const Text("Logout"),
                ),
              ],
            ),
          ),
        );
        } else {
          return const Center(
            child: Text(""),
          );
        }
      },
    );
  }
}