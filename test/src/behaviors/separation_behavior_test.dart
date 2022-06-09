import 'package:flame/extensions.dart';
import 'package:flame_test/flame_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:steering_behaviors/steering_behaviors.dart';

import '../../helpers/helpers.dart';

void main() {
  final flameTester = FlameTester(TestGame.new);

  group('SeparationBehavior', () {
    flameTester.test(
      'calculates the acceleration needed to separate',
      (game) async {
        final separationBehavior = SeparationBehavior(
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

        final parent = SteerableEntity(
          behaviors: [separationBehavior],
          position: Vector2.zero(),
          size: Vector2.all(32),
        );
        await game.ensureAdd(parent);
        game.update(1);

        expect(parent.velocity, closeToVector(-29.08, -29.08, epsilon: 0.01));
      },
    );
  });
}