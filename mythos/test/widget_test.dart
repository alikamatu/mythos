import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mythos/main.dart';
import 'package:mythos/screens/auth_screen.dart';

void main() {
  testWidgets('Mythos home page elements and interaction test',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1170, 2532);
    tester.view.devicePixelRatio = 3.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const MythosApp());
    await tester.pump(const Duration(milliseconds: 300));

    // Verify Brand Header & Prometheus Spark
    expect(find.text('MYTHOS'), findsOneWidget);
    expect(find.text('7d Spark'), findsOneWidget);

    // Verify 3D Hero Card
    expect(find.text('The Fall of Icarus'), findsOneWidget);

    // Verify Oracle Section
    expect(find.text('ORACLE OF DELPHI'), findsOneWidget);

    // Scroll down to reveal Realms
    await tester.drag(find.byType(ListView).first, const Offset(0, -400));
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.text('Chronicles'), findsAtLeastNWidgets(1));
    expect(find.text('Trials of Delphi'), findsOneWidget);

    // Scroll down to reveal Olympians
    await tester.drag(find.byType(ListView).first, const Offset(0, -400));
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.text('ZEUS'), findsOneWidget);
    expect(find.text('ATHENA'), findsOneWidget);

    // Tap on Zeus to open Deity detail sheet
    await tester.tap(find.text('ZEUS'));
    await tester.pump(const Duration(milliseconds: 500));

    // Check Deity modal opened with details
    expect(find.text('Ζεύς'), findsAtLeastNWidgets(1));
    expect(find.text('Listen to Homeric Hymn to Zeus'), findsOneWidget);

    // Close Deity modal
    final NavigatorState navigator =
        tester.state(find.byType(Navigator).first);
    navigator.pop();
    await tester.pump(const Duration(milliseconds: 500));

    // Verify return to home screen
    expect(find.text('MYTHOS'), findsOneWidget);
  });

  testWidgets('Bottom navigation switches through all 5 screens and supports interaction',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1170, 2532);
    tester.view.devicePixelRatio = 3.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const MythosApp());
    await tester.pump(const Duration(milliseconds: 300));

    // 1. Switch to Chronicles tab
    await tester.tap(find.text('Chronicles').last);
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.text('THE CHRONICLES'), findsOneWidget);
    expect(find.text('Search heroes, titans, or epics...'), findsOneWidget);
    expect(find.text('The Gift of Prometheus'), findsAtLeastNWidgets(1));

    // 2. Switch to Trials tab & play interactive quiz
    await tester.tap(find.text('Trials').last);
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.text('TRIALS OF DELPHI'), findsOneWidget);
    expect(
      find.text('Which Titan was condemned to hold up the celestial heavens for eternity after the Titanomachy?'),
      findsOneWidget,
    );

    // Tap the correct answer (Atlas)
    final atlasOption = find.text('Atlas');
    expect(atlasOption, findsOneWidget);
    await tester.ensureVisible(atlasOption);
    await tester.pump(const Duration(milliseconds: 300));
    await tester.tap(atlasOption);
    await tester.pump(const Duration(milliseconds: 300));

    // Submit the answer
    final verifyButton = find.text('Verify Oracle Answer');
    await tester.ensureVisible(verifyButton);
    await tester.pump(const Duration(milliseconds: 300));
    await tester.tap(verifyButton);
    await tester.pump(const Duration(milliseconds: 300));

    // Verify feedback and explanation
    expect(find.text('Next Classical Trial'), findsOneWidget);
    expect(
      find.textContaining('Atlas led the Titans against the Olympians'),
      findsOneWidget,
    );

    // 3. Switch to Hellas Map tab & inspect landmark
    await tester.tap(find.text('Hellas Map').last);
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.text('HELLAS MAP & REALMS'), findsOneWidget);
    expect(find.text('Mount Olympus'), findsAtLeastNWidgets(1));
    expect(find.text('Throne of the Immortals & Mytikas Peak'), findsOneWidget);

    // Scroll down to view landmarks
    await tester.drag(find.byType(ListView).first, const Offset(0, -350));
    await tester.pump(const Duration(milliseconds: 300));

    // Tap Sanctuary of Delphi on map
    final delphiLandmark = find.text('Sanctuary of Delphi');
    expect(delphiLandmark, findsOneWidget);
    await tester.tap(delphiLandmark);
    await tester.pump(const Duration(milliseconds: 300));

    // 4. Switch to Settings tab & verify options
    await tester.tap(find.text('Settings').last);
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.text('USER SETTINGS'), findsOneWidget);
    expect(find.text('Mortal Initiate (Guest)'), findsOneWidget);
    expect(find.text('PATRON OLYMPIAN DEITY'), findsOneWidget);

    // Scroll down to view audio and system options
    await tester.drag(find.byType(ListView).first, const Offset(0, -350));
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.text('VOICE OF THE NARRATOR'), findsOneWidget);
    expect(find.text('Ancient Lyre & Kithara Ambiance'), findsOneWidget);

    // Scroll down to view classroom mode and system ping
    await tester.drag(find.byType(ListView).first, const Offset(0, -450));
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.text('Educator & Classroom Mode'), findsOneWidget);

    // Scroll to backend connection card
    await tester.drag(find.byType(ListView).first, const Offset(0, -350));
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.text('Mount Olympus FastAPI Gateway'), findsOneWidget);
    expect(find.text('Ping'), findsOneWidget);
    await tester.tap(find.text('Ping'));
    await tester.pump(const Duration(milliseconds: 300));

    // 5. Switch back to Sanctuary tab
    await tester.tap(find.text('Sanctuary').last);
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.text('MYTHOS'), findsOneWidget);
  });

  testWidgets('AuthScreen render and mode switch test',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1170, 2532);
    tester.view.devicePixelRatio = 3.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const MaterialApp(home: AuthScreen()));
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.text('TEMPLE OF DELPHI'), findsOneWidget);
    expect(find.text('Initiation (Sign Up)'), findsOneWidget);
    expect(find.text('Sanctuary (Sign In)'), findsOneWidget);
    expect(find.text('CHOOSE THY PATRON OLYMPIAN'), findsOneWidget);

    // Switch to Sign In mode
    await tester.tap(find.text('Sanctuary (Sign In)'));
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.text('Enter Mount Olympus'), findsOneWidget);
  });
}
