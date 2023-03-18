import Foundation

protocol WeatherDataType {
    var date: Date? { get }
    var icon: String { get }
    var description: String { get }
    var temperature: Double { get }
    var maxTemperature: Double? { get }
    var minTemperature: Double? { get }
}
