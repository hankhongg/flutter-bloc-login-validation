part of "auth_bloc.dart";

abstract class AuthState {} 

class AuthInitial extends AuthState {}

class AuthErrorState extends AuthState {
  final String errorMessage;

  AuthErrorState(this.errorMessage);
}

class AuthLoginSuccessState extends AuthState {
  final String email;
  final String password;

  AuthLoginSuccessState({required this.email,required this.password});
}

class AuthLoadingState extends AuthState {}