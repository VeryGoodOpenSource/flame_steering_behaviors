// ignore_for_file: cascade_invocations

import 'package:flame/extensions.dart';
import 'package:flame_steering_behaviors/flame_steering_behaviors.dart';
import 'package:flame_test/flame_test.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/helpers.dart';

void main() {
  final flameTester = FlameTester(TestGame.new);

  group('PursueBehavior', () {
    flameTester.test(
      'only pursue if target is within pursue distance',
      (game) async {
        final target = SteerableEntity();
        final parent = SteerableEntity(
          behaviors: [
            PursueBehavior(
              target,
              pursueRange: 20,
            ),
          ],
          position: Vector2.zero(),
          size: Vector2.all(32),
        );
        await game.ensureAddAll([parent, target]);

        // Move target outside pursue distance.
        target.position.setValues(20, 20);
        game.update(1);

        expect(parent.velocity, closeToVector(Vector2(0, 0), 0.01));

        // Move target inside pursue distance.
        target.position.setValues(5, 5);
        game.update(1);

        expect(parent.velocity, closeToVector(Vector2(70.71, 70.71), 0.01));
      },
    );

    flameTester.testGameWidget(
      'render pursue distance as a circle in debug mode',
      setUp: (game, tester) async {
        final entity = SteerableEntity(
          behaviors: [
            PursueBehavior(
              SteerableEntity(),
              pursueRange: 64,
            ),
          ],
          position: Vector2.zero(),
          size: Vector2.all(32),
        )..debugMode = true;

        await game.ensureAdd(entity);
        game.camera.followComponent(entity);
      },
      verify: (game, tester) async {
        await tester.pump();

        await expectLater(
          find.byGame<TestGame>(),
          matchesGoldenFile('golden/pursue_behavior/render_debug_mode.png'),
        );
      },
    );
  });
}
