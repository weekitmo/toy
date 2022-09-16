import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

Future<ui.Image> loadImageProvider(
  ImageProvider provider, {
  ImageConfiguration config = ImageConfiguration.empty,
}) async {
  Completer<ui.Image> completer = Completer<ui.Image>();
  ImageStream stream = provider.resolve(config);
  late ImageStreamListener listener;

  listener = ImageStreamListener(
    (ImageInfo frame, bool sync) {
      final ui.Image image = frame.image;
      completer.complete(image);
      stream.removeListener(listener);
    },
    // ignore `onError` and `onChunk`.
  );
  stream.addListener(listener);
  return completer.future;
}

class SpritesLoaderPainter extends CustomPainter {
  late final ui.Image img;
  late Paint mainPaint;

  int showIndex = 0;

  SpritesLoaderPainter({
    required this.img,
    required this.showIndex,
  }) : mainPaint = Paint();

  @override
  void paint(ui.Canvas canvas, ui.Size size) {
    Rect dst = const Offset(0, 0) & size;
    // 裁剪绘制区域
    canvas.clipRect(dst);
    double showSize = img.width.toDouble();
    // 计算将要显示的区域
    Rect src = Rect.fromLTRB(
      0,
      showIndex * showSize,
      showSize,
      (showIndex + 1) * showSize,
    );
    canvas.drawImageRect(img, src, dst, mainPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    if (oldDelegate is SpritesLoaderPainter) {
      SpritesLoaderPainter oldPainter = oldDelegate;
      if (oldPainter.showIndex != showIndex ||
          oldPainter.mainPaint != mainPaint) {
        return true;
      }
    }
    return false;
  }
}

class SpriteImageWidget extends StatefulWidget {
  final int showIndex;
  final ui.Image img;

  const SpriteImageWidget({
    Key? key,
    required this.showIndex,
    required this.img,
  }) : super(key: key);

  @override
  State<SpriteImageWidget> createState() => _SpriteImageWidgetState();
}

class _SpriteImageWidgetState extends State<SpriteImageWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      width: 28,
      height: 28,
      child: CustomPaint(
        painter: SpritesLoaderPainter(
          img: widget.img,
          showIndex: widget.showIndex,
        ),
      ),
    );
  }
}
