abstract class Failures {
  final String message;
  Failures(this.message);
}

class ServerFailure extends Failures {
  ServerFailure(String message) : super(message);
}

class LocalDatabaseFailure extends Failures {
  LocalDatabaseFailure(String message) : super(message);
}

class CacheFailure extends Failures {
  CacheFailure(String message) : super(message);
}
