import 'package:json_annotation/json_annotation.dart';

part 'CryptoFavorite.g.dart';

@JsonSerializable()
class CryptoFavorite {
  final String symbol;

  CryptoFavorite(this.symbol);

  //反序列化
  factory CryptoFavorite.fromJson(Map<String, dynamic> json) => _$CryptoFavoriteFromJson(json);
  //序列化
  Map<String, dynamic> toJson() => _$CryptoFavoriteToJson(this);
}
