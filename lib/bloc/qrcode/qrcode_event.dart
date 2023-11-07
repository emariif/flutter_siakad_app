part of 'qrcode_bloc.dart';

@freezed
class QrcodeEvent with _$QrcodeEvent {
  const factory QrcodeEvent.started() = _Started;
  const factory QrcodeEvent.scanneed(String data) = _Scanned;
}