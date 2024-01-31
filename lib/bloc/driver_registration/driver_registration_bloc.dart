import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'driver_registration_event.dart';
part 'driver_registration_state.dart';

class DriverRegistrationBloc extends Bloc<DriverRegistrationEvent, DriverRegistrationState> {
  DriverRegistrationBloc() : super(DriverRegistrationInitial()) {
    on<DriverRegistrationEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
