import 'package:finance_flutter/offers/ui/schedule_payment/schedule_payment_view.dart';
import 'package:flutter/material.dart';

import '../../data/models/offer.dart';

class OfferDetailsView extends StatefulWidget {
  const OfferDetailsView({super.key, required this.offer});
  final Offer offer;

  @override
  State<OfferDetailsView> createState() => _OfferDetailsViewState();
}

class _OfferDetailsViewState extends State<OfferDetailsView> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(),
      body: Container(
        width: size.width,
        height: size.height,
        padding: EdgeInsets.only(right: 24.0, left: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.offer.offerTitle,
              style: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.w700,
                color: Color(0xFF0C1E38),
              ),
            ),
            SizedBox(
              height: 18.0,
            ),
            Image.network(widget.offer.offerImageUrl),
            SizedBox(
              height: 18.0,
            ),
            Text(
              widget.offer.description,
              style: TextStyle(
                fontSize: 16.0,
                color: Color(0xFF0C1E38),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          SchedulePaymentView(offer: widget.offer)));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2F4897),
                  padding: const EdgeInsets.symmetric(vertical: 18.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Text(
                  "Simulador de cuotas",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
