part of 'passenger_registration_bloc.dart';

abstract class PassengerRegistrationEvent extends Equatable {
  const PassengerRegistrationEvent();

  @override
  List<Object> get props => [];
}

class PassengerRegistrationButtonClicked extends PassengerRegistrationEvent {
  final String firstName;
  final String lastName;
  final image;

  const PassengerRegistrationButtonClicked({
    required this.firstName,
    required this.lastName,
    this.image,
  });
  @override
  List<Object> get props => [firstName, lastName, image!];
}

class PassengerRegistrationButtonNavigateEvent
    extends PassengerRegistrationEvent {}
