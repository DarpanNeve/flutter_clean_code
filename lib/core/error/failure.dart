class Failure {
  final String message;

  Failure(
      [this.message = 'An unexpected error occurred. Please try again later.']);

  @override
  String toString() => "Server Exception: ${message.toString()}";
}
