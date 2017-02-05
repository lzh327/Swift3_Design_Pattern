//: Playground - noun: a place where people can play

import UIKit

protocol Subject {
    func registerObserver(observer: Observer)
    func removeObserver(observer: Observer)
    func notifyObservers()
}

protocol Observer {
    var name: String {get}
    //Here the argument should be more flex, we could modify it by pass another object blablabla
    func update(temperature: Double, humidity: Double, pressure: Double)
}

protocol DisplayElement {
    func display()
}

class WeatherData: Subject {
    //Here I use Dictionary to store the observer
    //if I use Array or Set, then I need to let Observer to be Equatable or Hashable(which in turn inherits from protocol Equatable), Protocol Equatable has the following requirement: func ==(lhs: Self, rhs: Self) -> Bool.
    //And a protocol that contains Self somewhere inside it cannot be used anywhere except in a type constraint.
    //And I will meet an error of "Protocol 'Observer' can only be used as a generic constraint because it has Self or associated type requirements"
    private var observers: [String: Observer]
    private var temperature: Double!
    private var humidity: Double!
    private var pressure: Double!
    
    init() {
        observers = [String: Observer]()
    }
    
    func registerObserver(observer: Observer) {
        observers[observer.name] = observer
    }
    
    func removeObserver(observer: Observer) {
        observers[observer.name] = nil
    }
    
    func notifyObservers() {
        for observer in observers.values {
            observer.update(temperature: temperature, humidity: humidity, pressure: pressure)
        }
    }
    
    func measurementsChanged() {
        notifyObservers()
    }
    
    func setMeasurements(temperature: Double, humidity: Double, pressure: Double) {
        self.temperature = temperature
        self.humidity = humidity
        self.pressure = pressure
        measurementsChanged()
    }
}

class CurrentConditionsDisplay: Observer, DisplayElement {
    let name: String
    
    private var temperature: Double!
    private var humifity: Double!
    var subject: Subject
    
    init(subject: Subject) {
        self.name = "Current Conditions"
        self.subject = subject
        self.subject.registerObserver(observer: self)
    }
    
    func update(temperature: Double, humidity: Double, pressure: Double) {
        self.temperature = temperature
        self.humifity = humidity
        display()
    }
    
    func display() {
        print("Current conditions: temperature is \(self.temperature)F degrees and humidity is \(self.humifity).")
    }
}

class StatisticsDisplay: Observer, DisplayElement {
    let name: String
    
    private var temperatures: [Double]
    var subject: Subject
    
    init(subject: Subject) {
        self.name = "Statistics"
        self.temperatures = []
        self.subject = subject
        self.subject.registerObserver(observer: self)
    }
    
    func update(temperature: Double, humidity: Double, pressure: Double) {
        temperatures.append(temperature)
        display()
    }
    
    var max: Double {
        return temperatures.max()!
    }
    
    var min: Double {
        return temperatures.min()!
    }
    
    var average: Double {
        if temperatures.isEmpty {
            return 0
        } else {
            let average: Double = (temperatures as NSArray).value(forKeyPath: "@avg.self") as! Double
            return average
        }
    }
    
    func display() {
        print("Avg/Max/Min: temperature = \(self.average), \(self.max), \(self.min)")
    }
}

let weatherData = WeatherData()
let currentDisplay = CurrentConditionsDisplay(subject: weatherData)
let statisticsDisplay = StatisticsDisplay(subject: weatherData)

weatherData.setMeasurements(temperature: 80, humidity: 65, pressure: 30.4)
weatherData.setMeasurements(temperature: 82, humidity: 70, pressure: 38.5)








