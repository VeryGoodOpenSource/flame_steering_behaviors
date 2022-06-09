import 'package:flame/extensions.dart';
import 'package:flame_test/flame_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:steering_behaviors/steering_behaviors.dart';

import '../../helpers/helpers.dart';

void main() {
  group('Flee', () {
    test('calculates the fleeing linear acceleration', () {
      final parent = SteerableEntity(position: Vector2.all(10));
      final target = SteerableEntity(position: Vector2.zero());

      final flee = Flee(
        target,
        panicDist: 100,
        decelerateOnStop: true,
        maxAcceleration: 50,
        timeToTarget: 0.1,
      );

      final steering = flee.getSteering(parent);

      expect(steering, closeToVector(35.35, 35.35, epsilon: 0.01));
    });
  });
}
