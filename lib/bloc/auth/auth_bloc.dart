import 'package:flutter_bloc/flutter_bloc.dart';

part "auth_event.dart";
part "auth_state.dart";

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthLoginEvent>((event, emit) async {
      emit(AuthLoadingState());
      try {
        if(event.password.length < 6){
          return emit(AuthErrorState("Password must be at least 6 characters long"));
        } else if (event.email.isEmpty || event.password.isEmpty) {
          return emit(AuthErrorState("Email and Password cannot be empty"));
        } else {
          await Future.delayed(const Duration(seconds: 2));
          return emit(AuthLoginSuccessState(email: event.email,password: event.password));
        }
      } catch(e) {
        emit(AuthErrorState("An error occurred: $e"));
      }
    });
    on<AuthLogoutEvent>((event, emit) async {
      emit(AuthLoadingState()); 
      try{
        await Future.delayed(const Duration(seconds: 2));
        return emit(AuthInitial());
      } catch(e) {
        emit(AuthErrorState("An error occurred: $e"));
      }
      
    });
  }

  
}