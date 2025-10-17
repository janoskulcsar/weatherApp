import 'package:flutter/material.dart';
import 'weather_service.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) => const MaterialApp(home: WeatherPage());
}

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});
  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final WeatherService service = WeatherService();
  final TextEditingController controller = TextEditingController();
  Map<String, dynamic>? data;
  bool loading = false;
  String error = '';

  Future<void> search() async {
    setState(() { loading = true; error = ''; data = null; });
    try {
      final result = await service.getWeather(controller.text);
      setState(() => data = result);
    } catch (e) {
      setState(() => error = e.toString());
    } finally {
      setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Weather App')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(labelText: 'Város neve'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: loading ? null : search,
              child: const Text('Lekérés'),
            ),
            if (loading) const CircularProgressIndicator(),
            if (error.isNotEmpty)
              Text(error, style: const TextStyle(color: Colors.red)),
            if (data != null)
              Card(
                margin: const EdgeInsets.only(top: 16),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text('${data!['name']} (${data!['sys']['country']})'),
                      Text('${data!['weather'][0]['description']}'),
                      Text('Hőmérséklet: ${data!['main']['temp']}°C'),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
