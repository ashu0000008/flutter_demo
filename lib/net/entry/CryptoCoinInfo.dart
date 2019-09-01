import 'package:json_annotation/json_annotation.dart';

part 'CryptoCoinInfo.g.dart';

@JsonSerializable()
class CryptoCoin {
  final String symbol;
  final double cap;

  CryptoCoin(this.symbol, this.cap);

  //反序列化
  factory CryptoCoin.fromJson(Map<String, dynamic> json) => _$CryptoCoinFromJson(json);
  //序列化
  Map<String, dynamic> toJson() => _$CryptoCoinToJson(this);
}
