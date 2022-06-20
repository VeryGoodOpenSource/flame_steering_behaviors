// ignore_for_file: prefer_const_constructors
import 'package:flame_test/flame_test.dart';
import 'package:test/test.dart';

import '../../helpers/helpers.dart';

void main() {
  final flameTester = FlameTester(TestGame.new);

  group('Steerable', () {
    flameTester.test(
      'add velocity delta to position and subtract the delta from velocity',
      (game) async {
        final entity = SteerableEntity();
        entity.velocity.setValues(100, 100);

        await game.ensureAdd(entity);
        game.update(0.25);

        expect(entity.velocity, closeToVector(75, 75));
        expect(entity.position, closeToVector(25, 25));
      },
    );
  });
}
