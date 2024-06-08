import 'package:flutter_riverpod/flutter_riverpod.dart';

final reservationDetailsProvider = StateProvider((ref) => <String, dynamic>{
      'id': '',
      'pickUpDate': '',
      'returnDate': '',
      'discount': '',
    });

final customerInformationProvider = StateProvider((ref) => <String, dynamic>{
      'firstName': '',
      'lastName': '',
      'email': '',
      'phone': '',
    });

final additionalChargesProvider = StateProvider((ref) => <Map<String, Map<String, dynamic>>>[
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
    ]);

    final totalChargesProvider = StateProvider<double>((ref) => 0.0);
