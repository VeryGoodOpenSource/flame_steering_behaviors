import 'package:example/src/entities/entities.dart';
import 'package:example/src/example_game.dart';
import 'package:flame/components.dart';
import 'package:flame_test/flame_test.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final flameTester = FlameTester(ExampleGame.new);

  group('ExampleGame', () {
    test('can be instantiated', () {
      expect(ExampleGame(), isA<ExampleGame>());
    });

    flameTester.test(
      'generates the correct components',
      (game) async {
        expect(game.firstChild<FpsTextComponent>(), isNotNull);
        expect(game.firstChild<ScreenHitbox>(), isNotNull);
        expect(game.children.whereType<Dot>().length, equals(100));
      },
    );
  });
}
