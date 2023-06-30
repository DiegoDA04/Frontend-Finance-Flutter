import 'package:dropdown_search/dropdown_search.dart';
import 'package:finance_flutter/offers/data/models/bank.dart';
import 'package:finance_flutter/offers/data/models/consult.dart';
import 'package:finance_flutter/offers/data/services/bank_service.dart';
import 'package:finance_flutter/offers/ui/payment_cronogram/payment_cronogram.dart';
import 'package:flutter/material.dart';

import '../../../utils/validator.dart';
import '../../data/models/offer.dart';

class SchedulePaymentView extends StatefulWidget {
  const SchedulePaymentView({super.key, required this.offer});
  final Offer offer;

  @override
  State<SchedulePaymentView> createState() => _SchedulePaymentViewState();
}

class _SchedulePaymentViewState extends State<SchedulePaymentView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController homeValueController = TextEditingController();
  TextEditingController sustainableController = TextEditingController();
  TextEditingController lienInsuranceController = TextEditingController();
  TextEditingController propertyInsuranceController = TextEditingController();
  TextEditingController teaController = TextEditingController();
  TextEditingController initialFeeController = TextEditingController();
  TextEditingController payTimeController = TextEditingController();
  TextEditingController gracePeriodTimeController = TextEditingController();

  BankService bankService = BankService();
  List<Bank> banks = List.empty();
  Bank? bank;
  String? isGracePeriod;
  String? supportState;
  double teaMax = 0.0;

  @override
  void initState() {
    super.initState();

    gracePeriodTimeController.text = "0";
    homeValueController.text = widget.offer.homeValueInSoles.toString();
    sustainableController.text = widget.offer.isSustainable ? "Si" : "No";
    initialize();
  }

  void initialize() async {
    banks = await bankService.fetchAllBanks();
    setState(() {});
  }

  Future<void> createSchedulePayment() async {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Loading data...'),
        ),
      );

      bool supportS = false;
      if (supportState == "Si") supportS = true;
      int payment = int.parse(payTimeController.text);
      double fee = double.parse(initialFeeController.text);
      int grace;

      if (isGracePeriod == "Total") {
        grace = 2;
      } else if (isGracePeriod == "Parcial") {
        grace = 1;
      } else {
        grace = 0;
      }
      int graceTime = int.parse(gracePeriodTimeController.text);

      Consult consult = Consult(
        realEstateOfferId: widget.offer.id,
        supportEstate: supportS,
        paymentTime: payment,
        initialFee: fee,
        typeGracePeriod: grace,
        gracePeriodMonths: graceTime,
        financialEntityId: bank!.id,
      );

      if (context.mounted) ScaffoldMessenger.of(context).hideCurrentSnackBar();

      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => PaymentCronogramView(
                consult: consult,
              )));
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        title: Text(
          "Simulador de cuotas",
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: SizedBox(
        width: size.width,
        height: size.height * 1.15,
        child: Container(
          padding: const EdgeInsets.only(
            right: 16.0,
            left: 16.0,
            bottom: 24.0,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                    "Simula las cuotas a pagar con el nuevo credito Fondo Mi Vivienda"),
                SizedBox(
                  height: 12.0,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Informacion de la oferta inmobiliaria",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: size.width * 0.45,
                            child: TextFormField(
                              readOnly: true,
                              controller: homeValueController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                helperText: "Valor de vivienda",
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.0,
                                  color: Color(0xFF8D8D8D),
                                ),
                                prefixIcon: Icon(Icons.house),
                                suffixIconColor: Color(0xFF8D8D8D),
                                suffixIcon:
                                    Icon(Icons.monetization_on_outlined),
                                filled: true,
                                fillColor: Color(0xFFF8FAFB),
                                prefixIconColor: Color(0xFF8D8D8D),
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 16.0),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: size.width * 0.435,
                            child: TextFormField(
                              readOnly: true,
                              controller: sustainableController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                helperText: "¿La vivienda es sostenible?",
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.0,
                                  color: Color(0xFF8D8D8D),
                                ),
                                prefixIcon: Icon(Icons.eco),
                                suffixIconColor: Color(0xFF8D8D8D),
                                suffixIcon: Icon(Icons.question_mark),
                                filled: true,
                                fillColor: Color(0xFFF8FAFB),
                                prefixIconColor: Color(0xFF8D8D8D),
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 16.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 24.0,
                      ),
                      Text(
                        "Informacion de la entidad financiera",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      DropdownSearch<Bank>(
                        onChanged: (value) {
                          setState(() {
                            bank = value;
                            lienInsuranceController.text =
                                (value!.lienInsurance * 100).toString();
                            propertyInsuranceController.text =
                                (value!.propertyInsurance * 100).toString();
                            teaMax = value!.teaInSoles * 100;
                            teaController.text = teaMax.toString();
                          });
                        },
                        items: banks,
                        itemAsString: (Bank u) => u.name,
                        popupProps: const PopupProps.menu(
                          fit: FlexFit.loose,
                          menuProps: MenuProps(
                            elevation: 1,
                            backgroundColor: Colors.white,
                          ),
                        ),
                        dropdownDecoratorProps: DropDownDecoratorProps(
                          dropdownSearchDecoration: InputDecoration(
                            helperText: "Nombre de la entidad financiera",
                            border: InputBorder.none,
                            hintText: "Entidad financiera",
                            hintStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16.0,
                              color: Color(0xFF8D8D8D),
                            ),
                            prefixIcon: Icon(Icons.account_balance),
                            filled: true,
                            fillColor: Color(0xFFF8FAFB),
                            prefixIconColor: Color(0xFF8D8D8D),
                            contentPadding:
                                EdgeInsets.symmetric(vertical: 16.0),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: size.width * 0.45,
                            child: TextFormField(
                              readOnly: true,
                              controller: lienInsuranceController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                helperText: "Seguro degravamen",
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.0,
                                  color: Color(0xFF8D8D8D),
                                ),
                                prefixIcon: Icon(Icons.person),
                                suffixIconColor: Color(0xFF8D8D8D),
                                suffixIcon: Icon(Icons.percent),
                                filled: true,
                                fillColor: Color(0xFFF8FAFB),
                                prefixIconColor: Color(0xFF8D8D8D),
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 16.0),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: size.width * 0.435,
                            child: TextFormField(
                              readOnly: true,
                              controller: propertyInsuranceController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                helperText: "Seguro de vivienda",
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.0,
                                  color: Color(0xFF8D8D8D),
                                ),
                                prefixIcon: Icon(Icons.home),
                                suffixIconColor: Color(0xFF8D8D8D),
                                suffixIcon: Icon(Icons.percent),
                                filled: true,
                                fillColor: Color(0xFFF8FAFB),
                                prefixIconColor: Color(0xFF8D8D8D),
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 16.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      TextFormField(
                        controller: teaController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          counterText: "Max $teaMax%",
                          helperText: "TEA (Tasa Efectiva Anual)",
                          hintText: "TEA",
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16.0,
                            color: Color(0xFF8D8D8D),
                          ),
                          prefixIcon: Icon(Icons.feed),
                          suffixIconColor: Color(0xFF8D8D8D),
                          suffixIcon: Icon(Icons.percent),
                          filled: true,
                          fillColor: Color(0xFFF8FAFB),
                          prefixIconColor: Color(0xFF8D8D8D),
                          contentPadding: EdgeInsets.symmetric(vertical: 16.0),
                        ),
                      ),
                      SizedBox(
                        height: 24.0,
                      ),
                      Text(
                        "Informacion del Prestamo",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: size.width * 0.45,
                      child: TextFormField(
                        controller: initialFeeController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          counterText: "Min: 7.5%",
                          helperText: "Cuota inicial",
                          border: InputBorder.none,
                          hintText: "Cuota",
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16.0,
                            color: Color(0xFF8D8D8D),
                          ),
                          prefixIcon: Icon(Icons.house),
                          suffixIconColor: Color(0xFF8D8D8D),
                          suffixIcon: Icon(Icons.monetization_on_outlined),
                          filled: true,
                          fillColor: Color(0xFFF8FAFB),
                          prefixIconColor: Color(0xFF8D8D8D),
                          contentPadding: EdgeInsets.symmetric(vertical: 16.0),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.435,
                      child: DropdownSearch<String>(
                        items: ["Si", "No"],
                        onChanged: (value) {
                          setState(() {
                            supportState = value;
                          });
                        },
                        popupProps: const PopupProps.menu(
                          fit: FlexFit.loose,
                          menuProps: MenuProps(
                            elevation: 1,
                            backgroundColor: Colors.white,
                          ),
                        ),
                        dropdownDecoratorProps: const DropDownDecoratorProps(
                          dropdownSearchDecoration: InputDecoration(
                            helperText: "¿Recibió apoyo del estado?",
                            border: InputBorder.none,
                            hintText: "Apoyo",
                            hintStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16.0,
                              color: Color(0xFF8D8D8D),
                            ),
                            prefixIcon: Icon(Icons.support_agent),
                            filled: true,
                            fillColor: Color(0xFFF8FAFB),
                            prefixIconColor: Color(0xFF8D8D8D),
                            contentPadding:
                                EdgeInsets.symmetric(vertical: 16.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextFormField(
                  controller: payTimeController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    counterText: "Max: 300 meses",
                    helperText: "Plazos de pago (en meses)",
                    border: InputBorder.none,
                    hintText: "Plazos",
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16.0,
                      color: Color(0xFF8D8D8D),
                    ),
                    prefixIcon: Icon(Icons.calendar_month),
                    filled: true,
                    fillColor: Color(0xFFF8FAFB),
                    prefixIconColor: Color(0xFF8D8D8D),
                    contentPadding: EdgeInsets.symmetric(vertical: 16.0),
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: size.width * 0.5,
                      child: DropdownSearch<String>(
                        items: ["No", "Parcial", "Total"],
                        onChanged: (value) {
                          setState(() {
                            isGracePeriod = value;
                          });
                        },
                        popupProps: const PopupProps.menu(
                          fit: FlexFit.loose,
                          menuProps: MenuProps(
                            elevation: 1,
                            backgroundColor: Colors.white,
                          ),
                        ),
                        dropdownDecoratorProps: const DropDownDecoratorProps(
                          dropdownSearchDecoration: InputDecoration(
                            helperText: "¿Periodo de gracia?",
                            border: InputBorder.none,
                            hintText: "Periodo de gracia",
                            hintStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16.0,
                              color: Color(0xFF8D8D8D),
                            ),
                            prefixIcon: Icon(Icons.support_agent),
                            filled: true,
                            fillColor: Color(0xFFF8FAFB),
                            prefixIconColor: Color(0xFF8D8D8D),
                            contentPadding:
                                EdgeInsets.symmetric(vertical: 16.0),
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible:
                          isGracePeriod == "Total" || isGracePeriod == "Parcial"
                              ? true
                              : false,
                      child: SizedBox(
                        width: size.width * 0.4,
                        child: TextFormField(
                          controller: gracePeriodTimeController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            counterText: "Max: 6 meses",
                            helperText: "Meses",
                            border: InputBorder.none,
                            hintText: "Plazo",
                            hintStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16.0,
                              color: Color(0xFF8D8D8D),
                            ),
                            prefixIcon: Icon(Icons.calendar_month),
                            filled: true,
                            fillColor: Color(0xFFF8FAFB),
                            prefixIconColor: Color(0xFF8D8D8D),
                            contentPadding:
                                EdgeInsets.symmetric(vertical: 16.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 24.0,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: createSchedulePayment,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2F4897),
                      padding: const EdgeInsets.symmetric(vertical: 18.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: const Text(
                      "Crear cronograma de pagos",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
