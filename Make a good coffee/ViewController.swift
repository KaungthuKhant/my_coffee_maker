//
//  ViewController.swift
//  Make a good coffee
//
//  Created by Kaung Thu Khant on 8/4/21.
//  Copyright © 2021 Kaung Thu Khant. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    // variables
    var coffee_gram = 0.0
    var brewing_time = 0 // 4 min to brew coffee
    var time_to_brew = 180
    var coffee_timer = Timer()
    var coffee_of_choice = "" // use this variable for when user choose something
    var num_gram = 0 // amount of coffee in gram that user selected
    
    // instructions on how to make coffee
    // this will be nested dictionary {"Espresso": [{"milk": 1}, {"hot water": 1}, {"foam": 1}]}\
    var instructions = [
        // milk, hot chocolate, foam
        "Mocha": [1, 1, 1],
        "Flat White": [2, 0, 0],
        "Espresso": [0, 0, 0],
        "Latte": [2, 0, 1],
        "Cappuccino": [1, 0, 1]
        // I want to work with dictionary but it only has nested array (so far)
        // so i have to work with something else
    ]
    
    
    
    
    @IBOutlet weak var SelectCoffeeBtn: UIButton!
    @IBOutlet var CoffeeBtnCollection: [UIButton]!
    
    @IBOutlet weak var gramLabel: UILabel!
    
    @IBOutlet weak var show_second_label: UILabel!
    @IBOutlet weak var TimerBar: UIProgressView!
    
    @IBOutlet weak var CoffeeChoiceLabel: UILabel!
    @IBOutlet weak var MakeCoffeeBtn: UIButton!
    
    @IBOutlet weak var Milk_Label: UILabel!
    @IBOutlet weak var Chocolate_Label: UILabel!
    @IBOutlet weak var Foam_Label: UILabel!
    @IBOutlet weak var SteamMilk: UILabel!
    @IBOutlet weak var HotChocolate: UILabel!
    @IBOutlet weak var MilkFoam: UILabel!
    
    @IBAction func CoffeeStepper(_ sender: UIStepper) {
        gramLabel.text = String(sender.value)
        num_gram = Int(sender.value)
        print(sender.value)
        coffee_gram = sender.value
    }
    
    override func viewDidLoad() {
        // hide the instructions labels
        Milk_Label.isHidden = true
        Chocolate_Label.isHidden = true
        Foam_Label.isHidden = true
        SteamMilk.isHidden = true
        HotChocolate.isHidden = true
        MilkFoam.isHidden = true
        
        // test
        
        super.viewDidLoad()
        // Make the button round
        SelectCoffeeBtn.layer.cornerRadius = SelectCoffeeBtn.frame.height / 4
        // "Make Coffee" button round
        MakeCoffeeBtn.layer.cornerRadius = MakeCoffeeBtn.frame.height / 2
        CoffeeBtnCollection.forEach { (btn) in
            btn.layer.cornerRadius = btn.frame.height / 4
            // hide those button collections
            btn.isHidden = true
            btn.alpha = 0 // what is alpha
        }
        
        // this line below does not work because it is a label
        // CoffeeChoiceLabel.layer.cornerRadius = CoffeeChoiceLabel.frame.height / 4
        // CoffeeChoiceLabel.layer.cornerRadius = 10.0
        MakeCoffeeBtn.layer.cornerRadius = MakeCoffeeBtn.frame.height / 4
        TimerBar.isHidden = true
    }

    @IBAction func SelectCoffeePressed(_ sender: UIButton) {
        CoffeeBtnCollection.forEach { (btn) in
            UIView.animate(withDuration: 0.6) {
                btn.isHidden = !btn.isHidden
                // if alpha is equal to 0, change to one: other wise, change it to 0
                btn.alpha = btn.alpha == 0 ? 1: 0
                btn.layoutIfNeeded()
            }
        }
    }
    @IBAction func CoffeePressed(_ sender: UIButton) {
        if let btnLabel = sender.titleLabel?.text{
            print(btnLabel)
            // need to figure out the dictiionary problem
            //let coffee_instruction = instructions[btnLabel]
            //let milk = coffee_instruction?[0]
            //print(milk)
            CoffeeChoiceLabel.text = btnLabel
            coffee_of_choice = btnLabel
            // SelectCoffeeBtn.titleLabel?.text = String(btnLabel)
        }
        // test for animation when coffee is pressed
        CoffeeBtnCollection.forEach { (btn) in
            UIView.animate(withDuration: 0.6) {
                btn.isHidden = !btn.isHidden
                // if alpha is equal to 0, change to one: other wise, change it to 0
                btn.alpha = btn.alpha == 0 ? 1: 0
                btn.layoutIfNeeded()
            }
        }
    }
    
    
    @IBAction func MakeCoffeePressed(_ sender: UIButton) {
        // unhidden the progress bar
        TimerBar.isHidden = false
        // reset the time needed to brew the coffee
        brewing_time = 0
        // invalidate the previous pressed timer so that updateTimer is not called two times when user pressed again
        coffee_timer.invalidate()
        coffee_timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer(){
        if brewing_time < time_to_brew {
            // time is updated after the label is updated cause I want to make
            // the progress bar start from 0
            let time_remaining = time_to_brew - brewing_time
            let min = time_remaining / 60
            let sec = time_remaining % 60
            show_second_label.text = (String(min)) + " min & " + String((sec)) + " sec"
            TimerBar.progress = Float(brewing_time) / Float(time_to_brew)
            brewing_time += 1
        }
        else{
            TimerBar.progress = 1.0
            show_second_label.text = "Done!"
            TimerBar.isHidden = true
            
            //  calculation  milk, hot chocolate, foam
            var num_cup = num_gram * (instructions[coffee_of_choice]?[0] ?? 0)
            Milk_Label.text = "" + String(num_cup)
            
            num_cup = num_gram * (instructions[coffee_of_choice]?[1] ?? 0)
            Chocolate_Label.text = "" + String(num_cup)
            
            num_cup = num_gram * (instructions[coffee_of_choice]?[2] ?? 0)
            Foam_Label.text = "" + String(num_cup)
            
            Milk_Label.isHidden = false
            Chocolate_Label.isHidden = false
            Foam_Label.isHidden = false
            SteamMilk.isHidden = false
            HotChocolate.isHidden = false
            MilkFoam.isHidden = false
        }
    }
}

