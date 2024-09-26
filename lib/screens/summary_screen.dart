import 'package:car_rental/controller/charges_controller.dart';
import 'package:car_rental/model/car_model.dart';
import 'package:car_rental/utils/ui_component/common_appbar.dart';
import 'package:car_rental/utils/ui_component/content_box_outlined.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controller/provider_controller.dart';
import '../utils/ui_component/title_with_divider.dart';

class SummaryScreen extends ConsumerStatefulWidget {
   SummaryScreen({super.key, required this.selectedCar});

  final CarModel selectedCar;

  @override
  ConsumerState<SummaryScreen> createState() => _SummaryScreenState();
}

class _SummaryScreenState extends ConsumerState<SummaryScreen> {

  Map<String, double> fareBreakdown= {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future (() {
      ref.read(chargesControllerProvider.notifier).getFareBreakdown(widget.selectedCar);
    },);
  }


  
  @override
  Widget build(BuildContext context) {
    final reservationDetails = ref.watch(reservationDetailsProvider);
    final customerInformation = ref.watch(customerInformationProvider);
    fareBreakdown = ref.watch(chargesControllerProvider);

    
print(fareBreakdown);

    return Scaffold(
      appBar: const CommonAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const TitleWithDivider(title: 'Summary'),
              ContentBoxOutlined(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Reservation ID', style: TextStyle(fontSize: 16)),
                        Text(reservationDetails['id'], style: const TextStyle(fontSize: 16)),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Pickup Date', style:  TextStyle(fontSize: 16)),
                        Text(reservationDetails['pickUpDate'], style: const TextStyle(fontSize: 16)),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Return Date', style:  TextStyle(fontSize: 16)),
                        Text(reservationDetails['returnDate'], style: const TextStyle(fontSize: 16)),
                      ],
                    ),
                  ],
                )
              ),
              const SizedBox(height: 20),
              const TitleWithDivider(title: 'Customer Information'),
              ContentBoxOutlined(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('First Name', style:  TextStyle(fontSize: 16)),
                        Text(customerInformation['firstName'], style: const TextStyle(fontSize: 16)),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Last Name', style:  TextStyle(fontSize: 16)),
                        Text(customerInformation['lastName'], style: const TextStyle(fontSize: 16)),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Email', style: TextStyle(fontSize: 16)),
                        Text(customerInformation['email'], style: const TextStyle(fontSize: 16)),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Phone', style: TextStyle(fontSize: 16)),
                        Text(customerInformation['phone'], style: const TextStyle(fontSize: 16)),
                      ],
                    ),
                  ],
                )
              ),
              const SizedBox(height: 20),
              const TitleWithDivider(title: 'Vehicle Information'),
              ContentBoxOutlined(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Vehicle Type', style:  TextStyle(fontSize: 16)),
                        Text(widget.selectedCar.type, style: const TextStyle(fontSize: 16))
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Vehicle Model', style:  TextStyle(fontSize: 16)),
                        Text('${widget.selectedCar.make} ${widget.selectedCar.model}', style: const TextStyle(fontSize: 16))
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const TitleWithDivider(title: 'Charges Summary'),
              ContentBoxOutlined(
                isChangeSummary: true,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Charge', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          Text('Total', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Divider(color: Theme.of(context).colorScheme.primary,),
                      const SizedBox(height: 10),
                      ListView(
                        shrinkWrap: true,
                        children: [
                          ...fareBreakdown.entries.map((entry) {
                            // print(fareBreakdown);
                            return entry.value==0? SizedBox.shrink() : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(entry.key, style: const TextStyle(fontSize: 16)),
                              Text('\$${entry.value}', style: const TextStyle(fontSize: 16)),
                            ],
                          );
                          }).toList(),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Total Charge', style: TextStyle(fontSize: 16)),
                          Text('\$${ref.read(totalChargesProvider)}', style: const TextStyle(fontSize: 16)),
                        ],
                      ),
                    ],
                  ),
                )
              ),
              // ElevatedButton(onPressed: (){
              //   setState(() {
              //     fareBreakdown = ref.watch(chargesControllerProvider);
              //   });
              // }, child: Text("Refresh"))
            ],
          ),
        ),
      ),
    );
  }
}