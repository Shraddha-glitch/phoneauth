part of 'passenger_registration_bloc.dart';

abstract class PassengerRegistrationState extends Equatable {
  const PassengerRegistrationState();

  @override
  List<Object> get props => [];
}

class PassengerRegistrationInitial extends PassengerRegistrationState {}

class PassengerRegistrationProcess extends PassengerRegistrationState {}

class PassengerRegistrationSuccess extends PassengerRegistrationState {}

class PassengerRegistrationFailed extends PassengerRegistrationState {
  final String error;
  const PassengerRegistrationFailed({required this.error});
  @override
  List<Object> get props => [error];
}
