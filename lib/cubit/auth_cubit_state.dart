part of 'auth_cubit_cubit.dart';

abstract class AuthCubitState {}

class AuthCubitInitial extends AuthCubitState {}

class AuthLoadingState extends AuthCubitState {}

class AuthLoadedState extends AuthCubitState {}

class AuthErorState extends AuthCubitState {}
