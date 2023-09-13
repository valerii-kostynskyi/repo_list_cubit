import 'package:flutter/material.dart';
import 'package:repo_list_cubit/presentation/components/svg_icon_widget.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('detail'),
        leading: SizedBox(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SVGIconWidget(
              icon: 'icon_left',
              onTap: () => Navigator.of(context).pop(),
            ),
          ),
        ),
      ),
    );
  }
}
