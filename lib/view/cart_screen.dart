import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/model/cart.dart';

class ShoppingCart extends StatelessWidget {
  const ShoppingCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () =>
                Provider.of<ShoppingCartProvider>(context, listen: false).emptyCart(),
            icon: Icon(Icons.delete,
              color: Colors.red,),
          ),
        ],
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_rounded,
          color: Colors.black,),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text('Shopping Cart',
        style: TextStyle(
          color: Colors.black
        ),),
      ),
      body: Consumer<ShoppingCartProvider>(
        builder:
            (BuildContext context, ShoppingCartProvider cart, Widget? child) =>
            SizedBox(
              height: double.infinity,
              child: Stack(
                children: [

                  Positioned(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemCount: cart.uniqueItems.length,
                      itemBuilder: (context, i) => Card(
                        child: ListTile(
                          // trailing: Text(
                          //   '${cart.itemsInCart.where((element) => element == cart.uniqueItems[i]).length} ×',
                          // ),
                          leading: Image.network(cart.itemsInCart
                              .firstWhere((element) => element == cart.uniqueItems[i])
                              .images![0].toString(),),
                          title: Text(
                            cart.itemsInCart
                                .firstWhere((element) => element == cart.uniqueItems[i])
                                .title.toString(),
                          ),
                          subtitle:
                          Text('\$${cart.itemsInCart[i].price.toStringAsFixed(2)}'),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('Items in Cart: ${cart.itemsInCart.length}'),
                        Text('Total Cost: \$${cart.totalCost.toStringAsFixed(2)}'),
                        // OutlinedButton.icon(
                        //   label: const Text('Clear cart'),
                        //   icon: const Icon(Icons.remove_shopping_cart),
                        //   onPressed: () =>
                        //       Provider.of<ShoppingCartProvider>(context, listen: false)
                        //           .emptyCart(),
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            )

      ),
    );
  }
}