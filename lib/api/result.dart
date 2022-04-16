class Result<T, U> {
  U? _error;
  T? _value;

  Result.success(T value) {
    _value = value;
  }

  Result.error(U error) {
    _error = error;
  }

  bool isError() {
    return _value == null;
  }

  bool isSuccess() {
    return _value != null;
  }

  T getValue() {
    if (_value == null) throw NullThrownError();
    return _value!;
  }

  U getErrorMsg() {
    if (_error == null) throw NullThrownError();
    return _error!;
  }
}

class DataError {
  final String message;
  final int errorCode;

  DataError(this.message, this.errorCode);
}
