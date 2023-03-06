import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'app_loader.dart';

class AppImage extends StatelessWidget {
  const AppImage({
    super.key,
    required this.imageUrl,
    this.fit = BoxFit.cover,
    this.errorWidget,
  });

  final String imageUrl;
  final BoxFit fit;
  final Widget Function(BuildContext, String, dynamic)? errorWidget;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      placeholder: (context, url) => const AppLoader(),
      errorWidget:
          errorWidget ?? (context, url, error) => const Icon(Icons.error),
      fit: fit,
    );
  }
}
