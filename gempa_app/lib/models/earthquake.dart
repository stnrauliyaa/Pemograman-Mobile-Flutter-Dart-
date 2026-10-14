/// Data gempa yang immutable, dibentuk dari JSON BMKG.
class Earthquake {
  const Earthquake({
    required this.date,
    required this.time,
    required this.magnitude,
    required this.depth,
    required this.region,
    required this.potential,
    required this.latitude,
    required this.longitude,
  });

  final String date;
  final String time;
  final double magnitude;
  final String depth;
  final String region;
  final String potential;
  final String latitude;
  final String longitude;

  factory Earthquake.fromJson(Map<String, dynamic> json) {
    String text(String key, String fallback) {
      final value = json[key]?.toString().trim();
      return (value == null || value.isEmpty) ? fallback : value;
    }

    return Earthquake(
      date: text('Tanggal', '-'),
      time: text('Jam', '-'),
      magnitude: double.tryParse(text('Magnitude', '0')) ?? 0,
      depth: text('Kedalaman', '-'),
      region: text('Wilayah', 'Wilayah tidak diketahui'),
      potential: text('Potensi', '-'),
      latitude: text('Lintang', '-'),
      longitude: text('Bujur', '-'),
    );
  }
}
