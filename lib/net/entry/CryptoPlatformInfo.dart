import 'package:json_annotation/json_annotation.dart';

part 'CryptoPlatformInfo.g.dart';

@JsonSerializable()
class CryptoPlatformInfo {
  final String symbol;
  final double cap;

  CryptoPlatformInfo(this.symbol, this.cap);

  //反序列化
  factory CryptoPlatformInfo.fromJson(Map<String, dynamic> json) => _$CryptoPlatformInfoFromJson(json);
  //序列化
  Map<String, dynamic> toJson() => _$CryptoPlatformInfoToJson(this);
}
