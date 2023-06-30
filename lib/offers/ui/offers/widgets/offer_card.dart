import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../data/models/offer.dart';

class OfferCard extends StatelessWidget {
  const OfferCard({super.key, required this.offer});

  final Offer offer;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 0.5,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(
              offer.offerImageUrl,
              height: 64.0,
            ),
            SizedBox(
              width: 12.0,
            ),
            Column(
              children: [
                Text(
                  offer.offerTitle,
                  style: TextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  offer.location,
                  style: TextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
