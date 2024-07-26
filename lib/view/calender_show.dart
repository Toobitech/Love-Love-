import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../component/custom_button.dart';
import '../component/snackbar.dart';
import '../controller/user_controller.dart';
import '../helper/colors.dart';
import '../helper/spacer.dart';
import '../model/datetime_model.dart';

class CalendarDialogShow extends StatefulWidget {
  @override
  _CalendarDialogShowState createState() => _CalendarDialogShowState();
}

class _CalendarDialogShowState extends State<CalendarDialogShow> {
  String? formattedDate;
  final controller = Get.put(UserController());
  DateTime _setDateTime = DateTime.now();
  DateTime _targetDateTime = DateTime.now();
  late CalendarCarousel<Event> _calendarCarouselNoHeader;
  late EventList<Event> _markedDateMap = EventList<Event>(events: {});

  @override
  void initState() {
    super.initState();
    formattedDate = DateFormat('yyyy-MM-dd').format(_setDateTime);
    controller.getCalender(formattedDate!);
  }

  @override
  Widget build(BuildContext context) {
    Map<DateTime, List<Event>> selectedDatesMap = {
      _setDateTime: [
        Event(
          date: _setDateTime,
          icon: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(1000)),
              border: Border.all(color: Colors.blue, width: 2.0),
            ),
            child: const Icon(
              Icons.person,
              color: Colors.amber,
            ),
          ),
          dot: Container(
            margin: const EdgeInsets.symmetric(horizontal: 1.0),
            color: Colors.red,
            height: 5.0,
            width: 5.0,
          ),
        ),
      ]
    };

    _markedDateMap = EventList<Event>(events: selectedDatesMap);
    _calendarCarouselNoHeader = CalendarCarousel<Event>(
      todayBorderColor: Colors.red,
      onDayPressed: (DateTime date, List<Event> events) {
        setState(() {
          _setDateTime = date;
          formattedDate = DateFormat('yyyy-MM-dd').format(_setDateTime);
          print('Current Date $formattedDate');
          controller.getCalender(formattedDate!);
        });
      },
      daysHaveCircularBorder: true,
      showOnlyCurrentMonthDate: false,
      weekdayTextStyle: TextStyle(
        color: AppColors.pink,
      ),
      weekendTextStyle: TextStyle(
        color: AppColors.pink,
      ),
      thisMonthDayBorderColor: Colors.grey,
      weekFormat: false,
      height: 250.0,
      selectedDateTime: _setDateTime,
      targetDateTime: _targetDateTime,
      customGridViewPhysics: const NeverScrollableScrollPhysics(),
      markedDateCustomShapeBorder:
          CircleBorder(side: BorderSide(color: AppColors.pink, width: 3)),
      markedDateCustomTextStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: Colors.blue,
      ),
      showHeader: false,
      todayTextStyle: const TextStyle(
        color: Colors.black,
      ),
      todayButtonColor: AppColors.pink,
      selectedDayButtonColor: AppColors.pink,
      selectedDayTextStyle: TextStyle(
        color: AppColors.white,
      ),
      markedDatesMap: _markedDateMap,
      minSelectedDate: _setDateTime,
      maxSelectedDate:
          DateTime(_targetDateTime.year, _targetDateTime.month + 1, 20),
      prevDaysTextStyle: const TextStyle(
        fontSize: 16,
        color: Colors.grey,
      ),
      inactiveDaysTextStyle: const TextStyle(
        color: Colors.grey,
        fontSize: 16,
      ),
      onCalendarChanged: (DateTime date) {
        setState(() {
          _targetDateTime = date;
        });
      },
      onDayLongPressed: (DateTime date) {
        print('long pressed date $date');
      },
    );

    return Dialog(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  'Select Availability',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: AppColors.pink),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                bottom: 16.0,
                left: 16.0,
                right: 16.0,
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      DateFormat.yMMM().format(_targetDateTime),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              child: _calendarCarouselNoHeader,
            ),
            SizedBox(
              height: 120,
              child: Obx(() => controller.clrisLoading.value
                  ? Center(
                      child: CircularProgressIndicator(
                        color: AppColors.pink,
                      ),
                    )
                  : controller.selectedDatesTime
                          .where((p0) => p0.date == formattedDate)
                          .isNotEmpty
                      ? ListView.builder(
                          itemCount: controller.selectedDatesTime
                              .where((p0) => p0.date == formattedDate)
                              .length,
                          itemBuilder: (context, index) {
                            List<DateTimeModel> filteredList = controller
                                .selectedDatesTime
                                .where((p0) => p0.date == formattedDate)
                                .toList();

                            if (index < filteredList.length) {
                              DateTimeModel item = filteredList[index];

                              String formattedDateStr = index > 0 &&
                                      formattedDate ==
                                          filteredList[index - 1].date
                                  ? ""
                                  : DateFormat('yyyy-MM-dd')
                                      .format(DateTime.parse(formattedDate!));

                              return Center(
                                child: Column(
                                  children: [
                                    Text(
                                      "$formattedDateStr",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                        color: AppColors.pink,
                                      ),
                                    ),
                                    const SizedBox(height: 3),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            color:
                                                Colors.grey.withOpacity(0.5),
                                          ),
                                          child: Text(
                                            item.startTime ?? 'Start Time',
                                            style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          child: Text(
                                            'TO',
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.pink,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            color:
                                                Colors.grey.withOpacity(0.5),
                                          ),
                                          child: Text(
                                            item.endTime ?? 'End Time',
                                            style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 5),
                                          child: GestureDetector(
                                              onTap: () {
                                                print('delete Index Value');
                                                if (item.id != null) {
                                                  print('Calender ID${item.id}');
                                                  controller.deleteCalender(
                                                      item.id!);
                                                  controller.selectedDatesTime
                                                      .removeAt(index);
                                                } else {
                                                  print(
                                                      'Calender NOt ID${item.id}');
                                                  controller.selectedDatesTime
                                                      .removeAt(index);
                                                }
                                              },
                                              child: const Icon(
                                                Icons.delete,
                                                color: Colors.red,
                                                size: 15,
                                              )),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              return Container();
                            }
                          },
                        )
                      : Center(
                          child: SizedBox(
                            height: 120,
                            child: Column(
                              children: [
                                Text(
                                  "$formattedDate",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      color: AppColors.pink),
                                ),
                              ],
                            ),
                          ),
                        ))),
            Center(
              child: GestureDetector(
                onTap: () {
                  _showAlertDialog(context, formattedDate!);
                },
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: AppColors.pink, shape: BoxShape.circle),
                  child: Icon(
                    Icons.add,
                    size: 16,
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
            vertical(5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: CustomButton(
                title: 'Confirm',
                tap: () {
                  if (controller.postDatesTime.isNotEmpty) {
                    controller.postCalender(controller.postDatesTime.value);
                  } else {
                    showInSnackBar('Please Add New Dates.....',
                        color: Colors.red);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAlertDialog(BuildContext context, String currentDate) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 25, left: 25, right: 25),
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            title: const Center(child: Text('Set Your Time')),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Text(
                    "$currentDate",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: AppColors.pink),
                  ),
                ),
                Divider(
                  color: AppColors.pink,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Start Time'),
                    Obx(() => GestureDetector(
                          onTap: () {
                            _selectTime(context, true);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.5)),
                            child: Text(
                              controller.starttime.value.format(context),
                              style: const TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.normal),
                            ),
                          ),
                        )),
                  ],
                ),
                Divider(
                  color: AppColors.pink,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('End Time'),
                    Obx(() => GestureDetector(
                          onTap: () {
                            _selectTime(context, false);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.5)),
                            child: Text(
                              controller.endtime.value.format(context),
                              style: const TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.normal),
                            ),
                          ),
                        )),
                  ],
                )
              ],
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                ),
                child: CustomButton(
                  title: 'confirm',
                  tap: () {
                    bool containsStartTime = controller.selectedDatesTime.any(
                      (data) {
                        return data.endTime ==
                            controller.endtime.value.format(context);
                      },
                    );

                    if (containsStartTime) {
                      Get.back();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("This Time Already Declared"),
                          duration: Duration(seconds: 2),
                          backgroundColor: Colors.red,
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      );
                    } else {
                      DateTimeModel data = DateTimeModel(
                        date: formattedDate!,
                        startTime: controller.starttime.value.format(context),
                        endTime: controller.endtime.value.format(context),
                      );

                      Map<String, dynamic> jsonMap = data.toJson();

                      print(jsonMap);
                      controller.selectedDatesTime.add(data);
                      controller.postDatesTime.add(data);
                      print('Your Date And Time ${controller.selectedDatesTime}');
                      Get.back();
                    }
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _selectTime(BuildContext context, bool isStartTime) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime:
          isStartTime ? controller.starttime.value : controller.endtime.value,
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        if (isStartTime) {
          controller.starttime.value = picked;
          controller.endtime.value = TimeOfDay(
            hour: (picked.hour + 1) % 24,
            minute: picked.minute,
          );
        } else {
          controller.endtime.value = picked;
        }
      });
    }
  }
}
