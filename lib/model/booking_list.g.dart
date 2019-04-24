// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingList _$BookingListFromJson(Map<String, dynamic> json) {
  return BookingList(
      msg: json['msg'] as String,
      code: json['code'] as num,
      data: (json['data'] as List)
          ?.map((e) =>
              e == null ? null : DataEntity.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$BookingListToJson(BookingList instance) =>
    <String, dynamic>{
      'msg': instance.msg,
      'code': instance.code,
      'data': instance.data
    };

DataEntity _$DataEntityFromJson(Map<String, dynamic> json) {
  return DataEntity(
      orderId: json['orderId'] as String,
      title: json['title'] as String,
      describe: json['describe'] as String,
      state: json['state'] as num,
      startTime: json['startTime'] as String,
      endTime: json['endTime'] as String,
      money: json['money'] as num);
}

Map<String, dynamic> _$DataEntityToJson(DataEntity instance) =>
    <String, dynamic>{
      'orderId': instance.orderId,
      'title': instance.title,
      'describe': instance.describe,
      'state': instance.state,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'money': instance.money
    };
