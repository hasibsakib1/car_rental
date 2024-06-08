import 'package:car_rental/controller/cars_list_controller.dart';
import 'package:car_rental/screens/additional_charges_screen.dart';
import 'package:car_rental/utils/ui_component/common_appbar.dart';
import 'package:car_rental/utils/ui_component/content_box_outlined.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/car_model.dart';
// import '../utils/ui_component/next_button.dart';
import '../utils/ui_component/title_with_divider.dart';

class VehicleInformationScreen extends ConsumerStatefulWidget {
  const VehicleInformationScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _VehicleInformationScreenState();
}

class _VehicleInformationScreenState extends ConsumerState<VehicleInformationScreen> {

  List<CarModel> cars = [];
  List<String> carsFiltered = [];

  // late CarModel selectedCar;

  @override
  void initState() {
    super.initState();
    getVehicleInformation();
  }

  @override
  Widget build(BuildContext context) {
    cars = ref.watch(carsListControllerProvider);
    return Scaffold(
      appBar: const CommonAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const TitleWithDivider(title: 'Vehicle Information'),
            const SizedBox(height: 20),
            cars.isEmpty ? const Text('No Cars to show') : 
            Expanded(
              child: ListView.builder(
                itemCount: cars.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: GestureDetector(
                      onTap: () {
                        // selectedCar = cars[index];
                        // print(selectedCar);

                        nextButtonAction(context, cars[index]);
                      },
                      child: ContentBoxOutlined(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Image.network(cars[index].imageUrl, width: 150, height: 150),
                                const SizedBox(width: 20),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${cars[index].make} ${cars[index].model}',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Row(
                                      children: [
                                        const Icon(Icons.group_outlined),
                                        const SizedBox(width: 5),
                                        Text(
                                          '${cars[index].seats.toString()} seats',
                                          style: const TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Icon(Icons.work_outline),
                                        const SizedBox(width: 5),
                                        Text(
                                          '${cars[index].bags.toString()} bags',
                                          style: const TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Divider(
                              color: Theme.of(context).colorScheme.outline,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '\$${cars[index].rates.hourly.toString()}/Hour',
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  '\$${cars[index].rates.daily.toString()}/Day',
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  '\$${cars[index].rates.weekly.toString()}/Week',
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            // NextButton(nextButtonAction: () => nextButtonAction(context)),
          ],
        )
      ),
    );
  }

  void nextButtonAction(BuildContext context, CarModel selectedCar) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => AdditionalChargesScreen(selectedCar: selectedCar)));
  }

  void getVehicleInformation() {
    ref.read(carsListControllerProvider.notifier).fetchCarsList();
  }
}