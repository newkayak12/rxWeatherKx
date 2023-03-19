import UIKit
import CoreLocation
import RxSwift
import RxCocoa
import NSObject_Rx

class CoreLocationProvider: LocationProviderType {
    init() {
        locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        locationManager.rx.didUpdateLocation
            .throttle(.seconds(5), scheduler: MainScheduler.instance)
            .map{ $0.last ?? CLLocation.gangnamStation }
            .bind(to: location)
            .disposed(by: disposeBag)
        
        location.flatMap{ location in
            return Observable<String>.create {
                observer in
                let geocoder = CLGeocoder()
                
                geocoder.reverseGeocodeLocation(location) {
                    (placemarks, error) in
                    if let place = placemarks?.first {
                        if let gu = place.locality, let dong = place.subLocality {
                            observer.onNext("\(gu) \(dong)")
                        } else {
                            observer.onNext(place.name ?? "알 수 없음")
                        }
                    } else {
                        observer.onNext("알 수 없음")
                    }
                    observer.onCompleted()
                }
                
                return Disposables.create()
            }
        } .bind(to: address)
        .disposed(by: disposeBag)
        
        
        locationManager.rx.didChangeAuthorizationStatus
            .map{
                $0 == .authorizedAlways || $0 == .authorizedWhenInUse
            }
            .bind(to: authorized)
            .disposed(by: disposeBag)
                
    }
    
    private let locationManager = CLLocationManager()
    private let location = BehaviorRelay<CLLocation>(value: CLLocation.gangnamStation)
    private let address = BehaviorRelay<String>(value: "강남역")
    private let authorized = BehaviorRelay<Bool>(value: false)
    
    private let disposeBag = DisposeBag()
    
    
    
    @discardableResult
    func currentLocation() -> RxSwift.Observable<CLLocation> {
        return location.asObservable()
    }
    
    @discardableResult
    func currentAddress() -> RxSwift.Observable<String> {
        return address.asObservable()
    }
    
    
}
