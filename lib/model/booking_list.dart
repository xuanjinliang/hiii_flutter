import 'package:json_annotation/json_annotation.dart';
part 'booking_list.g.dart';

@JsonSerializable()
class BookingList {
 String msg;
 num code;
 List<DataEntity> data;
 BookingList({
  this.msg,
  this.code,
  this.data
 });

  factory BookingList.fromJson(Map<String, dynamic> json) => _$BookingListFromJson(json);
  Map<String, dynamic> toJson() => _$BookingListToJson(this);
}

@JsonSerializable()
class DataEntity {
 String orderId;
 String title;
 String describe;
 num state;
 String startTime;
 String endTime;
 num money;
 DataEntity({
  this.orderId,
  this.title,
  this.describe,
  this.state,
  this.startTime,
  this.endTime,
  this.money
 });

  factory DataEntity.fromJson(Map<String, dynamic> json) => _$DataEntityFromJson(json);
  Map<String, dynamic> toJson() => _$DataEntityToJson(this);
}