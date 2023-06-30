import 'dart:convert';

import 'package:finance_flutter/offers/data/models/payment.dart';
import 'package:http/http.dart' as http;
import '../models/offer.dart';

class OfferService {
  final String OFFERS_ENDPOINT =
      "https://app-backend-finance-v2-230628160307.azurewebsites.net/api/v1/real-estate-offers";

  Future<List<Offer>> fetchAllOffers() async {
    http.Response response = await http.get(Uri.parse(OFFERS_ENDPOINT));

    if (response.statusCode == 200) {
      return (json.decode(utf8.decode(response.bodyBytes))['content'] as List)
          .map((e) => Offer.fromJson(e))
          .toList();
    } else {
      return List.empty();
    }
  }

  Future<List<Payment>> fetchAllPaymentSchedule(
    int realEstateOfferId,
    int financialEntityId,
    bool isSupportState,
    int paymentTime,
    double initialFee,
    int typeGracePeriod,
    int gracePeriodMonths,
  ) async {
    Map<String, dynamic> queryParams = {
      'support-state': isSupportState.toString(),
      'payment-time': paymentTime.toString(),
      'initial-fee': initialFee.toString(),
      'type-grace-period': typeGracePeriod.toString(),
      'grace-period-months': gracePeriodMonths.toString(),
      'financialEntityId': financialEntityId.toString()
    };

    String queryString = Uri(queryParameters: queryParams).query;

    var requestUrl =
        '$OFFERS_ENDPOINT/$realEstateOfferId/payment-schedule?$queryString';

    http.Response response = await http.get(Uri.parse(requestUrl));

    if (response.statusCode == 200) {
      List<Payment> payments =
          (json.decode(utf8.decode(response.bodyBytes)) as List)
              .map((e) => Payment.fromJson(e))
              .toList();
      print(requestUrl);

      return payments;
    } else {
      return List.empty();
    }
  }
}
