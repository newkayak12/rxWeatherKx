import Foundation
import CoreLocation
import RxSwift

let summaryEndpoint = "https://api.openweathermap.org/data/2.5/weather"
let forecastEndpoint = "https://api.openweathermap.org/data/2.5/forecast"

func composeUrlRequest(endpoint: String, from location: CLLocation) -> Observable<URLRequest> {
    let urlStr = "\(endpoint)?lat=\(location.coordinate.latitude)&lon=\(location.coordinate.longitude)&appid=\(apiKey)&lang=kr&units=metric"
    
    return Observable.just(urlStr)
        .compactMap { URL(string: $0) }
        .map { URLRequest(url: $0) }    
}
