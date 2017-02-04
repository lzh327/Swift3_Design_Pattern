//: Playground - noun: a place where people can play

import UIKit

// Fly behavior
protocol FlyBehavior {
    func fly()
}

class FlyWithWings: FlyBehavior {
    func fly() {
        print("I am flying with wings!!")
    }
}

class FlyNoWay: FlyBehavior {
    func fly() {
        print("I can't fly")
    }
}

class FlyRocketPowered: FlyBehavior {
    func fly() {
        print("I am flying with a rocket!")
    }
}

// Quack behavior
protocol QuackBehavior {
    func quack()
}

class Quack: QuackBehavior {
    func quack() {
        print("Quack")
    }
}

class MuteQuack: QuackBehavior {
    func quack() {
        print("<<Silence>>")
    }
}

class Squeak: QuackBehavior {
    func quack() {
        print("squeak")
    }
}

// Super Class
class Duck {
    var flyBehavior: FlyBehavior?
    var quackBehavior: QuackBehavior?
    
    func display(){
        
    }
    
    func performFly() {
        flyBehavior?.fly()
    }
    
    func performQuack(){
        quackBehavior?.quack()
    }
    
    func setFlyBehavior(flyBehavior: FlyBehavior) {
        self.flyBehavior = flyBehavior
    }
    
    func setQuackBehavior(quackBehavior: QuackBehavior) {
        self.quackBehavior = quackBehavior
    }
    
    func swim() {
        print("All duck float, even decoys!")
    }
}

// Concrete class
class MallardDuck: Duck {
    override init() {
        super.init()
        self.quackBehavior = Quack()
        self.flyBehavior = FlyWithWings()
    }
    
    override func display() {
        print("I am a real Mallard duck")
    }
}

class ModelDuck: Duck {
    override init() {
        super.init()
        self.flyBehavior = FlyNoWay()
        self.quackBehavior = Quack()
    }
    
    override func display() {
        print("I am a model duck")
    }
}

// Test code
let mallard: Duck = MallardDuck()
mallard.performFly()
mallard.performQuack()

let model: Duck = ModelDuck()
model.performFly()
model.performQuack()

model.setFlyBehavior(flyBehavior: FlyRocketPowered())
model.performFly()

