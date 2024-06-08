import 'package:car_rental/model/car_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/web.dart';

final carsListControllerProvider = StateNotifierProvider<CarsListController, List<CarModel>>((ref) => CarsListController());

class CarsListController extends StateNotifier<List<CarModel>> {
  CarsListController() : super([]);

  void fetchCarsList() async {
    final dio = Dio();

    try{
      final response = await dio.get('https://exam-server-7c41747804bf.herokuapp.com/carsList');
      if(response.statusCode == 200){
        Logger().i(response.data);
        final data = response.data['data'];
        final cars = data.map<CarModel>((e) => CarModel.fromJson(e)).toList();
        state = cars;
      }
      else{
        throw Exception('Failed to load business types');
      }
    }
    catch(e){
      Logger().e(e);
    }
  }
}