import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:prfinal/layout/BtCard.dart';
import '../models/CartItem.dart';
import '../AppConstants.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem cartItem;
  final VoidCallback onRemove;

  const CartItemWidget({
    Key? key,
    required this.cartItem,
    required this.onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BtCard(
      //margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      borderRadius: BorderRadius.circular(5),
      shadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          spreadRadius: 2,
          blurRadius: 5,
          offset: const Offset(0, 3),
        ),
      ],
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Image.memory(
              base64Decode(cartItem.image),
              height: 60,
              width: 60,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cartItem.name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '\$${cartItem.price.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text('${cartItem.quantity} UND'),
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.delete),
              color: Colors.red,
              onPressed: onRemove,
            ),
          ],
        ),
      ),
    );
  }
}
