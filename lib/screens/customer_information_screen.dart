import 'package:car_rental/controller/provider_controller.dart';
import 'package:car_rental/screens/vehicle_information_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utils/ui_component/common_form_field.dart';
import '../utils/ui_component/content_box_outlined.dart';
import '../utils/ui_component/next_button.dart';
import '../utils/ui_component/title_with_divider.dart';
import '../utils/ui_component/common_appbar.dart';

class CustomerInformationScreen extends ConsumerWidget {
  CustomerInformationScreen({super.key});

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const CommonAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const TitleWithDivider(title: 'Customer Information'),
              const SizedBox(height: 20),
              ContentBoxOutlined(
                child: Column(
                  children: [
                    CommonFormField(
                        formTitle: 'First Name', controller: firstNameController),
                    CommonFormField(
                        formTitle: 'Last Name', controller: lastNameController),
                    CommonFormField(
                        formTitle: 'Email', controller: emailController),
                    CommonFormField(
                        formTitle: 'Phone', controller: phoneController, isDigitsOnly: true),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              NextButton(nextButtonAction: () => nextButtonAction(context, ref)),
            ],
          )
        ),
      ),
    );
  }

  void nextButtonAction(BuildContext context, WidgetRef ref) {
    if(firstNameController.text.isEmpty || lastNameController.text.isEmpty || emailController.text.isEmpty || phoneController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please fill all the fields')));
      return;
    }

    final customerInformation = {
      'firstName': firstNameController.text,
      'lastName': lastNameController.text,
      'email': emailController.text,
      'phone': phoneController.text,
    };
    ref.read(customerInformationProvider.notifier).state = customerInformation;
    Navigator.push(context, MaterialPageRoute(builder:(context) => const VehicleInformationScreen()));
  }
}