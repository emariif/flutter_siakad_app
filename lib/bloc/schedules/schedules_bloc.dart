import 'package:bloc/bloc.dart';
import 'package:flutter_siakad_app/data/datasources/schedule_remote_datasource.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/respone/schedule_response_modal.dart';

part 'schedules_event.dart';
part 'schedules_state.dart';
part 'schedules_bloc.freezed.dart';

class SchedulesBloc extends Bloc<SchedulesEvent, SchedulesState> {
  SchedulesBloc() : super(const _Initial()) {
    on<SchedulesEvent>((event, emit) async{
      emit(const _Loading());
      final response = await ScheduleRemoteDataSource().getSchedules();
      response.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r.data)),
      );
    });
  }
}
