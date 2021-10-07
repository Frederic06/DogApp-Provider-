
import 'package:flutter/material.dart';
import 'package:flutter_dopapp_provider/ui/bottom_bar.dart';
import 'package:provider/provider.dart';

import 'providers/breeds.dart';

class DogApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
            providers: [
        ChangeNotifierProvider.value(
          value: Breeds(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: BottomBarWidget(),
      ),
    );
  }
}