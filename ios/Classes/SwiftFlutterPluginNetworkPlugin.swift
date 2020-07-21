import Flutter
import UIKit
import AFNetworking

public class SwiftFlutterPluginNetworkPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_plugin_network", binaryMessenger: registrar.messenger())
    let instance = SwiftFlutterPluginNetworkPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

    
  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    if "doRequest" == call.method {
        guard let arg = call.arguments as? NSDictionary, let arguments = arg["param"] as? NSDictionary  else { return };
        let url = arg["url"] as? String ?? ""
        doRequest(url: url, params: arguments, result: result)
    } else {
        result(FlutterMethodNotImplemented)
    }
  }
    
    private func doRequest(url: String, params: NSDictionary, result: @escaping FlutterResult) {
        let manager = AFHTTPSessionManager()
        manager.responseSerializer = AFHTTPResponseSerializer()
        let newParams = params
        newParams.setValue("yyyy", forKey: "ppp")
        manager.get(url, parameters: newParams, progress: nil, success: { (task, res) in
            if let data = res as? Data {
                let string = String(data: data, encoding: .utf8) ?? ""
                result(string)
            }
        }) { (task, error) in
            result(FlutterError(code: "Error", message: error.localizedDescription, details: nil))
        }
    }
}
