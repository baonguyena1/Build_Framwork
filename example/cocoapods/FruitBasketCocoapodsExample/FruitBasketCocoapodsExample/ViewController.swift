//
//  ViewController.swift
//  FruitBasketCocoapodsExample
//
//  Created by Bao Nguyen on 2020/10/14.
//

import UIKit
import FruitBasket

class ViewController: UIViewController {
    
    private var basket: Basket!

    override func viewDidLoad() {
        super.viewDidLoad()
        basket = Basket(3)
        basket.add(.apple)
        basket.add(.banana)
        basket.add(.orange)
        basket.add(.apple)
    }
}

