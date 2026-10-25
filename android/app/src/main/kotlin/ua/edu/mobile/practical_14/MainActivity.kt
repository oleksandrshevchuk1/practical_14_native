package ua.edu.mobile.practical_14

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "ua.edu.mobile/practical25")
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "getGreeting" -> result.success("Hi, Mom!")
                    else -> result.notImplemented()
                }
            }
    }
}
