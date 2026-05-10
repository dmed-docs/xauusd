class SignalModel {
  final String id;
  final String strategy;
  final String direction; // 'LONG' yoki 'SHORT'
  final double entryPrice;
  final double stopLoss;
  final double takeProfit1;
  final double takeProfit2;
  final DateTime createdAt;
  final bool isActive;

  SignalModel({
    required this.id,
    required this.strategy,
    required this.direction,
    required this.entryPrice,
    required this.stopLoss,
    required this.takeProfit1,
    required this.takeProfit2,
    required this.createdAt,
    this.isActive = true,
  });

  // JSON ga o'girish
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'strategy': strategy,
      'direction': direction,
      'entryPrice': entryPrice,
      'stopLoss': stopLoss,
      'takeProfit1': takeProfit1,
      'takeProfit2': takeProfit2,
      'createdAt': createdAt.toIso8601String(),
      'isActive': isActive,
    };
  }

  // JSON dan yaratish
  factory SignalModel.fromJson(Map<String, dynamic> json) {
    return SignalModel(
      id: json['id'],
      strategy: json['strategy'],
      direction: json['direction'],
      entryPrice: json['entryPrice'],
      stopLoss: json['stopLoss'],
      takeProfit1: json['takeProfit1'],
      takeProfit2: json['takeProfit2'],
      createdAt: DateTime.parse(json['createdAt']),
      isActive: json['isActive'] ?? true,
    );
  }

  SignalModel copyWith({
    String? id,
    String? strategy,
    String? direction,
    double? entryPrice,
    double? stopLoss,
    double? takeProfit1,
    double? takeProfit2,
    DateTime? createdAt,
    bool? isActive,
  }) {
    return SignalModel(
      id: id ?? this.id,
      strategy: strategy ?? this.strategy,
      direction: direction ?? this.direction,
      entryPrice: entryPrice ?? this.entryPrice,
      stopLoss: stopLoss ?? this.stopLoss,
      takeProfit1: takeProfit1 ?? this.takeProfit1,
      takeProfit2: takeProfit2 ?? this.takeProfit2,
      createdAt: createdAt ?? this.createdAt,
      isActive: isActive ?? this.isActive,
    );
  }
}
