class TokenInfo {
  final String tokenType;
  final String token;
  final DateTime expiryAt;

  TokenInfo({
    required this.tokenType,
    required this.token,
    required this.expiryAt,
  });

  factory TokenInfo.fromJson(Map<String, dynamic> data) {
    return TokenInfo(
      tokenType: data['token'],
      token: data['token-type'],
      expiryAt: data['expiry-at'],
    );
  }
}
