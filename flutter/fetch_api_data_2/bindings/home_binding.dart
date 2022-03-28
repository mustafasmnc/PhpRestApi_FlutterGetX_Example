import 'package:get/get.dart';
import 'package:getx_example1/fetch_api_data_2/controllers/home_controller.dart';

class HomeBindingFetchApiData2 extends Bindings {
  @override
  void dependencies() {
    //Get.put<HomeController>(HomeController());
    Get.lazyPut<HomeController>(() => HomeController());
  }
}
