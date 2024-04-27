# Text Scatter

A Flutter widget that scatters text on the screen.

## Getting Started

To use this package, add `text_scatter` as a [dependency in your pubspec.yaml file](https://flutter.dev/docs/development/packages-and-plugins/using-packages).

## Demo



<div align="center">
<img src="https://user-images.githubusercontent.com/32483302/261020519-bc3d9326-e2a2-4544-a0ca-e378ee2145fa.gif" alt="WeChat Donation" width="600"/>
</div>



## Example

Here is a simple usage example:

```dart
import 'package:flutter/material.dart';
import 'package:text_scatter/text_scatter.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        body: Center(
          child: TextScatter(text: 'Hello, World!'),
        ),
      ),
    ),
  );
}






