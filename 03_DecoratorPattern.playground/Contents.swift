//: Playground - noun: a place where people can play

import UIKit

protocol Beverage {
    var description: String { get }
    func getDescription() -> String
    func cost() -> Double
}

class Espresso: Beverage {
    let description = "Espresso"
    
    func getDescription() -> String {
        return description
    }
    
    func cost() -> Double {
        return 1.99
    }
}

class HouseBlend: Beverage {
    let description = "House Blend Coffee"
    
    func getDescription() -> String {
        return description
    }
    
    func cost() -> Double {
        return 0.89
    }
}

class DarkRoast: Beverage {
    let description = "Dark Roast"
    
    func getDescription() -> String {
        return description
    }
    
    func cost() -> Double {
        return 1.5
    }
}

protocol CondimentDecorator: Beverage {
    func getDescription() -> String
}

class Mocha: CondimentDecorator {
    let beverage: Beverage
    let description: String
    
    init(beverage: Beverage) {
        self.description = ", Mocha"
        self.beverage = beverage
    }
    
    func getDescription() -> String {
        return beverage.getDescription() + self.description
    }
    
    func cost() -> Double {
        return 0.20 + beverage.cost()
    }
}

class Soy: CondimentDecorator {
    let beverage: Beverage
    let description: String
    
    init(beverage: Beverage) {
        self.description = ", Soy"
        self.beverage = beverage
    }
    
    func getDescription() -> String {
        return beverage.getDescription() + self.description
    }
    
    func cost() -> Double {
        return 0.50 + beverage.cost()
    }
}

class Whip: CondimentDecorator {
    let beverage: Beverage
    let description: String
    
    init(beverage: Beverage) {
        self.description = ", Whip"
        self.beverage = beverage
    }
    
    func getDescription() -> String {
        return beverage.getDescription() + self.description
    }
    
    func cost() -> Double {
        return 0.80 + beverage.cost()
    }
}

let beverage1: Beverage = Espresso()
print(beverage1.getDescription() + " $" + String(beverage1.cost()))

var beverage2: Beverage = DarkRoast()
beverage2 = Mocha(beverage: beverage2)
beverage2 = Mocha(beverage: beverage2)
beverage2 = Whip(beverage: beverage2)
print(beverage2.getDescription() + " $" + String(beverage2.cost()))

var beverage3: Beverage = HouseBlend()
beverage3 = Soy(beverage: beverage3)
beverage3 = Mocha(beverage: beverage3)
beverage3 = Whip(beverage: beverage3)
print(beverage3.getDescription() + " $" + String(beverage3.cost()))


