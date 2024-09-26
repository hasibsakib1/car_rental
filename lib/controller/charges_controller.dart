import 'package:car_rental/model/car_model.dart';
import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'provider_controller.dart';

part 'charges_controller.g.dart';



@riverpod
class ChargesController extends _$ChargesController{  
  @override
  Map<String, double> build(){
    return {
      'Weeks': 0,
      'Days': 0,
      'Hours': 0,
    };
  }

  void getFareBreakdown(CarModel car) {
    final baseFare = getBaseFare(car);
    final additionalCharges = getAdditionalCharges();
    final rentalTax = getRentalTax();
    final discount = getDiscount();

    final fareBreakdown = {...baseFare, ...additionalCharges, ...rentalTax, ...discount};
    print(fareBreakdown);

    state = fareBreakdown;
    print("..........................................$state");

  }

  Map<String, double> getBaseFare(CarModel car) {
    final duration = getDuration();

    final weeks = duration['weeks'] ?? 0;
    final days = duration['days'] ?? 0;
    final hours = duration['hours'] ?? 0;

    final weekFare = car.rates.weekly * weeks;
    final dayFare = car.rates.daily * days;
    final hourFare = car.rates.hourly * hours;

    final totalBaseFare = weekFare + dayFare + hourFare;
    ref.read(totalChargesProvider.notifier).state =
        ref.read(totalChargesProvider) + totalBaseFare;

    final baseFareBreakdown = {
      'Weeks': weekFare.toDouble(),
      'Days': dayFare.toDouble(),
      'Hours': hourFare.toDouble(),
    };

    // print(baseFareBreakdown);


    return baseFareBreakdown;
  }

  Map<String, int> getDuration() {
    final reservationDetails = ref.watch(reservationDetailsProvider);

    DateFormat format = DateFormat('h:mm a, d MMMM yyyy');
    final pickUpDate = format.parse(reservationDetails['pickUpDate']);
    final returnDate = format.parse(reservationDetails['returnDate']);
    final difference = returnDate.difference(pickUpDate);
    final weeks = difference.inDays ~/ 7;
    final days = difference.inDays % 7;
    final hours = difference.inHours % 24;

    final duration = {
      'weeks': weeks,
      'days': days,
      'hours': hours,
    };

    return duration;
  }

  Map<String, double> getAdditionalCharges() {
    final charges = ref.watch(additionalChargesProvider);

    final collisionDamageWaiver = charges[0]['Collision Damage Waiver']!['isChecked'] ? 9.00 : 0.00;
    final liabilityInsurance = charges[1]['Liability Insurance']!['isChecked'] ? 15 : 0;

    ref.read(totalChargesProvider.notifier).state =
        ref.read(totalChargesProvider) + collisionDamageWaiver + liabilityInsurance;

    final additionalCharges = {
      'Collision Damage Waiver': collisionDamageWaiver.toDouble(),
      'Liability Insurance': liabilityInsurance.toDouble() ,
    };
    return additionalCharges;
  }

  Map<String, double> getRentalTax() {
    final charges = ref.watch(additionalChargesProvider);

    if (charges[2]['Rental Tax']!['isChecked']) {
      final totalBaseFare = ref.read(totalChargesProvider);
      final rentalTax = double.parse((totalBaseFare * 0.115).toStringAsFixed(2));
      print("rentalTax................................$rentalTax");
      ref.read(totalChargesProvider.notifier).state = totalBaseFare + rentalTax;

      return {'Rental Tax': rentalTax};
    }

    return {};
  }

  Map<String, double> getDiscount() {
    final reservationDetails = ref.watch(reservationDetailsProvider);

    if (reservationDetails['discount'].isEmpty) { 
      return {};
    }

    var discount = reservationDetails['discount'] ?? 0.0;
    discount = double.parse(discount);
    discount = discount * -1;

    ref.read(totalChargesProvider.notifier).state =
        ref.read(totalChargesProvider) + discount;

    return {'Discount': discount};
  }
}
