import Foundation
import UIKit

final class Swizzler {
    class func load() {
        UIButton.xxx_swizzleSendAction()
    }
}

private var hasSwizzled = false

private var key: Void?
private var key2: Void?

extension UIButton: EventProtocol {
    var eventNameType: EventName? {
        get {
            return EventName(rawValue: eventName ?? "")
        }
        
        set {
            eventName = newValue?.rawValue
        }
    }
    
    @IBInspectable var eventName: String? {
        get {
            return objc_getAssociatedObject(self, &key) as? String
        }
        
        set {
            objc_setAssociatedObject(self, &key, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    var params: [String : Any]? {
        get {
            return objc_getAssociatedObject(self, &key2) as? [String : Any]
        }
        
        set {
            objc_setAssociatedObject(self, &key2, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
}

extension UIButton {
    var name: String {
        get { return String(describing: self) }
    }
    
    /**
     * The full name of the enumeration
     * (the name of the enum plus dot plus the name as written in case).
     */
    var reflecting: String {
        get { return String(reflecting: self) }
    }
    
    class func xxx_swizzleSendAction() {
        guard !hasSwizzled else { return }
        
        hasSwizzled = true
        let cls: AnyClass! = UIButton.self
        let originalSelector = #selector(sendAction(_:to:for:))
        let swizzledSelector = #selector(xxx_sendAction(_:to:for:))
        
        guard let originalMethod =
                class_getInstanceMethod(cls, originalSelector),
              let swizzledMethod =
                class_getInstanceMethod(cls, swizzledSelector) else { return }
        
        method_exchangeImplementations(originalMethod, swizzledMethod)
    }
    
    @objc public func xxx_sendAction(_ action: Selector, to target: Any?, for event: UIEvent?) {
        struct xxx_buttonTapCounter {
            static var count: Int = 0
        }
        
        xxx_buttonTapCounter.count += 1
        if let eventName = eventName {
            print(eventName)
        }
        xxx_sendAction(action, to: target, for: event)
    }
}
