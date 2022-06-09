import 'dart:math';

import 'package:flame/extensions.dart';
import 'package:flame_test/flame_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:steering_behaviors/steering_behaviors.dart';

import '../../helpers/helpers.dart';

class _MockRandom extends Mock implements Random {}

void main() {
  final flameTester = FlameTester(TestGame.new);

  group('WanderBehavior', () {
    late Random random;

    setUp(() {
      random = _MockRandom();
      when(random.nextDouble).thenReturn(0);
    });

    flameTester.test(
      'calculates the new angle and wandering force',
      (game) async {
        const startAngle = 90 * degrees2Radians;
        const randomValue = 0.25;
        const maximumAngle = 90 * degrees2Radians;

        const expectedAngle =
            startAngle + (randomValue * maximumAngle) - (maximumAngle * 0.5);

        final wanderBehavior = WanderBehavior(
          circleDistance: 40,
          maximumAngle: maximumAngle,
          startingAngle: startAngle,
        )..testRandom = random;

        final parent = SteerableEntity(behaviors: [wanderBehavior]);

        when(random.nextDouble).thenReturn(0.25);

        expect(wanderBehavior.angle, expectedAngle);
        expect(parent.velocity, closeToVector(0, 40, epsilon: 0.01));
      },
    );
  });
}
