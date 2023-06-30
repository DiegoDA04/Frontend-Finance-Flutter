class Payment {
  int period;
  double initialBalance;
  double monthlyRate;
  double amortization;
  double lienInsurance;
  double propertyInsurance;
  double monthlyFee;
  double endingBalance;

  Payment({
    required this.period,
    required this.initialBalance,
    required this.monthlyRate,
    required this.amortization,
    required this.lienInsurance,
    required this.propertyInsurance,
    required this.monthlyFee,
    required this.endingBalance,
  });

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      period: json['period'],
      initialBalance: json['initialBalance'],
      monthlyRate: json['monthlyRate'],
      amortization: json['amortization'],
      lienInsurance: json['lienInsurance'],
      propertyInsurance: json['propertyInsurance'],
      monthlyFee: json['monthlyFee'],
      endingBalance: json['endingBalance'],
    );
  }
}
