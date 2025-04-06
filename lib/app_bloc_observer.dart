import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc){
    super.onCreate(bloc);
    print("Bloc Created: ${bloc.runtimeType}");
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print("Bloc Changed: ${bloc.runtimeType}");
    print("Current State: ${change.currentState}");
    print("Next State: ${change.nextState}");
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    print("Bloc Event: ${bloc.runtimeType}");
    print("Event: $event");
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print("Bloc Transition: ${bloc.runtimeType}");
    print("Transition: $transition");
  }
}