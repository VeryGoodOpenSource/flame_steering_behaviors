// ignore_for_file: cascade_invocations

import 'package:example/src/behaviors/behaviors.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flame_test/flame_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/helpers.dart';

class _MockScreenHitbox extends Mock implements ScreenHitbox {}

class _TestEntity extends Entity {
  _TestEntity({
    super.position,
  }) : super(size: Vector2.all(50));
}

void main() {
  final flameTester = FlameTester(TestGame.new);

  group('ScreenCollisionBehavior', () {
    late ScreenHitbox screenHitbox;

    setUp(() {
      screenHitbox = _MockScreenHitbox();
      when(() => screenHitbox.position).thenReturn(NotifyingVector2.zero());
      when(() => screenHitbox.scaledSize).thenReturn(Vector2.all(200));
    });

    flameTester.test('does not move the parent entity', (game) async {
      final screenCollisionBehavior = ScreenCollisionBehavior();
      final entity = _TestEntity();

      await entity.add(screenCollisionBehavior);
      await game.ensureAdd(entity);

      screenCollisionBehavior.onCollisionEnd(screenHitbox);
      expect(entity.position, closeToVector(0, 0));
    });

    flameTester.test('moves parent entity from top to bottom', (game) async {
      final screenCollisionBehavior = ScreenCollisionBehavior();
      final entity = _TestEntity(position: Vector2(-25, 0));

      await entity.add(screenCollisionBehavior);
      await game.ensureAdd(entity);

      screenCollisionBehavior.onCollisionEnd(screenHitbox);
      expect(entity.position, closeToVector(200, 0));
    });

    flameTester.test('moves parent entity from bottom to top', (game) async {
      final screenCollisionBehavior = ScreenCollisionBehavior();
      final entity = _TestEntity(position: Vector2(225, 0));

      await entity.add(screenCollisionBehavior);
      await game.ensureAdd(entity);

      screenCollisionBehavior.onCollisionEnd(screenHitbox);
      expect(entity.position, closeToVector(0, 0));
    });

    flameTester.test('moves parent entity from left to right', (game) async {
      final screenCollisionBehavior = ScreenCollisionBehavior();
      final entity = _TestEntity(position: Vector2(0, -25));

      await entity.add(screenCollisionBehavior);
      await game.ensureAdd(entity);

      screenCollisionBehavior.onCollisionEnd(screenHitbox);
      expect(entity.position, closeToVector(0, 200));
    });

    flameTester.test('moves parent entity from right to left', (game) async {
      final screenCollisionBehavior = ScreenCollisionBehavior();
      final entity = _TestEntity(position: Vector2(0, 225));

      await entity.add(screenCollisionBehavior);
      await game.ensureAdd(entity);

      screenCollisionBehavior.onCollisionEnd(screenHitbox);
      expect(entity.position, closeToVector(0, 0));
    });
  });
}
