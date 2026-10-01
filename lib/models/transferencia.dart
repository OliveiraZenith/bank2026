class PagamentoVaga {
  final double valor;
  final int numeroVaga;

  PagamentoVaga(this.valor, this.numeroVaga);

  @override
  String toString() {
    return "PagamentoVaga{valor: $valor, numeroVaga: $numeroVaga}";
  }
}
