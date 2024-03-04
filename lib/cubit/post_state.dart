part of 'post_cubit.dart';

abstract class PostState extends Equatable {
  const PostState();
}

class PostInitial extends PostState {
  @override
  List<Object> get props => [];
}

class PostLoading extends PostState {
  @override
  List<Object?> get props => [];
}

class PostSuccess extends PostState {
  final List<Post> list;

  const PostSuccess({required this.list});

  @override
  List<Object> get props => [list];
}

class PostError extends PostState {
  final String message;

  const PostError({required this.message});

  @override
  List<Object> get props => [];
}
