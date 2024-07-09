import 'package:antauri/core/machine/interfaces/observer.dart';

abstract class UseCase<A, R> {
  Future<Stream<R>> buildStream(A params);

  void execute(A params, Observer<R> observer);
}
