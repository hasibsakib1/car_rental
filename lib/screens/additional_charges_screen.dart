import 'package:car_rental/model/car_model.dart';
import 'package:car_rental/utils/ui_component/common_appbar.dart';
import 'package:car_rental/utils/ui_component/content_box_outlined.dart';
import 'package:car_rental/utils/ui_component/next_button.dart';
import 'package:car_rental/utils/ui_component/title_with_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controller/charges_controller.dart';
import '../controller/provider_controller.dart';
import 'summary_screen.dart';

class AdditionalChargesScreen extends ConsumerStatefulWidget {
  const AdditionalChargesScreen({super.key, required this.selectedCar});

  final CarModel selectedCar;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AdditionalChargesScreenState();
}

class _AdditionalChargesScreenState extends ConsumerState<AdditionalChargesScreen> {

  List<Map<String, Map<String, dynamic>>> charges = [
    {
      'Collision Damage Waiver': {
        'isChecked': false,
        'price': '\$9.0',
      },
    },
    {
      'Liability Insurance': {
        'isChecked': false,
        'price': '\$15.0',
      },
    },
    {
      'Rental Tax': {
        'isChecked': false,
        'price': '11.5%',
      },
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const TitleWithDivider(title: 'Additional Charges'),
            const SizedBox(height: 20),
            ContentBoxOutlined(
              child: Column(
                children: [
                  ListView(
                    shrinkWrap: true,
                    children: charges
                        .map(
                          (charge) => Column(
                            children: charge.entries
                                .map(
                                  (entry) => GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        entry.value['isChecked'] = !entry.value['isChecked'];
                                      });
                                    },
                                    child: Row(
                                      children: [
                                        Checkbox(
                                          value: entry.value['isChecked'],
                                          onChanged: (bool? value) {
                                            setState(() {
                                              entry.value['isChecked'] = value!;
                                            });
                                          },
                                        ),
                                        Text(
                                          entry.key,
                                          style: const TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                        const Spacer(),
                                        Text(
                                          '${entry.value['price']}',
                                          style: const TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: NextButton(nextButtonAction: () => nextButtonAction(context)),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void nextButtonAction(BuildContext context) {
    ref.read(totalChargesProvider.notifier).state = 0.0;
    ref.read(additionalChargesProvider.notifier).state = charges;
    ref.read(chargesControllerProvider.notifier).getFareBreakdown(widget.selectedCar, ref);
    Navigator.push(context, MaterialPageRoute(builder:  (context) =>  SummaryScreen(selectedCar: widget.selectedCar)));
  }
}
