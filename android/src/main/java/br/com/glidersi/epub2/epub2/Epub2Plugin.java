package br.com.glidersi.epub2.epub2;

import androidx.annotation.NonNull;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

/** Epub2Plugin */
public class Epub2Plugin implements FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private MethodChannel channel;

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "epub2");
    channel.setMethodCallHandler(this);
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
     if (call.method.equals("setConfig")){
      Map<String,Object> arguments = (Map<String, Object>) call.arguments;
      String identifier = arguments.get("identifier").toString();
      String themeColor = arguments.get("themeColor").toString();
      String scrollDirection = arguments.get("scrollDirection").toString();
      Boolean allowSharing = Boolean.parseBoolean(arguments.get("allowSharing").toString());
      config = new ReaderConfig(context,identifier,themeColor,scrollDirection,allowSharing);

    } else if (call.method.equals("open")){

      Map<String,Object> arguments = (Map<String, Object>) call.arguments;
      String bookPath = arguments.get("bookPath").toString();

      reader = new Reader(context,messenger,config);
      reader.open(bookPath);

    }else if(call.method.equals("close")){
      reader.close();
    }

    else {
      result.notImplemented();
    }
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }
}
