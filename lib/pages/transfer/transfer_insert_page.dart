import 'package:bank_app_alura/models/transfer_model.dart';
import 'package:bank_app_alura/utils/snackbar_utils.dart';
import 'package:bank_app_alura/widgets/form_field_widget.dart';
import 'package:flutter/material.dart';

class TransferInsertPage extends StatelessWidget {
  TransferInsertPage({ Key? key }) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  final _accountController = TextEditingController();
  final _valueController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final transferModel = ModalRoute.of(context)!.settings.arguments as TransferModel?;
    _accountController.text = transferModel?.account.toString() ?? "";
    _valueController.text = transferModel?.value.toString() ?? "";

    return Scaffold(
      appBar: AppBar(
        title: const Text("Transferências"),
        centerTitle: true
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [

              FormFieldWidget(
                controller: _accountController, 
                label: "Conta",
                hint: "0000",
                keyboardType: TextInputType.number,
                maxLength: 4,
                prefixIcon: const Icon(
                  Icons.account_balance_wallet
                ),
                validator: (value) {
                  if(value == null || value == '') {
                    return "Número da conta obrigatório";
                  }

                  if(value.length != 4) {
                    return "Número da conta deve possuir 4 dígitos númericos";
                  }

                  RegExp regExp = RegExp(r"[a-zA-Z]");

                  if(regExp.hasMatch(value)) {
                    return "Não pode conter letras, apenas números";
                  }

                  return null;
                },
              ),

              FormFieldWidget(
                controller: _valueController, 
                label: "Valor",
                hint: "19.00",
                keyboardType: TextInputType.number,
                prefixIcon: const Icon(
                  Icons.monetization_on
                ),
                validator: (value) {
                  if(value == null || value == '') {
                    return "Número da conta obrigatório";
                  }

                  RegExp regExp = RegExp(r"[a-zA-Z]");

                  if(regExp.hasMatch(value)) {
                    return "Não pode conter letras, apenas números";
                  }

                  return null;
                },
              ),

              const SizedBox(
                height: 20,
              ),

              ConstrainedBox(
                constraints: const BoxConstraints(
                  minWidth: 100
                ),
                child: ElevatedButton(
                  child: const Text(
                    "Salvar"
                  ),
                  onPressed: () {

                    if(!_formKey.currentState!.validate()) {
                      SnackbarUtils.showSnackbarError(
                        context: context, 
                        message: "As validações não foram atendidas"
                      );
                      return;
                    }

                    final account = int.tryParse(_accountController.text);
                    final value = double.tryParse(_valueController.text.replaceAll(",", "."));

                    if(account == null || value == null) {
                      SnackbarUtils.showSnackbarError(
                        context: context, 
                        message: "Não foi possível ler os valores"
                      );
                      return;
                    }

                    final transferModel = TransferModel(
                      account: account, 
                      value: value
                    );

                    Navigator.of(context).pop(transferModel);
                  }, 
                  
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}