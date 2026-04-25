import 'package:flutter/material.dart';
import 'package:otp_control/otp_control.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'OTP Control Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const OtpDemoScreen(),
    );
  }
}

class OtpDemoScreen extends StatefulWidget {
  const OtpDemoScreen({super.key});

  @override
  State<OtpDemoScreen> createState() => _OtpDemoScreenState();
}

class _OtpDemoScreenState extends State<OtpDemoScreen> {
  String basicOtp = "";
  String customOtp = "";
  String obscuredOtp = "";
  String liveOtp = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("OTP Control Demo"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // ---------------- BASIC OTP ----------------
            const Text(
              "Basic OTP (Default - 6 digits)",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            Center(
              child: OtpField(
                onCompleted: (value) {
                  setState(() {
                    basicOtp = value;
                  });
                },
              ),
            ),

            const SizedBox(height: 8),
            Text("Completed OTP: $basicOtp"),
            const Divider(height: 30),

            // ---------------- CUSTOM LENGTH ----------------
            const Text(
              "Custom OTP (4 digits)",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            Center(
              child: OtpField(
                length: 4,
                fieldWidth: 60,
                onCompleted: (value) {
                  setState(() {
                    customOtp = value;
                  });
                },
              ),
            ),

            const SizedBox(height: 8),
            Text("Completed OTP: $customOtp"),
            const Divider(height: 30),

            // ---------------- OBSCURED OTP ----------------
            const Text(
              "Obscured OTP (Hidden Input)",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            Center(
              child: OtpField(
                obscureText: true,
                onCompleted: (value) {
                  setState(() {
                    obscuredOtp = value;
                  });
                },
              ),
            ),

            const SizedBox(height: 8),
            Text("Completed OTP: $obscuredOtp"),
            const Divider(height: 30),

            // ---------------- LIVE OTP TRACKING ----------------
            const Text(
              "Live OTP Tracking (onChanged)",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            Center(
              child: OtpField(
                onChanged: (value) {
                  setState(() {
                    liveOtp = value;
                  });
                },
              ),
            ),

            const SizedBox(height: 12),
            Text(
              "Live Input: $liveOtp",
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}