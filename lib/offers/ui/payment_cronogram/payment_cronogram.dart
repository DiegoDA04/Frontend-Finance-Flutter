import 'package:flutter/material.dart';

import '../../data/models/consult.dart';
import '../../data/models/payment.dart';
import '../../data/services/offer_service.dart';

class PaymentCronogramView extends StatefulWidget {
  const PaymentCronogramView({super.key, required this.consult});
  final Consult consult;

  @override
  State<PaymentCronogramView> createState() => _PaymentCronogramViewState();
}

class _PaymentCronogramViewState extends State<PaymentCronogramView> {
  OfferService offerService = OfferService();
  List<Payment> payments = List.empty();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialize();
  }

  void initialize() async {
    payments = await offerService.fetchAllPaymentSchedule(
        widget.consult.realEstateOfferId,
        widget.consult.financialEntityId,
        widget.consult.supportEstate,
        widget.consult.paymentTime,
        widget.consult.initialFee,
        widget.consult.typeGracePeriod,
        widget.consult.gracePeriodMonths);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cronograma de Pagos"),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: const <DataColumn>[
            DataColumn(label: Text("N°")),
            DataColumn(label: Text("Saldo Inicial")),
            DataColumn(label: Text("Interes")),
            DataColumn(label: Text("Amortización")),
            DataColumn(label: Text("Seguro degravamen")),
            DataColumn(label: Text("Seguro de vivienda")),
            DataColumn(label: Text("Cuota")),
            DataColumn(label: Text("Saldo final")),
          ],
          rows: List<DataRow>.generate(
            payments.length,
            (int index) => DataRow(
              color: MaterialStateProperty.resolveWith<Color?>(
                  (Set<MaterialState> states) {
                return null;
              }),
              cells: <DataCell>[
                DataCell(Text('${payments[index].period}')),
                DataCell(Text('${payments[index].initialBalance}')),
                DataCell(Text('${payments[index].monthlyRate}')),
                DataCell(Text('${payments[index].amortization}')),
                DataCell(Text('${payments[index].lienInsurance}')),
                DataCell(Text('${payments[index].propertyInsurance}')),
                DataCell(Text('${payments[index].monthlyFee}')),
                DataCell(Text('${payments[index].endingBalance}')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
