import 'dart:math';

import 'package:flame/extensions.dart';
import 'package:flame_steering_behaviors/flame_steering_behaviors.dart';
import 'package:flame_test/flame_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/helpers.dart';

class _MockRandom extends Mock implements Random {}

void main() {
  final flameTester = FlameTester(TestGame.new);

  group('WanderBehavior', () {
    late Random random;

    setUp(() {
      random = _MockRandom();
    });

    test('fall back to normal Random if none is given', () {
      final behavior = WanderBehavior(
        circleDistance: 1,
        maximumAngle: 2,
        startingAngle: 3,
      );

      expect(behavior.random, isA<Random>());
    });

    flameTester.test(
      'calculates the new angle and wandering force',
      (game) async {
        const startAngle = 90 * degrees2Radians;
        const randomValue = 0.25;
        const maximumAngle = 90 * degrees2Radians;

        const expectedAngle =
            startAngle + (randomValue * maximumAngle) - (maximumAngle * 0.5);

        when(random.nextDouble).thenReturn(randomValue);

        final wanderBehavior = WanderBehavior(
          circleDistance: 40,
          maximumAngle: maximumAngle,
          startingAngle: startAngle,
          random: random,
        );

        final parent = SteerableEntity(behaviors: [wanderBehavior]);
        await game.ensureAdd(parent);
        game.update(1);

        expect(wanderBehavior.angle, expectedAngle);
        expect(parent.velocity, closeToVector(Vector2(0, 40), 0.01));
      },
    );
  });
}
