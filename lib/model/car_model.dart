class CarModel {
    String id;
    String make;
    String model;
    int year;
    String type;
    int seats;
    int bags;
    List<String> features;
    Rates rates;
    String imageUrl;

    CarModel({
        required this.id,
        required this.make,
        required this.model,
        required this.year,
        required this.type,
        required this.seats,
        required this.bags,
        required this.features,
        required this.rates,
        required this.imageUrl,
    });

    factory CarModel.fromJson(Map<String, dynamic> json) => CarModel(
        id: json["id"],
        make: json["make"],
        model: json["model"],
        year: json["year"],
        type: json["type"],
        seats: json["seats"],
        bags: json["bags"],
        features: List<String>.from(json["features"].map((x) => x)),
        rates: Rates.fromJson(json["rates"]),
        imageUrl: json["imageURL"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "make": make,
        "model": model,
        "year": year,
        "type": type,
        "seats": seats,
        "bags": bags,
        "features": List<dynamic>.from(features.map((x) => x)),
        "rates": rates.toJson(),
        "imageURL": imageUrl,
    };
}

class Rates {
    int hourly;
    int daily;
    int weekly;

    Rates({
        required this.hourly,
        required this.daily,
        required this.weekly,
    });

    factory Rates.fromJson(Map<String, dynamic> json) => Rates(
        hourly: json["hourly"],
        daily: json["daily"],
        weekly: json["weekly"],
    );

    Map<String, dynamic> toJson() => {
        "hourly": hourly,
        "daily": daily,
        "weekly": weekly,
    };
}
