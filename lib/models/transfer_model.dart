import 'dart:convert';

class TransferModel {

  final int account;
  final double value;

  TransferModel({
    required this.account, 
    required this.value
  });

  Map<String, dynamic> toMap() {
    return {
      'account': account,
      'value': value,
    };
  }

  factory TransferModel.fromMap(Map<String, dynamic> map) {
    return TransferModel(
      account: map['account'],
      value: map['value'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TransferModel.fromJson(String source) => TransferModel.fromMap(json.decode(source));
}
