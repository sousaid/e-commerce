import 'package:flutter/material.dart';
import 'injection_container.dart' as di;
import 'features/product/presentation/views/product_list_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Commerce Clean Arch',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: ProductListPage(),
    );
  }
}
