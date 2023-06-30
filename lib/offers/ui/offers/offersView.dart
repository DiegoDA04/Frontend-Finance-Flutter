import 'package:finance_flutter/offers/data/services/offer_service.dart';
import 'package:finance_flutter/offers/ui/offers/widgets/offer_card.dart';
import 'package:finance_flutter/offers/ui/offers_detail/offer_details_view.dart';
import 'package:finance_flutter/utils/validator.dart';
import 'package:flutter/material.dart';

import '../../data/models/offer.dart';

class OffersView extends StatefulWidget {
  const OffersView({super.key});

  @override
  State<OffersView> createState() => _OffersViewState();
}

class _OffersViewState extends State<OffersView> {
  TextEditingController searchController = TextEditingController();
  OfferService offerService = OfferService();
  List<Offer> offers = List.empty();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialize();
  }

  initialize() async {
    offers = await offerService.fetchAllOffers();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          width: size.width,
          height: size.height,
          padding: EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Ofertas inmobiliarias',
                    style: TextStyle(
                      fontSize: 28.0,
                      fontFamily: 'Gilroy',
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF0C1E38),
                    ),
                  ),
                ],
              ),
              Text(
                'Descubre las ofertas inmobiliarias',
                style: TextStyle(
                  fontSize: 15.0,
                ),
              ),
              SizedBox(
                height: 18.0,
              ),
              TextFormField(
                controller: searchController,
                validator: (value) => Validator.validateText(value ?? ""),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  hintText: 'Busca por titulo',
                  hintStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16.0,
                    color: Color(0xFF8D8D8D),
                  ),
                  prefixIcon: Icon(Icons.search),
                  filled: true,
                  fillColor: Color(0xFFF8FAFB),
                  prefixIconColor: Color(0xFF8D8D8D),
                  contentPadding: EdgeInsets.symmetric(vertical: 16.0),
                ),
              ),
              SizedBox(
                height: 18.0,
              ),
              const Text(
                'Ofertas',
                style: TextStyle(
                  fontSize: 18.0,
                  fontFamily: 'Gilroy',
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF0C1E38),
                ),
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: offers.length,
                    itemBuilder: (_, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  OfferDetailsView(offer: offers[index])));
                        },
                        child: OfferCard(
                          offer: offers[index],
                        ),
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
