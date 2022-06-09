import 'package:flame/extensions.dart';
import 'package:flame_test/flame_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:steering_behaviors/steering_behaviors.dart';

import '../../helpers/helpers.dart';

void main() {
  group('Separation', () {
    test('calculates the acceleration needed to separate', () {
      final parent = SteerableEntity(
        position: Vector2.zero(),
        size: Vector2.all(32),
      );

      final steering = Separation(
        [
          SteerableEntity(
            position: Vector2.all(10),
            size: Vector2.all(32),
          ),
          SteerableEntity(
            position: Vector2.all(20),
            size: Vector2.all(32),
          ),
        ],
        maxSepDist: 50,
        sepMaxAcceleration: 10,
      );

      final linearAcceleration = steering.getSteering(parent);

      expect(linearAcceleration, closeToVector(-29.08, -29.08, epsilon: 0.01));
    });

    test('skips self', () {
      final parent = SteerableEntity(
        position: Vector2.zero(),
        size: Vector2.all(32),
      );

      final steering = Separation(
        [parent],
        maxSepDist: 50,
        sepMaxAcceleration: 10,
      );

      final linearAcceleration = steering.getSteering(parent);

      expect(linearAcceleration, closeToVector(0, 0));
    });

    test('does not separate if other entities are too far away', () {
      final parent = SteerableEntity(position: Vector2.zero());

      final steering = Separation(
        [
          SteerableEntity(
            position: Vector2.all(36),
            size: Vector2.all(32),
          ),
          SteerableEntity(
            position: Vector2.all(-36),
            size: Vector2.all(32),
          ),
        ],
        maxSepDist: 50,
        sepMaxAcceleration: 10,
      );

      final linearAcceleration = steering.getSteering(parent);

      expect(linearAcceleration, closeToVector(0, 0));
    });
  });
}