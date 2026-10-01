import 'package:flutter/material.dart';
import '../../models/transferencia.dart';
import 'formulario.dart';
import 'package:intl/intl.dart';

class ListaTransferencias extends StatefulWidget {
  ListaTransferencias({super.key});

  final List<PagamentoVaga> _transferencias = [
    PagamentoVaga(12.00, 2),
    PagamentoVaga(18.50, 5),
  ];

  @override
  State<StatefulWidget> createState() {
    return ListaTransferenciaState();
  }
}

class ListaTransferenciaState extends State<ListaTransferencias> {
  static const _tituloAppBar = "Estacionamento";

  Future<void> _atualiza(PagamentoVaga? pagamentoRecebido) async {
    if (pagamentoRecebido != null) {
      await Future.delayed(const Duration(seconds: 1));
      setState(() {
        widget._transferencias.add(pagamentoRecebido);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(_tituloAppBar), centerTitle: true),
      body: ListView.builder(
        itemCount: widget._transferencias.length,
        itemBuilder: (context, indice) {
          final transferencia = widget._transferencias[indice];
          return ItemTransferencia(transferencia);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint("Botão + pressionado");
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const FormularioTransferencia();
              },
            ),
          ).then((transferenciaRecebida) => _atualiza(transferenciaRecebida));
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class ItemTransferencia extends StatelessWidget {
  final PagamentoVaga _pagamento;

  const ItemTransferencia(this._pagamento, {super.key});

  @override
  Widget build(BuildContext context) {
    final formato = NumberFormat.simpleCurrency(locale: 'pt_BR');
    return Card(
      child: ListTile(
        leading: const Icon(Icons.local_parking),
        title: Text(formato.format(_pagamento.valor)),
        subtitle: Text('Vaga ${_pagamento.numeroVaga}'),
      ),
    );
  }
}
