import 'package:flame/extensions.dart';
import 'package:flame_test/flame_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:steering_behaviors/steering_behaviors.dart';

import '../../helpers/helpers.dart';

class _TestSteeringCore extends SteeringCore {
  @override
  Vector2 getSteering(Steerable parent) {
    throw UnimplementedError();
  }
}

void main() {
  group('SteeringCore', () {
    test('calculates the acceleration value towards the target', () {
      final parent = SteerableEntity(position: Vector2(10, 0));
      final target = Vector2(0, 10);

      final steeringCore = _TestSteeringCore();
      final steering = steeringCore.seek(parent, target);

      expect(steering, closeToVector(-70.71, 70.71, epsilon: 0.01));
    });
  });
}
