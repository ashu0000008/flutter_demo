import 'package:json_annotation/json_annotation.dart';

part 'CryptoPercent.g.dart';

@JsonSerializable()
class CryptoPercent {
  final String date;
  final double percent;

  CryptoPercent(this.date, this.percent);

//反序列化
  factory CryptoPercent.fromJson(Map<String, dynamic> json) => _$CryptoPercentFromJson(json);
  //序列化
  Map<String, dynamic> toJson() => _$CryptoPercentToJson(this);
}
