import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/earthquake.dart';

/// Error dengan pesan yang siap ditampilkan ke pengguna.
class EarthquakeException implements Exception {
  const EarthquakeException(this.message);

  final String message;

  @override
  String toString() => message;
}

/// Satu-satunya tempat yang memanggil http.
class EarthquakeService {
  EarthquakeService({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;

  static final Uri _endpoint =
      Uri.parse('https://data.bmkg.go.id/DataMKG/TEWS/gempaterkini.json');

  Future<List<Earthquake>> fetchRecent() async {
    try {
      final response =
          await _client.get(_endpoint).timeout(const Duration(seconds: 15));

      if (response.statusCode != 200) {
        throw EarthquakeException(
          'Server BMKG merespons dengan kode ${response.statusCode}. '
          'Silakan coba lagi nanti.',
        );
      }

      final decoded = jsonDecode(response.body) as Map<String, dynamic>;
      final list = decoded['Infogempa']['gempa'] as List<dynamic>;
      final result = list
          .map((e) => Earthquake.fromJson(e as Map<String, dynamic>))
          .toList();

      if (result.isEmpty) {
        throw const EarthquakeException('Belum ada data gempa yang tersedia.');
      }
      return result;
    } on EarthquakeException {
      rethrow;
    } on TimeoutException {
      throw const EarthquakeException(
        'Permintaan terlalu lama. Periksa koneksi internet Anda.',
      );
    } on http.ClientException {
      throw const EarthquakeException(
        'Tidak dapat terhubung ke server. Periksa koneksi internet Anda.',
      );
    } on FormatException {
      throw const EarthquakeException('Format data dari server tidak valid.');
    } catch (_) {
      throw const EarthquakeException(
        'Terjadi kesalahan saat memuat data gempa.',
      );
    }
  }
}
