import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_siakad_app/bloc/schedules/schedules_bloc.dart';
import 'package:flutter_siakad_app/common/extensions/date_time_ext.dart';

import '../../common/components/custom_scaffold.dart';
import '../../common/constants/images.dart';
import 'models/course_schedule_model.dart';
import 'widgets/course_schedule_tile.dart';
import 'widgets/course_with_image.dart';

class JadwalMatkulPage extends StatefulWidget {
  const JadwalMatkulPage({Key? key}) : super(key: key);

  @override
  State<JadwalMatkulPage> createState() => _JadwalMatkulPageState();
}

class _JadwalMatkulPageState extends State<JadwalMatkulPage> {
  @override
  void initState() {
    super.initState();
    context.read<SchedulesBloc>().add(const SchedulesEvent.getSchedules());
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: ListView(
        padding: const EdgeInsets.all(24.0),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          const Text(
            "Jadwal MK",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CourseWithImage(
                  name: 'Basis Data',
                  imagePath: Images.basisData,
                ),
                CourseWithImage(
                  name: 'Algoritma',
                  imagePath: Images.algoritma,
                ),
                CourseWithImage(
                  name: 'RPL',
                  imagePath: Images.rpl,
                ),
              ],
            ),
          ),
          const SizedBox(height: 12.0),
          Text(
            DateTime.now().toFormattedDateWithDay(),
            style: const TextStyle(
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 18.0),
          Expanded(
            child: BlocBuilder<SchedulesBloc, SchedulesState>(
              builder: (context, state) {
                return state.maybeWhen(
                  orElse: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  loaded: (data) {
                    return ListView.builder(
                      itemCount: data.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return CourseScheduleTile(
                          data: CourseScheduleModel(
                            dateStart: DateTime.now(),
                            longTimeTeaching: 90,
                            course: data[index].subject.title,
                            lecturer: data[index].subject.lecturer.name,
                            description: data[index].ruangan,
                            startTime: data[index].jamMulai,
                            endTime: data[index].jamSelesai,
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
