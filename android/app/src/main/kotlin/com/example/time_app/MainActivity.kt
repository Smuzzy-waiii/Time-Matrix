package com.example.time_app
import android.os.Bundle
import io.flutter.app.FlutterActivity
import com.tekartik.sqflite.SqflitePlugin

import io.flutter.embedding.engine.FlutterEngine
import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.plugins.GeneratedPluginRegistrant


/*class MainActivity : FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        
        SqflitePlugin.registerWith(registrarFor("com.tekartik.sqflite.SqflitePlugin"))
    }
}*/

class MainActivity: FlutterFragmentActivity() {
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);
    }
}
