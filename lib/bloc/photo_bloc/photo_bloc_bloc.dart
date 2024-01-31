import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'photo_bloc_event.dart';
part 'photo_bloc_state.dart';

class PhotoBlocBloc extends Bloc<PhotoBlocEvent, PhotoBlocState> {
  PhotoBlocBloc() : super(PhotoBlocInitial()) {
    on<PhotoBlocEvent>((event, emit) {});
  }
}
