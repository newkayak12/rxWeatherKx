import UIKit
import CoreLocation
import RxSwift
import RxCocoa

extension CLLocationManager: HasDelegate {
    public typealias Delegate = CLLocationManagerDelegate
    
}

public class RxCLLocationManagerDelegateProxy: DelegateProxy<CLLocationManager, CLLocationManagerDelegate>, DelegateProxyType, CLLocationManagerDelegate {
    
    public init(locationManager: CLLocationManager) {
        super.init(parentObject: locationManager, delegateProxy: RxCLLocationManagerDelegateProxy.self)
    }
    
    public static func registerKnownImplementations() {
        self.register{ RxCLLocationManagerDelegateProxy(locationManager: $0)}
    }
}

extension Reactive where Base: CLLocationManager {
    var delegate: DelegateProxy<CLLocationManager, CLLocationManagerDelegate> {
        return RxCLLocationManagerDelegateProxy.proxy(for: base)
    }
    
    public var didUpdateLocation: Observable<[CLLocation]> {
        let sel = #selector(CLLocationManagerDelegate.locationManager(_:didUpdateLocations:))
        return delegate.methodInvoked(sel)
            .map{ parameters in
                return parameters[1] as! [CLLocation]
                
            }
    }
    
    public var didChangeAuthorizationStatus: Observable<CLAuthorizationStatus> {
        let sel: Selector
        
        if #available(iOS 14.0, *) {
            sel = #selector(CLLocationManagerDelegate.locationManagerDidChangeAuthorization(_:))
            return delegate.methodInvoked(sel)
                .map { parameters in
                    return (parameters[0] as! CLLocationManager).authorizationStatus
                }
            
        } else {
            sel = #selector(CLLocationManagerDelegate.locationManager(_:didChangeAuthorization:))
            return delegate.methodInvoked(sel)
                .map { parameters in
                    return CLAuthorizationStatus(rawValue: parameters[1] as! Int32) ?? .notDetermined
                }
        }
    }
}
