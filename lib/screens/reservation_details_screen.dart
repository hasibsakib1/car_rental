import 'dart:io';

import 'package:car_rental/utils/ui_component/common_form_field.dart';
import 'package:car_rental/utils/ui_component/content_box_outlined.dart';
import 'package:car_rental/utils/ui_component/next_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../controller/provider_controller.dart';
import '../utils/constants.dart';
import '../utils/ui_component/title_with_divider.dart';
import 'customer_information_screen.dart';

class ReservationDetailsScreen extends ConsumerStatefulWidget {
  const ReservationDetailsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ReservationDetailsScreenState();
}

class _ReservationDetailsScreenState
    extends ConsumerState<ReservationDetailsScreen> {
  final TextEditingController idController = TextEditingController();
  final TextEditingController pickUpDateController = TextEditingController();
  final TextEditingController returnDateController = TextEditingController();
  final TextEditingController discountController = TextEditingController();

  String duration = '0 Days';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: toolbarHeight.height),
              const TitleWithDivider(title: 'Reservation Details'),
              const SizedBox(height: 20),
              ContentBoxOutlined(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CommonFormField(
                        formTitle: 'Reservation ID',
                        controller: idController,
                        isDigitsOnly: true),
                    dateTimePicker(
                        context, 'Pickup Date', pickUpDateController),
                    dateTimePicker(
                        context, 'Return Date', returnDateController),
                    Row(
                      children: [
                        const Text(
                          'Duration',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(width: 30),
                        Expanded(
                          child: ContentBoxOutlined(
                            child: Center(
                              child: Text(duration),
                            ),
                          ),
                        ),
                      ],
                    ),
                    CommonFormField(
                        formTitle: 'Discount',
                        controller: discountController,
                        isDigitsOnly: true),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              NextButton(
                  nextButtonAction: () => nextButtonAction(context, ref)),
            ],
          ),
        ),
      ),
    );
  }

  void nextButtonAction(BuildContext context, WidgetRef ref) {
    if (idController.text.isEmpty ||
        pickUpDateController.text.isEmpty ||
        returnDateController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in required fields'),
        ),
      );
      return;
    }

    final reservationDetails = {
      'id': idController.text,
      'pickUpDate': pickUpDateController.text,
      'returnDate': returnDateController.text,
      'discount': discountController.text,
    };

    ref.read(reservationDetailsProvider.notifier).state = reservationDetails;

    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => CustomerInformationScreen()));
  }

  String durationCalculation() {
    if (pickUpDateController.text.isEmpty ||
        returnDateController.text.isEmpty) {
      return '0 Days';
    }

    DateFormat format = DateFormat('h:mm a, d MMMM yyyy');
    DateTime pickUpDate = format.parse(pickUpDateController.text);
    DateTime returnDate = format.parse(returnDateController.text);

    final difference = returnDate.difference(pickUpDate);
    final weeks = difference.inDays ~/ 7;
    final days = difference.inDays % 7;
    if (weeks == 0) {
      return '$days days';
    }
    final formattedDifference = '$weeks Weeks $days Days';
    // print(difference.toString());
    return formattedDifference;
  }

  Widget dateTimePicker(BuildContext context, String formTitle,
      TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            formTitle,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 5),
          TextFormField(
            controller: controller,
            readOnly: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              suffixIcon: const Icon(Icons.calendar_today_outlined),
            ),
            onTap: () async {
              // final date = await showDatePicker(
              //   context: context,
              //   initialDate: DateTime.now(),
              //   firstDate: DateTime.now(),
              //   lastDate: DateTime(2100),
              // );
              final date = await showPlatformDatePicker();
              if (date != null) {
                // final time = await showTimePicker(
                //   context: context,
                //   initialTime: TimeOfDay.now(),
                // );
                final time = await showPlatformTimePicker();
                if (time != null) {
                  final dateTime = DateTime(
                      date.year, date.month, date.day, time.hour, time.minute);
                  final format = DateFormat('h:mm a, d MMMM yyyy');
                  controller.text = format.format(dateTime);
                }
              }
              setState(() {
                duration = durationCalculation();
              });
            },
          ),
        ],
      ),
    );
  }

  Future<DateTime?> showPlatformDatePicker() async {
    DateTime? selectedDate;
    if (Platform.isIOS) {
      await showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) {
          DateTime pickedDate = DateTime.now();
          return Container(
            height: 260,
            color: Color.fromARGB(255, 255, 255, 255),
            child: Column(
              children: [
                Container(
                  height: 200,
                  child: CupertinoDatePicker(
                    // initialDateTime: DateTime.now(),
                    minimumDate: DateTime.now(),
                    mode: CupertinoDatePickerMode.date,
                    onDateTimeChanged: (DateTime newDate) {
                      pickedDate = newDate;
                    },
                  ),
                ),
                CupertinoButton(
                  child: Text('Done'),
                  onPressed: () {
                    selectedDate = pickedDate;
                    Navigator.of(context).pop();
                  },
                )
              ],
            ),
          );
        },
      );
    } else {
      selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2100),
      );
    }
    return selectedDate;
  }

  Future<TimeOfDay?> showPlatformTimePicker() async {
    TimeOfDay? selectedTime;
    if (Platform.isIOS) {
      await showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) {
          TimeOfDay pickedTime = TimeOfDay.now();
          return Container(
            height: 260,
            color: Color.fromARGB(255, 255, 255, 255),
            child: Column(
              children: [
                Container(
                  height: 200,
                  child: CupertinoDatePicker(
                    // initialDateTime: DateTime.now(),
                    mode: CupertinoDatePickerMode.time,
                    onDateTimeChanged: (DateTime newTime) {
                      final now = DateTime.now();
                      if(newTime.isAfter(now)){
                        pickedTime = TimeOfDay.fromDateTime(newTime);
                      }
                    },
                  ),
                ),
                CupertinoButton(
                  child: Text('Done'),
                  onPressed: () {
                    selectedTime = pickedTime;
                    Navigator.of(context).pop();
                  },
                )
              ],
            ),
          );
        },
      );
    } else {
      selectedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
    }
    return selectedTime;
  }


  
}
