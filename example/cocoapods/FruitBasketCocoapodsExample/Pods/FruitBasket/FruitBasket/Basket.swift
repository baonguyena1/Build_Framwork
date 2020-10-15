//
//  Basket.swift
//  FruitBasket
//
//  Created by Bao Nguyen on 2020/10/13.
//

import Foundation
import SwiftDate

public class Basket {
    
    private let capacity: Int
    private var fruits = [Fruit]()
    
    public var count: Int {
        return fruits.count
    }
    
    public init(_ capacity: Int) {
        self.capacity = capacity
    }
    
    public func add(_ fruit: Fruit) {
        if let date = "2010-05-20 15:30:00".toDate() {
            print("Checking date:", date)
        }
        if count < capacity {
            fruits.append(fruit)
        } else {
            print("Sorry, the basket is full. Maybe get a bigger basket.")
        }
    }
}

extension Basket: CustomStringConvertible {
    public var description: String {
        var description = "Capacity: \(count)/\(capacity)"
        description += fruits.map { $0.rawValue }.joined(separator: ", ")
        return description
    }
}
