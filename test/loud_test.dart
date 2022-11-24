import 'package:loud/noise/noise_plane.dart';
import 'package:loud/noise/provider/perlin.dart';

void main() async {
  NoisePlane plane = PerlinProvider(seed: 1234);

  List<double> noise =
      List.generate(128, (index) => plane.noise1(index.toDouble()));

  for (int i = 0; i < 12; i++) {
    String l = "";
    for (int j = 0; j < noise.length; j++) {
      int n = ((noise[j] * 6.0) + 6.0).toInt();
      if (n == i) {
        l += ".";
      } else {
        l += " ";
      }
    }
    print(l);
  }

  await Future.delayed(Duration(seconds: 10));
}