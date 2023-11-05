
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_siakad_app/data/datasources/khs_remote_datasource.dart';
import 'package:flutter_siakad_app/data/models/respone/khs_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'khs_event.dart';
part 'khs_state.dart';
part 'khs_bloc.freezed.dart';

class KhsBloc extends Bloc<KhsEvent, KhsState> {
  KhsBloc() : super(const _Initial()) {
    on<_GetKhs>((event, emit) async {
      emit(const _Loading());
      final response = await KhsRemoteDataSource().getKhs();
      response.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r.data)),
      );
    });
  }
}
