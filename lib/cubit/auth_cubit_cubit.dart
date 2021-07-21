import 'package:bloc/bloc.dart';

part 'auth_cubit_state.dart';

class AuthCubitCubit extends Cubit<AuthCubitState> {
  AuthCubitCubit() : super(AuthCubitInitial());

  void authUser(int password, {controler, lists}) {
    emit(AuthLoadingState());
    Future.delayed(const Duration(seconds: 2), () {
      password == 1111 ? emit(AuthLoadedState()) : emit(AuthErorState());
    });
  }

  void error() {
    Future.delayed(const Duration(milliseconds: 1500), () {
      emit(AuthCubitInitial());
    });
  }
}
