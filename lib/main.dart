import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskcart/Utils/images.dart';
import 'Controller/dropdown_provider.dart';
import 'View/cartpage_screen.dart';
void main(){

  runApp(
      MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => CartDropDownController()),
          ],
          child:MyApp(),
      )    );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CartPage(products: products),
    );
  }

 ////// //list of products//////////////////
  List<Product> products = [
    Product(
      id: '1',
      name: 'Dumplines',
      price: 19.99,
      imageUrl: AppImages.biryaniimg,
      //imageUrl: 'https://via.placeholder.com/150x150.png?text=T-Shirt',
    ),
    Product(
      id: '2',
      name: 'Noodles',
      price: 79.99,
      imageUrl: AppImages.biryaniimg,
      //imageUrl: 'https://via.placeholder.com/150x150.png?text=Headphones',
    ),
    Product(
      id: '3',
      name: 'Burger',
      price: 499.99,
      imageUrl: AppImages.biryaniimg,
      //imageUrl: 'https://via.placeholder.com/150x150.png?text=Laptop',
    ),

  ];
}



