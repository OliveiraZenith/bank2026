import 'package:flutter/material.dart';
import '../../components/editor.dart';
import '../../models/transferencia.dart';

class FormularioTransferencia extends StatefulWidget {
  const FormularioTransferencia({super.key});

  @override
  State<StatefulWidget> createState() {
    return FormularioTransferenciaState();
  }
}

class FormularioTransferenciaState extends State<FormularioTransferencia> {
  final TextEditingController _controladorCampoNumeroVaga =
      TextEditingController();
  final TextEditingController _controladorCampoValor = TextEditingController();

  static const _tituloAppBar = 'Novo estacionamento';
  static const _rotuloCampoValor = 'Valor do estacionamento';
  static const _dicaCampoValor = '0,00';

  static const _rotuloCampoNumeroVaga = 'Número da vaga';
  static const _dicaCampoNumeroVaga = 'Ex.: 12';
  static const _textoBotaoConfirmar = 'Confirmar';

  @override
  void dispose() {
    _controladorCampoNumeroVaga.dispose();
    _controladorCampoValor.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_tituloAppBar)),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Editor(
              controlador: _controladorCampoNumeroVaga,
              rotulo: _rotuloCampoNumeroVaga,
              dica: _dicaCampoNumeroVaga,
              icone: Icons.local_parking,
              tipoTeclado: TextInputType.number,
            ),

            Editor(
              controlador: _controladorCampoValor,
              rotulo: _rotuloCampoValor,
              dica: _dicaCampoValor,
              icone: Icons.payments_outlined,
              tipoTeclado: const TextInputType.numberWithOptions(decimal: true),
            ),

            ElevatedButton(
              onPressed: () {
                debugPrint("Clicou aqui...");
                _criaTransferencia(
                  context,
                  _controladorCampoNumeroVaga,
                  _controladorCampoValor,
                );
              },
              child: const Text(_textoBotaoConfirmar),
            ),
          ],
        ),
      ),
    );
  }
}

void _criaTransferencia(
  BuildContext context,
  TextEditingController controladorCampoNumeroVaga,
  TextEditingController controladorCampoValor,
) {
  final int? numeroVaga = int.tryParse(controladorCampoNumeroVaga.text.trim());
  final double? valor = double.tryParse(
    controladorCampoValor.text.trim().replaceAll(',', '.'),
  );

  if (numeroVaga == null || numeroVaga <= 0 || valor == null || valor <= 0) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Informe uma vaga e um valor válidos.')),
    );
    return;
  }

  Navigator.pop(context, PagamentoVaga(valor, numeroVaga));
}
