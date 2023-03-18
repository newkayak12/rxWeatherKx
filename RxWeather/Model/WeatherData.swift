import Foundation
import RxCocoa
import RxDataSources

struct WeatherData: WeatherDataType, Equatable {
    let date: Date?
    let icon: String
    let description: String
    let temperature: Double
    let maxTemperature: Double?
    let minTemperature: Double?
}

extension WeatherData {
    init(summary: WeatherSummary) {
        date = Date()
        icon = summary.weather.first?.icon ?? ""
        description = summary.weather.first?.description ?? "알 수 없음"
        temperature = summary.main.temp
        maxTemperature = summary.main.temp_max
        minTemperature = summary.main.temp_min
    }
    
    init(forecastItem: Forecast.ListItem) {
        date = Date(timeIntervalSince1970: TimeInterval(forecastItem.dt))
        icon = forecastItem.weather.first?.icon ?? ""
        description = forecastItem.weather.first?.description ?? "알 수 없음"
        temperature = forecastItem.main.temp
        maxTemperature = nil
        minTemperature = nil
    }
}

extension WeatherData: IdentifiableType {
    var identity: Double {
        return date?.timeIntervalSinceReferenceDate ?? 0
    }
}
