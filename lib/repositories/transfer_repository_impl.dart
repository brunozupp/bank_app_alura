import 'package:bank_app_alura/models/transfer_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'interfaces/transfer_repository.dart';

class TransferRepositoryImpl implements TransferRepository {

  @override
  Future<List<TransferModel>> getAll() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    var listString = prefs.getStringList("transfers") ?? [];

    return listString.map((e) => TransferModel.fromJson(e)).toList();
  }

  @override
  Future<bool> save(List<TransferModel> transfers) async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    
    var listString = transfers.map((e) => e.toJson()).toList();

    return await prefs.setStringList("transfers", listString);
  }
}