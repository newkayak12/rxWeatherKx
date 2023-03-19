import Foundation
import CoreLocation
import RxSwift

struct StaticLocationProvider: LocationProviderType {
    
    @discardableResult
    func currentLocation() -> RxSwift.Observable<CLLocation> {
        return Observable.just(CLLocation.gangnamStation)
    }
    
    @discardableResult
    func currentAddress() -> RxSwift.Observable<String> {
        return Observable.just("강남역")
    }
    
    
}
