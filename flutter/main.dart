import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_example1/fetch_api_data_2/bindings/home_binding.dart';
import 'package:getx_example1/fetch_api_data_2/views/home_view.dart';

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeService().getThemeMode(),
      //darkTheme: ThemeData.dark(),
      //theme: ThemeData.light(),
      //themeMode: ThemeService().getThemeMode(),
      locale: LocalizationService.locale,
      fallbackLocale: LocalizationService.fallbackLocale,
      translations: LocalizationService(),
      getPages: [
        GetPage(
            name: "/home_page_fetchapidata2",
            page: () => HomeViewFetchApiData2(),
            binding: HomeBindingFetchApiData2()),
      ],
      initialRoute: "/home_page_fetchapidata2",
    );
  }
}
