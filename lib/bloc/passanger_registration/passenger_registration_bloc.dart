import 'dart:async';
import 'dart:io';
import 'package:autohiringapp/repositories/passenger_registration_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:image_picker/image_picker.dart';
part 'passenger_registration_event.dart';
part 'passenger_registration_state.dart';

class PassengerRegistrationBloc
    extends Bloc<PassengerRegistrationEvent, PassengerRegistrationState> {
  final PassengerRegistrationRepository passengerRegistrationRepository;
  PassengerRegistrationBloc({required this.passengerRegistrationRepository})
      : super(PassengerRegistrationInitial()) {
    on<PassengerRegistrationButtonClicked>((event, emit) async {
      emit(PassengerRegistrationProcess());
      try {
        bool? isSuccess = await passengerRegistrationRepository
            .registerPassenger(event.firstName, event.lastName);
        bool? isImageUploadSuccess = await passengerRegistrationRepository
            .uploadInfoWithImage(event.firstName, event.lastName, event.image);
        if (isSuccess! || isImageUploadSuccess!) {
          emit(PassengerRegistrationSuccess());
        } else {
          emit(
            const PassengerRegistrationFailed(error: 'Something went wrong'),
          );
        }
      } catch (e) {
        emit(
          PassengerRegistrationFailed(
            error: e.toString(),
          ),
        );
      }
    });
    on<PassengerRegistrationButtonNavigateEvent>(
        passengerRegistrationButtonNavigateEvent);
  }

  FutureOr<void> passengerRegistrationButtonNavigateEvent(
      PassengerRegistrationButtonNavigateEvent event,
      Emitter<PassengerRegistrationState> emit) {
    print('Navigate to home screen clicked');
  }
}
