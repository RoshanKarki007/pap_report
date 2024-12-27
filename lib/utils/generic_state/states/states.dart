abstract class GenericState<T> {
  T? dataOrNull() {
    final state = this;
    if (state case Success()) {
      return state.data;
    }
    return null;
  }
}

class Empty<T> extends GenericState<T> {
  final T? data;
  Empty({this.data});
}

class Loading<T> extends GenericState<T> {
  final T? data;
  Loading({this.data});
}

class Success<T> extends GenericState<T> {
  final T data;

  Success(this.data);
}

class Error<T> extends GenericState<T> {
  final String message;
  final int? statusCode;

  Error(this.message, {this.statusCode});
}
