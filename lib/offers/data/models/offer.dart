class Offer {
  int id;
  String offerTitle;
  String description;
  String location;
  bool isSustainable;
  double homeValueInSoles;
  double homeValueInDollars;
  String offerImageUrl;

  Offer({
    required this.id,
    required this.offerTitle,
    required this.description,
    required this.location,
    required this.isSustainable,
    required this.homeValueInDollars,
    required this.homeValueInSoles,
    required this.offerImageUrl,
  });

  factory Offer.fromJson(Map<String, dynamic> json) {
    return Offer(
      id: json['id'],
      offerTitle: json['offerTitle'],
      description: json['description'],
      location: json['location'],
      isSustainable: json['isSustainable'],
      homeValueInDollars: json['homeValueInDollars'],
      homeValueInSoles: json['homeValueInSoles'],
      offerImageUrl: json['offerImageUrl'],
    );
  }
}
