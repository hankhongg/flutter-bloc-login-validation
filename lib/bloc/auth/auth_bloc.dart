import 'package:flutter_bloc/flutter_bloc.dart';

part "auth_event.dart";
part "auth_state.dart";

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    void _onAuthLoginEvent(AuthLoginEvent event, Emitter emit) async {
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
    }
    void _onAuthLogoutEvent( AuthLogoutEvent event,Emitter emit) async {
      emit(AuthLoadingState()); 
      try{
        await Future.delayed(const Duration(seconds: 2));
        return emit(AuthInitial());
      } catch(e) {
        emit(AuthErrorState("An error occurred: $e"));
      }
      
    }


    on<AuthLoginEvent>(_onAuthLoginEvent);
    on<AuthLogoutEvent>(_onAuthLogoutEvent);

    @override
    void onChange(Change<AuthState> change) {
      super.onChange(change);
      print("Current State: ${change.currentState}");
      print("Next State: ${change.nextState}");
    }

    @override
    void onError(Object error, StackTrace stackTrace) {
      super.onError(error, stackTrace);
      print("Error: $error");
      print("Stack Trace: $stackTrace");
    }
  }

  
}