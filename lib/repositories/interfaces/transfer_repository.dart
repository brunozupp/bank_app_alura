import 'package:bank_app_alura/models/transfer_model.dart';

abstract class TransferRepository {
  
  Future<bool> save(List<TransferModel> transfers);

  Future<List<TransferModel>> getAll();
}