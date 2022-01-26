abstract class State {}

class SuccessState<T> extends State {
  final T data;

  SuccessState(this.data);
}

class ErrorState extends State {
  final String message;

  ErrorState(this.message);
}
