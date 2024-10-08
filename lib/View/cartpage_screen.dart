import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Controller/dropdown_provider.dart';
//product model
class Product {
  final String id;
  final String name;
  final double price;
  final String imageUrl;
  int quantity;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    this.quantity = 1,
  });
}


class CartPage extends StatefulWidget {
  final List<Product> products;

  const CartPage({Key? key,
    required this.products,
  }) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  //value update on add and remove
  void updateQuantity(int index, int newQuantity) {
    setState(() {
      widget.products[index].quantity = newQuantity;
    });
  }

//method to calculate total values
  double calculateTotal() {
    return widget.products.fold(
      0.0,
          (sum, product) => sum + product.price * product.quantity,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text(
          'Cart',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.black),
            onPressed: () {
              // Implement notification button functionality
            },
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),


      body: ListView.builder(
        itemCount: widget.products.length,
        itemBuilder: (context, index) {
          final product = widget.products[index];

          return Card(
            child: Padding(
              padding:  EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Image.network(
                    product.imageUrl,
                    width: 100,
                    height: 100,
                  ),
                  SizedBox(width:30 ,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name,
                          style:  TextStyle(fontSize: 16),
                        ),


                        Consumer<CartDropDownController>(
                          builder: (context, controller, child) {
                            return Container(
                              height: 50, // Reduced height to fit the content properly
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: controller.dropdownvalue,
                                  icon: Icon(Icons.arrow_drop_down, color: Colors.black38),
                                  onChanged: (value) {
                                    if (value != null) {
                                      controller.changeCustomizedDropDown(value);
                                    }
                                  },
                                  items: [
                                    'customized', 'non customized', 'special',
                                  ].map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  // dropdownColor: Colors.transparent,
                                ),
                              ),
                            );
                          },
                        ),

                      Row(
                        children: [

                          Text(
                            '\$${product.price}',
                            style:  TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
SizedBox(width: 50,),
                          Container(
                            width: 100,
                            height: 30,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                IconButton(
                                  icon:  Icon(Icons.remove),
                                  onPressed: () => updateQuantity(
                                      index,
                                      product.quantity > 1
                                          ? product.quantity - 1
                                          : 1),
                                ),

                                Text(product.quantity.toString()),

                                IconButton(
                                  icon:  Icon(Icons.add),
                                  onPressed: () =>
                                      updateQuantity(index, product.quantity + 1),
                                ),
                              ],
                            ),
                          ),

                        ],
                      )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),


      bottomNavigationBar: Container(
        padding:  EdgeInsets.all(16.0),
        child: Card(
          elevation: 1,
          child: Padding(
            padding:  EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total: \$${calculateTotal().toStringAsFixed(2)}',
                  style:  TextStyle(fontSize: 18),
                ),


                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                  ),
                  onPressed: () {
                  },
                  child:  Text('Checkout'),
                ),


              ],
            ),
          ),
        ),
      ),
    );
  }
}