import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_responsive_login_ui/bloc/auth/auth_bloc.dart';
import 'package:flutter_responsive_login_ui/home_screen.dart';
import 'package:flutter_responsive_login_ui/widgets/gradient_button.dart';
import 'package:flutter_responsive_login_ui/widgets/login_field.dart';
import 'package:flutter_responsive_login_ui/widgets/social_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthErrorState){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.errorMessage),
            backgroundColor: Colors.red,
          ));
        }
        else if (state is AuthLoginSuccessState){
          Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
        }
      },
      builder: (context, state){
        if (state is AuthLoadingState){
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Image.asset('assets/images/signin_balls.png'),
                const Text(
                  'Sign in.',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 50,
                  ),
                ),
                const SizedBox(height: 50),
                const SocialButton(
                    iconPath: 'assets/svgs/g_logo.svg',
                    label: 'Continue with Google'),
                const SizedBox(height: 20),
                const SocialButton(
                  iconPath: 'assets/svgs/f_logo.svg',
                  label: 'Continue with Facebook',
                  horizontalPadding: 90,
                ),
                const SizedBox(height: 15),
                const Text(
                  'or',
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
                const SizedBox(height: 15),
                LoginField(
                  hintText: 'Email',
                  controller: emailController,
                ),
                const SizedBox(height: 15),
                LoginField(
                  hintText: 'Password',
                  controller: passwordController,
                ),
                const SizedBox(height: 20),
                GradientButton(
                  loginPressed: () {
                    BlocProvider.of<AuthBloc>(context).add(AuthLoginEvent(
                      email: emailController.text.trim(),
                      password: passwordController.text.trim(),
                    ));
                  },
                ),
              ],
            ),
          ),
        ),
      );
      }
 
    );
  }
}
