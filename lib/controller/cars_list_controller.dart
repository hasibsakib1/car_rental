import 'package:car_rental/model/car_model.dart';
import 'package:dio/dio.dart';
import 'package:logger/web.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cars_list_controller.g.dart';

@riverpod
class CarsListController extends _$CarsListController {
  
  List<CarModel> build() => [];

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