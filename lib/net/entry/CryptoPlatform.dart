import 'package:json_annotation/json_annotation.dart';

part 'CryptoPlatform.g.dart';

@JsonSerializable()
class CryptoPlatform {
  final String symbol;
  final double cap;
  final int num;

  CryptoPlatform(this.symbol, this.cap, this.num);

  //反序列化
  factory CryptoPlatform.fromJson(Map<String, dynamic> json) => _$CryptoPlatformFromJson(json);
  //序列化
  Map<String, dynamic> toJson() => _$CryptoPlatformToJson(this);

}
