//
//  ViewController.swift
//  skiliket
//
//  Created by Team10 on 8/29/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var buttonSingIn: UIButton!
    
    @IBOutlet weak var buttonSingUp: UIButton!
    
    @IBOutlet weak var buttonForGuests: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Añadir sombra a buttonSingIn
            buttonSingIn.layer.shadowColor = UIColor.black.cgColor
            buttonSingIn.layer.shadowOffset = CGSize(width: 0, height: 2)
            buttonSingIn.layer.shadowRadius = 4
            buttonSingIn.layer.shadowOpacity = 0.3

            // Añadir sombra a buttonSingUp
            buttonSingUp.layer.shadowColor = UIColor.black.cgColor
            buttonSingUp.layer.shadowOffset = CGSize(width: 0, height: 2)
            buttonSingUp.layer.shadowRadius = 4
            buttonSingUp.layer.shadowOpacity = 0.3
            
            // Añadir sombra a buttonForGuests
            buttonForGuests.layer.shadowColor = UIColor.black.cgColor
            buttonForGuests.layer.shadowOffset = CGSize(width: 0, height: 2)
            buttonForGuests.layer.shadowRadius = 4
            buttonForGuests.layer.shadowOpacity = 0.1
        
    }


}

