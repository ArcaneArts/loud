import 'package:loud/noise/provider/seeded.dart';
import 'package:loud/util/magic.dart';

class SimplexProvider extends SeededProvider {
  SimplexProvider({required int seed}) : super(seed: seed);

  @override
  double noise3(double x, double y, double z) {
    double t = (x + y + z) * F3;
    int i = floor(x + t);
    int j = floor(y + t);
    int k = floor(z + t);
    t = (i + j + k) * G3;
    double x0 = x - (i - t);
    double y0 = y - (j - t);
    double z0 = z - (k - t);
    int i1, j1, k1;
    int i2, j2, k2;

    if (x0 >= y0) {
      if (y0 >= z0) {
        i1 = 1;
        j1 = 0;
        k1 = 0;
        i2 = 1;
        j2 = 1;
        k2 = 0;
      } else if (x0 >= z0) {
        i1 = 1;
        j1 = 0;
        k1 = 0;
        i2 = 1;
        j2 = 0;
        k2 = 1;
      } else // x0 < z0
      {
        i1 = 0;
        j1 = 0;
        k1 = 1;
        i2 = 1;
        j2 = 0;
        k2 = 1;
      }
    } else // x0 < y0
    {
      if (y0 < z0) {
        i1 = 0;
        j1 = 0;
        k1 = 1;
        i2 = 0;
        j2 = 1;
        k2 = 1;
      } else if (x0 < z0) {
        i1 = 0;
        j1 = 1;
        k1 = 0;
        i2 = 0;
        j2 = 1;
        k2 = 1;
      } else // x0 >= z0
      {
        i1 = 0;
        j1 = 1;
        k1 = 0;
        i2 = 1;
        j2 = 1;
        k2 = 0;
      }
    }

    double x1 = x0 - i1 + G3;
    double y1 = y0 - j1 + G3;
    double z1 = z0 - k1 + G3;
    double x2 = x0 - i2 + F3;
    double y2 = y0 - j2 + F3;
    double z2 = z0 - k2 + F3;
    double x3 = x0 + G33;
    double y3 = y0 + G33;
    double z3 = z0 + G33;

    double n0, n1, n2, n3;

    t = 0.6 - x0 * x0 - y0 * y0 - z0 * z0;
    if (t < 0) {
      n0 = 0;
    } else {
      t *= t;
      n0 = t * t * gradCoord3D(seed, i, j, k, x0, y0, z0);
    }

    t = 0.6 - x1 * x1 - y1 * y1 - z1 * z1;
    if (t < 0) {
      n1 = 0;
    } else {
      t *= t;
      n1 = t * t * gradCoord3D(seed, i + i1, j + j1, k + k1, x1, y1, z1);
    }

    t = 0.6 - x2 * x2 - y2 * y2 - z2 * z2;
    if (t < 0) {
      n2 = 0;
    } else {
      t *= t;
      n2 = t * t * gradCoord3D(seed, i + i2, j + j2, k + k2, x2, y2, z2);
    }

    t = 0.6 - x3 * x3 - y3 * y3 - z3 * z3;
    if (t < 0) {
      n3 = 0;
    } else {
      t *= t;
      n3 = t * t * gradCoord3D(seed, i + 1, j + 1, k + 1, x3, y3, z3);
    }

    return 32 * (n0 + n1 + n2 + n3);
  }
}
