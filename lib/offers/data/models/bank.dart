class Bank {
  int id;
  String name;
  double teaInDollars;
  double teaInSoles;
  double lienInsurance;
  double propertyInsurance;

  Bank({
    required this.id,
    required this.name,
    required this.teaInDollars,
    required this.teaInSoles,
    required this.lienInsurance,
    required this.propertyInsurance,
  });

  factory Bank.fromJson(Map<String, dynamic> json) {
    return Bank(
      id: json['id'],
      name: json['name'],
      teaInDollars: json['effectiveAnnualRateInDollars'],
      teaInSoles: json['effectiveAnnualRateInSoles'],
      lienInsurance: json['lienInsurance'],
      propertyInsurance: json['propertyInsurance'],
    );
  }
}
