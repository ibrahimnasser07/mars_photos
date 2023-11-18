part of 'mars_cubit.dart';

@immutable
abstract class MarsState {}

class MarsInitial extends MarsState {}

class RoverDataLoading extends MarsState {}

class RoverDataLoaded extends MarsState {}

class MarsPhotosLoading extends MarsState {}

class MarsPhotosLoaded extends MarsState {}
