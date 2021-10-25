import 'package:bank_app_alura/models/transfer_model.dart';
import 'package:bank_app_alura/utils/snackbar_utils.dart';
import 'package:flutter/material.dart';

class TransferListingPage extends StatefulWidget {
  const TransferListingPage({ Key? key }) : super(key: key);

  @override
  _TransferListingPageState createState() => _TransferListingPageState();
}

final List<TransferModel> transfers = List<TransferModel>.empty(growable: true);

class _TransferListingPageState extends State<TransferListingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Transferências"),
        centerTitle: true
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add
        ),
        onPressed: () async {

          var transferModel = await Navigator.of(context)
            .pushNamed("/transfer/insert") as TransferModel?;
          
          if(transferModel != null) {

            SnackbarUtils.showSnackbarSuccess(
              context: context,
              message: "Transferência adicionada"
            );

            setState(() {
              transfers.add(transferModel);
            });
          }
        }
      ),
      body: transfers.isEmpty 
        ? const Center(
          child: Text(
            "Nenhuma transferência disponível"
          ),
        ) 
        : ListView.builder(
          itemCount: transfers.length,
          itemBuilder: (_,index) {

            var transfer = transfers[index];

            return Card(
              child: ListTile(
                title: Text("Conta: ${transfer.account}"),
                subtitle: Text("Valor: R\$ ${transfer.value}"),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.edit
                      ),
                      onPressed: () {

                      }, 
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.delete
                      ),
                      onPressed: () {
                        
                      }, 
                    ),
                  ],
                ),
              ),
            );
          }
        ),
    );
  }
}