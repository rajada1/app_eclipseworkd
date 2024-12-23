/// Classe de utilitário que simplifica o tratamento de erros.
///
/// Retorne um [Result] de uma função para indicar sucesso ou falha.
///
/// Um [Result] é um [Ok] com um valor do tipo [T]
/// ou um [Error] com uma [Exception].
///
/// Use [Result.ok] para criar um resultado bem-sucedido com um valor do tipo [T].
/// Use [Result.error] para criar um resultado de erro com uma [Exception].
sealed class Result<T> {
  const Result();

  /// Cria uma instância de Result contendo um valor
  factory Result.ok(T value) => Ok(value);

  /// Cria uma instância de Result contendo um erro
  factory Result.error(Exception error) => Error(error);
}

/// Subclasse de Result para valores
final class Ok<T> extends Result<T> {
  const Ok(this.value);

  /// Valor retornado no resultado
  final T value;
}

/// Subclasse de Result para erros
final class Error<T> extends Result<T> {
  const Error(this.error);

  /// Erro retornado no resultado
  final Exception error;
}