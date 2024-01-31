part of 'photo_bloc_bloc.dart';

abstract class PhotoBlocState extends Equatable {
  const PhotoBlocState();

  @override
  List<Object> get props => [];
}

class PhotoBlocInitial extends PhotoBlocState {}
