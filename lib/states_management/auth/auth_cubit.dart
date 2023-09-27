import 'package:auth/auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_ordering_app/cache/local_store_contract.dart';
import 'package:food_ordering_app/models/User.dart';
// ignore: depend_on_referenced_packages
import 'package:async/async.dart';
import 'package:food_ordering_app/states_management/auth/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final ILocalStore localStore;
  AuthCubit(this.localStore) : super(InitialState());

  signin(IAuthService authService) async {
    _startLoading();
    final result = await authService.signIn();
    _setresultofAuthState(result);
  }

    signout(IAuthService authService) async {
    _startLoading();
    final token = await localStore.fetch();
    final result = await authService.signOut(token);
    if (result.asValue!.value) {
      localStore.delete(token);
      emit(SignOutSuccessState());
    } else {
      emit(ErrorState('Error signing out'));
    }
  }

  signup(ISignUpService signUpService, User user) async {
    _startLoading();
    final result = await signUpService.signUp(
      user.name,
      user.email,
      user.password,
    );
    _setresultofAuthState(result);
  }

  void _setresultofAuthState(Result<Token> result) {
    if (result.asError != null) {
      emit(ErrorState('Error'));
      return;
    }
    emit(AuthSuccessState(result.asValue!.value));
  }

  void _startLoading() {
    emit(LoadingState());
  }
  
}