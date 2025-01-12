import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelancing/screens/orders/bloc/files_dailog_bloc.dart';
import 'package:freelancing/screens/orders/bloc/radio_bloc.dart';
import 'package:freelancing/screens/orders/bloc/stepper_bloc.dart';
import 'package:freelancing/screens/orders/bloc/widget_visibililty_bloc.dart';
import 'package:freelancing/screens/orders/orders_screen.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    List<String> steps = [
      'Order Confirmed, Tue 24th 2024 | 10:26 AM',
      "Picked up by courier partner Wed, 25th Jan '25 - 7:05pm",
      'Yet to Shipped',
      'Expected by, Mon 30th Jan ‘25',
    ];
    List<String> returnSteps = [
      "Return Applied, 11th Jan ‘25 12:43 AM",
      "Return Approved by Seller",
      "Pickup Completed",
      "Refund Completed",
    ];
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: GoogleFonts.montserrat().fontFamily,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MultiBlocProvider(providers: [
        BlocProvider(
          create: (context) => StepperBloc(steps, returnSteps),
        ),
        BlocProvider(
          create: (context) => RadioButtonBloc(),
        ),
        BlocProvider(
          create: (context) => FileDialogBloc(),
        ),
        BlocProvider(
          create: (context) => WidgetVisibilityBloc(),
        ),
      ], child: OrdersScreen()),
    );
  }
}
