import 'package:bank_app_alura/models/transfer_model.dart';
import 'package:bank_app_alura/repositories/transfer_repository_impl.dart';
import 'package:bank_app_alura/utils/snackbar_utils.dart';
import 'package:flutter/material.dart';

class TransferListingPage extends StatefulWidget {
  const TransferListingPage({ Key? key }) : super(key: key);

  @override
  _TransferListingPageState createState() => _TransferListingPageState();
}

class _TransferListingPageState extends State<TransferListingPage> {

  final _repository = TransferRepositoryImpl();

  final _list = List<TransferModel>.empty(growable: true);

  Future<bool> insert(TransferModel model) async {

    _list.add(model);

    return await _repository.save(_list);
  }

  Future<bool> edit({
    required TransferModel oldModel, 
    required TransferModel newModel
  }) async {
    
    _list.remove(oldModel);
    _list.add(newModel);

    return await _repository.save(_list);
  }

  Future<bool> remove(TransferModel model) async {
    
    _list.remove(model);

    return await _repository.save(_list);
  }

  Future<List<TransferModel>> getAll() async {
    return await _repository.getAll();
  }

  @override
  void initState() {
    super.initState();

    getAll().then((value) {
      setState(() {
        _list.addAll(value);
      });
    });
  }

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

            var result = await insert(transferModel);

            result
              ? SnackbarUtils.showSnackbarSuccess(
                  context: context,
                  message: "Transferência adicionada"
                )
              : SnackbarUtils.showSnackbarError(
                  context: context,
                  message: "Erro na inserção"
                );

            if(result) setState(() { });
          }
        }
      ),
      body: _list.isEmpty 
        ? const Center(
          child: Text(
            "Nenhuma transferência disponível"
          ),
        ) 
        : ListView.builder(
          itemCount: _list.length,
          itemBuilder: (_,index) {

            var transfer = _list[index];

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
                      onPressed: () async {

                        var newModel = await Navigator.of(context)
                          .pushNamed("/transfer/insert", arguments: transfer) as TransferModel?;
                        
                        if(newModel != null) {

                          var result = await edit(
                            newModel: newModel,
                            oldModel: transfer
                          );

                          result
                            ? SnackbarUtils.showSnackbarSuccess(
                                context: context,
                                message: "Transferência editada"
                              )
                            : SnackbarUtils.showSnackbarError(
                                context: context,
                                message: "Erro na edição"
                              );

                          if(result) setState(() { });
                        }
                      }, 
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.delete
                      ),
                      onPressed: () async {
                        
                        var result = await remove(transfer);

                        result
                          ? SnackbarUtils.showSnackbarSuccess(
                              context: context,
                              message: "Transferência removida"
                            )
                          : SnackbarUtils.showSnackbarError(
                              context: context,
                              message: "Erro ao remover"
                            );

                        if(result) setState(() { });
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