import Foundation

enum EventName: String {
    case button1
    case button2
    case button3
    case button4
}

protocol EventProtocol: AnyObject {
    var eventName: String? { get set}
    var params: [String: Any]? { get set }
}
